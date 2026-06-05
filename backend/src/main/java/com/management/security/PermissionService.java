package com.management.security;

import com.management.entity.RoleMenu;
import com.management.entity.RoleUser;
import com.management.entity.SysMenu;
import com.management.mapper.RoleMenuMapper;
import com.management.mapper.RoleUserMapper;
import com.management.mapper.SysMenuMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service("ss")
@RequiredArgsConstructor
public class PermissionService {

    private final RoleUserMapper roleUserMapper;
    private final RoleMenuMapper roleMenuMapper;
    private final SysMenuMapper menuMapper;

    public boolean hasPermi(String permission) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return false;
        }

        Set<String> permissions = getCurrentUserPermissions();
        if (permissions.contains("*:*:*")) {
            return true;
        }

        return permissions.contains(permission);
    }

    public boolean hasRole(String role) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return false;
        }

        return authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_" + role));
    }

    private Set<String> getCurrentUserPermissions() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        Set<String> permsSet = new HashSet<>();
        permsSet.addAll(authentication.getAuthorities().stream()
                .map(auth -> auth.getAuthority())
                .filter(auth -> !auth.startsWith("ROLE_"))
                .toList());

        return permsSet;
    }
}
