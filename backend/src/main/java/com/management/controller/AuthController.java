package com.management.controller;

import com.management.annotation.Log;
import com.management.annotation.RateLimit;
import com.management.common.Result;
import com.management.entity.SysLoginLog;
import com.management.entity.SysMenu;
import com.management.entity.SysUser;
import com.management.security.JwtTokenProvider;
import com.management.security.UserDetailsServiceImpl;
import com.management.service.ISysLoginLogService;
import com.management.service.ISysMenuService;
import com.management.service.ISysUserService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final JwtTokenProvider jwtTokenProvider;
    private final ISysUserService userService;
    private final ISysLoginLogService loginLogService;
    private final PasswordEncoder passwordEncoder;
    private final RedisTemplate<String, Object> redisTemplate;
    private final UserDetailsServiceImpl userDetailsService;
    private final ISysMenuService menuService;

    private static final int MAX_LOGIN_ATTEMPTS = 5;
    private static final long LOCK_DURATION_MINUTES = 10;

    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,20}$");

    @RateLimit(time = 60, count = 10, message = "登录请求过于频繁，请稍后再试")
    @PostMapping("/login")
    public Result<Map<String, Object>> login(@RequestBody LoginRequest request, HttpServletRequest httpRequest) {
        String lockKey = "login_lock:" + request.getUsername();
        String attemptKey = "login_attempt:" + request.getUsername();

        Number attempts = (Number) redisTemplate.opsForValue().get(attemptKey);
        if (attempts != null && attempts.longValue() >= MAX_LOGIN_ATTEMPTS) {
            Long lockTime = redisTemplate.getExpire(lockKey, TimeUnit.MINUTES);
            return Result.error(401, "登录失败次数过多，请" + (lockTime != null ? lockTime : LOCK_DURATION_MINUTES) + "分钟后再试");
        }

        String captchaKey = "captcha:" + request.getUuid();
        String captcha = (String) redisTemplate.opsForValue().get(captchaKey);

        if (captcha == null || !captcha.equalsIgnoreCase(request.getCode())) {
            return Result.error("验证码错误或已过期");
        }
        redisTemplate.delete(captchaKey);

        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword())
            );
            SecurityContextHolder.getContext().setAuthentication(authentication);

            SysUser user = userService.selectUserByAccountNumber(request.getUsername());
            Map<String, Object> claims = new HashMap<>();
            String accessToken = jwtTokenProvider.createAccessToken(user.getId(), user.getAccountNumber(), claims);
            String refreshToken = jwtTokenProvider.createRefreshToken(user.getId(), user.getAccountNumber());

            redisTemplate.opsForValue().set("token:" + user.getId(), accessToken, 2, TimeUnit.HOURS);

            redisTemplate.delete(attemptKey);
            redisTemplate.delete(lockKey);

            recordLoginLog(user, httpRequest, "0", "登录成功");

            Map<String, Object> result = new HashMap<>();
            result.put("token", accessToken);
            result.put("refreshToken", refreshToken);
            result.put("expiresIn", 7200);
            return Result.success(result);
        } catch (Exception e) {
            Long currentAttempts = redisTemplate.opsForValue().increment(attemptKey);
            redisTemplate.expire(attemptKey, LOCK_DURATION_MINUTES, TimeUnit.MINUTES);

            if (currentAttempts != null && currentAttempts >= MAX_LOGIN_ATTEMPTS) {
                redisTemplate.opsForValue().set(lockKey, "1", LOCK_DURATION_MINUTES, TimeUnit.MINUTES);
                return Result.error(401, "登录失败次数过多，账户已锁定" + LOCK_DURATION_MINUTES + "分钟");
            }

            SysUser user = userService.selectUserByAccountNumber(request.getUsername());
            if (user != null) {
                recordLoginLog(user, httpRequest, "1", e.getMessage());
            }
            return Result.error("用户名或密码错误");
        }
    }

    @PostMapping("/refresh")
    public Result<Map<String, Object>> refreshToken(@RequestBody RefreshTokenRequest request) {
        if (request.getRefreshToken() == null || request.getRefreshToken().isEmpty()) {
            return Result.error(401, "刷新令牌不能为空");
        }

        try {
            String userId = jwtTokenProvider.getUserIdFromToken(request.getRefreshToken());
            if (!jwtTokenProvider.validateRefreshToken(userId, request.getRefreshToken())) {
                return Result.error(401, "刷新令牌无效或已过期");
            }

            SysUser user = userService.getById(userId);
            if (user == null) {
                return Result.error(401, "用户不存在");
            }

            Map<String, Object> claims = new HashMap<>();
            String newAccessToken = jwtTokenProvider.createAccessToken(userId, user.getAccountNumber(), claims);
            String newRefreshToken = jwtTokenProvider.createRefreshToken(userId, user.getAccountNumber());

            jwtTokenProvider.revokeRefreshToken(userId);

            redisTemplate.opsForValue().set("token:" + userId, newAccessToken, 2, TimeUnit.HOURS);

            Map<String, Object> result = new HashMap<>();
            result.put("token", newAccessToken);
            result.put("refreshToken", newRefreshToken);
            result.put("expiresIn", 7200);
            return Result.success(result);
        } catch (Exception e) {
            return Result.error(401, "刷新令牌无效或已过期");
        }
    }

    @GetMapping("/captchaImage")
    public Result<Map<String, String>> captchaImage() {
        String uuid = UUID.randomUUID().toString();
        String code = generateCaptchaCode();

        redisTemplate.opsForValue().set("captcha:" + uuid, code, 2, TimeUnit.MINUTES);

        Map<String, String> result = new HashMap<>();
        result.put("uuid", uuid);
        result.put("img", "data:image/png;base64," + generateCaptchaImage(code));
        return Result.success(result);
    }

    @Log(module = "认证管理", businessType = 4, description = "获取用户信息")
    @GetMapping("/getInfo")
    public Result<Map<String, Object>> getInfo() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        SysUser user = userService.selectUserByAccountNumber(username);

        List<String> roleKeys = userDetailsService.getUserRoleKeys(user.getId());
        List<String> permissions = userDetailsService.getUserPermissions(user.getId());

        if (roleKeys.isEmpty()) {
            roleKeys = Collections.singletonList("user");
        }
        if (permissions.isEmpty()) {
            permissions = Collections.singletonList("*:*:*");
        }

        Map<String, Object> result = new HashMap<>();
        result.put("user", user);
        result.put("roles", roleKeys.toArray(new String[0]));
        result.put("permissions", permissions.toArray(new String[0]));
        return Result.success(result);
    }

    @Log(module = "认证管理", businessType = 4, description = "获取路由信息")
    @GetMapping("/getRouters")
    public Result<Object> getRouters() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        SysUser user = userService.selectUserByAccountNumber(username);

        List<String> permissions = userDetailsService.getUserPermissions(user.getId());
        boolean isAdmin = permissions.contains("*:*:*");

        List<SysMenu> menus;
        if (isAdmin) {
            menus = menuService.selectMenuList(null);
        } else {
            menus = menuService.selectMenusByPermissions(permissions);
        }

        List<Map<String, Object>> routerTree = buildMenuTree(menus, 0L);
        return Result.success(routerTree);
    }

    private List<Map<String, Object>> buildMenuTree(List<SysMenu> menus, Long parentId) {
        List<Map<String, Object>> tree = new ArrayList<>();
        for (SysMenu menu : menus) {
            if (parentId.equals(menu.getParentId()) && ("M".equals(menu.getMenuType()) || "C".equals(menu.getMenuType()))) {
                Map<String, Object> node = new HashMap<>();
                node.put("name", menu.getMenuName());
                node.put("path", menu.getPath());
                node.put("hidden", "1".equals(menu.getVisible()));
                node.put("component", menu.getComponent());
                node.put("meta", Map.of(
                        "title", menu.getMenuName() != null ? menu.getMenuName() : "",
                        "icon", menu.getIcon() != null ? menu.getIcon() : "",
                        "noCache", false
                ));

                List<Map<String, Object>> children = buildMenuTree(menus, menu.getId());
                // 子菜单的 path 拼接上级 path
                for (Map<String, Object> child : children) {
                    child.put("path", node.get("path") + "/" + child.get("path"));
                }
                if (!children.isEmpty()) {
                    node.put("children", children);
                }
                tree.add(node);
            }
        }
        return tree;
    }

    @PostMapping("/logout")
    public Result<Void> logout(HttpServletRequest request) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            String username = authentication.getName();
        SysUser user = userService.selectUserByAccountNumber(username);
        if (user == null) {
            return Result.error(401, "用户不存在");
        }
            if (user != null) {
                String token = extractToken(request);
                if (token != null) {
                    jwtTokenProvider.blacklistToken(token);
                }
                jwtTokenProvider.revokeRefreshToken(user.getId());
                redisTemplate.delete("token:" + user.getId());
            }
        }
        SecurityContextHolder.clearContext();
        return Result.success();
    }

    @Log(module = "认证管理", businessType = 2, description = "修改密码")
    @PutMapping("/updatePwd")
    public Result<Void> updatePwd(@RequestBody Map<String, String> params, HttpServletRequest request) {
        String oldPassword = params.get("oldPassword");
        String newPassword = params.get("newPassword");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        SysUser user = userService.selectUserByAccountNumber(username);

        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            return Result.error("原密码错误");
        }
        if (passwordEncoder.matches(newPassword, user.getPassword())) {
            return Result.error("新密码不能与原密码相同");
        }

        if (!PASSWORD_PATTERN.matcher(newPassword).matches()) {
            return Result.error("密码必须包含大小写字母、数字和特殊字符，长度8-20位");
        }

        SysUser updateUser = new SysUser();
        updateUser.setId(user.getId());
        updateUser.setPassword(passwordEncoder.encode(newPassword));
        userService.updateById(updateUser);

        String token = extractToken(request);
        if (token != null) {
            jwtTokenProvider.blacklistToken(token);
        }
        jwtTokenProvider.revokeRefreshToken(user.getId());
        redisTemplate.delete("token:" + user.getId());
        return Result.success();
    }

    @Log(module = "认证管理", businessType = 2, description = "修改个人信息")
    @PutMapping("/updateProfile")
    public Result<Void> updateProfile(@RequestBody SysUser user) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        SysUser currentUser = userService.selectUserByAccountNumber(username);

        SysUser updateUser = new SysUser();
        updateUser.setId(currentUser.getId());
        updateUser.setNickName(user.getNickName());
        updateUser.setEmail(user.getEmail());
        updateUser.setPhoneNumber(user.getPhoneNumber());
        userService.updateById(updateUser);
        return Result.success();
    }

    private String extractToken(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }

    private void recordLoginLog(SysUser user, HttpServletRequest request, String status, String msg) {
        SysLoginLog log = new SysLoginLog();
        try {
            log.setUserId(Long.parseLong(user.getId()));
        } catch (NumberFormatException e) {
            log.setUserId(0L);
        }
        log.setAccountNumber(user.getAccountNumber());
        log.setLoginIp(getIpAddress(request));
        log.setLoginStatus(status);
        log.setMsg(msg);
        log.setLoginTime(LocalDateTime.now());
        loginLogService.save(log);
    }

    private String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    private String generateCaptchaCode() {
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 4; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    private String generateCaptchaImage(String code) {
        int width = 120;
        int height = 40;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        Random random = new Random();

        g.setColor(new Color(240, 240, 240));
        g.fillRect(0, 0, width, height);

        g.setFont(new Font("Arial", Font.BOLD, 24));
        g.setColor(new Color(random.nextInt(100), random.nextInt(100), random.nextInt(100)));
        g.drawString(code, 20, 28);

        for (int i = 0; i < 20; i++) {
            g.setColor(new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255)));
            g.drawLine(random.nextInt(width), random.nextInt(height), random.nextInt(width), random.nextInt(height));
        }

        g.dispose();

        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            ImageIO.write(image, "png", baos);
            return Base64.getEncoder().encodeToString(baos.toByteArray());
        } catch (IOException e) {
            return "";
        }
    }

    @Data
    public static class LoginRequest {
        private String username;
        private String password;
        private String code;
        private String uuid;
    }

    @Data
    public static class RefreshTokenRequest {
        private String refreshToken;
    }
}