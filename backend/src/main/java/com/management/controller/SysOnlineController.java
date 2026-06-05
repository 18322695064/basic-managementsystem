package com.management.controller;

import com.management.common.Result;
import com.management.security.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/monitor/online")
@RequiredArgsConstructor
public class SysOnlineController {

    private final RedisTemplate<String, Object> redisTemplate;
    private final JwtTokenProvider jwtTokenProvider;

    @PreAuthorize("@ss.hasPermi('monitor:online:list')")
    @GetMapping("/list")
    public Result<List<Map<String, Object>>> list() {
        Set<String> keys = redisTemplate.keys("token:*");
        List<Map<String, Object>> onlineUsers = new ArrayList<>();

        if (keys != null) {
            for (String key : keys) {
                String userId = key.substring("token:".length());
                String token = (String) redisTemplate.opsForValue().get(key);
                if (token != null) {
                    try {
                        String username = jwtTokenProvider.getUsernameFromToken(token);
                        Long expire = redisTemplate.getExpire(key, TimeUnit.SECONDS);

                        Map<String, Object> userInfo = Map.of(
                            "userId", userId,
                            "userName", username,
                            "tokenKey", key,
                            "expireSeconds", expire != null ? expire : 0
                        );
                        onlineUsers.add(userInfo);
                    } catch (Exception e) {
                        redisTemplate.delete(key);
                    }
                }
            }
        }
        return Result.success(onlineUsers);
    }

    @PreAuthorize("@ss.hasPermi('monitor:online:forceLogout')")
    @DeleteMapping("/{tokenKey}")
    public Result<Void> forceLogout(@PathVariable String tokenKey) {
        String key = "token:" + tokenKey;
        if (Boolean.TRUE.equals(redisTemplate.hasKey(key))) {
            redisTemplate.delete(key);
            return Result.success();
        }
        return Result.error("用户已离线");
    }
}
