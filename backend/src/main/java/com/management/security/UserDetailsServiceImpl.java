package com.management.security;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.management.entity.Role;
import com.management.entity.RoleMenu;
import com.management.entity.RoleUser;
import com.management.entity.SysMenu;
import com.management.entity.SysUser;
import com.management.mapper.RoleMapper;
import com.management.mapper.RoleMenuMapper;
import com.management.mapper.RoleUserMapper;
import com.management.mapper.SysMenuMapper;
import com.management.mapper.SysUserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final SysUserMapper userMapper;
    private final RoleUserMapper roleUserMapper;
    private final RoleMenuMapper roleMenuMapper;
    private final RoleMapper roleMapper;
    private final SysMenuMapper menuMapper;
    private final RedisTemplate<String, Object> redisTemplate;

    private static final String PERMISSION_CACHE_KEY = "user_permissions:";
    private static final String ROLE_CACHE_KEY = "user_roles:";
    private static final long CACHE_DURATION = 30;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        LambdaQueryWrapper<SysUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysUser::getAccountNumber, username);
        SysUser user = userMapper.selectOne(wrapper);

        if (user == null) {
            throw new UsernameNotFoundException("用户不存在: " + username);
        }

        Set<SimpleGrantedAuthority> authorities = new HashSet<>();
        List<String> roleKeys = getUserRoleKeys(user.getId());
        List<String> permissions = getUserPermissions(user.getId());

        for (String roleKey : roleKeys) {
            authorities.add(new SimpleGrantedAuthority("ROLE_" + roleKey));
        }
        for (String perm : permissions) {
            if (perm != null && !perm.isEmpty()) {
                authorities.add(new SimpleGrantedAuthority(perm));
            }
        }

        if (authorities.isEmpty()) {
            authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        }

        boolean enabled = user.getActivateStatus() == null || "1".equals(user.getActivateStatus());

        return new User(
                user.getAccountNumber(),
                user.getPassword(),
                enabled,
                true,
                true,
                true,
                authorities
        );
    }

    @SuppressWarnings("unchecked")
    public List<String> getUserRoleKeys(String userId) {
        String cacheKey = ROLE_CACHE_KEY + userId;
        List<String> cached = (List<String>) redisTemplate.opsForValue().get(cacheKey);
        if (cached != null) {
            return cached;
        }

        LambdaQueryWrapper<RoleUser> ruWrapper = new LambdaQueryWrapper<>();
        ruWrapper.eq(RoleUser::getUserId, userId);
        List<RoleUser> roleUsers = roleUserMapper.selectList(ruWrapper);

        if (CollectionUtils.isEmpty(roleUsers)) {
            return new ArrayList<>();
        }

        List<String> roleIds = roleUsers.stream()
                .map(RoleUser::getRoleId)
                .collect(Collectors.toList());

        LambdaQueryWrapper<Role> roleWrapper = new LambdaQueryWrapper<>();
        roleWrapper.in(Role::getId, roleIds);
        List<Role> roles = roleMapper.selectList(roleWrapper);

        List<String> roleKeys = roles.stream()
                .map(Role::getRoleCode)
                .collect(Collectors.toList());

        redisTemplate.opsForValue().set(cacheKey, roleKeys, CACHE_DURATION, TimeUnit.MINUTES);
        return roleKeys;
    }

    @SuppressWarnings("unchecked")
    public List<String> getUserPermissions(String userId) {
        String cacheKey = PERMISSION_CACHE_KEY + userId;
        List<String> cached = (List<String>) redisTemplate.opsForValue().get(cacheKey);
        if (cached != null) {
            return cached;
        }

        LambdaQueryWrapper<RoleUser> ruWrapper = new LambdaQueryWrapper<>();
        ruWrapper.eq(RoleUser::getUserId, userId);
        List<RoleUser> roleUsers = roleUserMapper.selectList(ruWrapper);

        if (CollectionUtils.isEmpty(roleUsers)) {
            return new ArrayList<>();
        }

        List<String> roleIds = roleUsers.stream()
                .map(RoleUser::getRoleId)
                .collect(Collectors.toList());

        LambdaQueryWrapper<RoleMenu> rmWrapper = new LambdaQueryWrapper<>();
        rmWrapper.in(RoleMenu::getRoleId, roleIds);
        List<RoleMenu> roleMenus = roleMenuMapper.selectList(rmWrapper);

        if (CollectionUtils.isEmpty(roleMenus)) {
            return new ArrayList<>();
        }

        List<Long> menuIds = roleMenus.stream()
                .map(RoleMenu::getMenuId)
                .collect(Collectors.toList());

        LambdaQueryWrapper<SysMenu> menuWrapper = new LambdaQueryWrapper<>();
        menuWrapper.in(SysMenu::getId, menuIds);
        menuWrapper.isNotNull(SysMenu::getPerms);
        menuWrapper.ne(SysMenu::getPerms, "");
        List<SysMenu> menus = menuMapper.selectList(menuWrapper);

        List<String> permissions = menus.stream()
                .map(SysMenu::getPerms)
                .filter(perm -> perm != null && !perm.isEmpty())
                .distinct()
                .collect(Collectors.toList());

        redisTemplate.opsForValue().set(cacheKey, permissions, CACHE_DURATION, TimeUnit.MINUTES);
        return permissions;
    }

    public void clearUserCache(String userId) {
        redisTemplate.delete(ROLE_CACHE_KEY + userId);
        redisTemplate.delete(PERMISSION_CACHE_KEY + userId);
    }
}