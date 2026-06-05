package com.management.security;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.management.entity.Role;
import com.management.entity.RoleUser;
import com.management.entity.SysUser;
import com.management.mapper.OrganizationMapper;
import com.management.mapper.RoleMapper;
import com.management.mapper.RoleUserMapper;
import com.management.mapper.SysUserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class DataScopeHelper {

    private final SysUserMapper userMapper;
    private final RoleUserMapper roleUserMapper;
    private final RoleMapper roleMapper;
    private final OrganizationMapper organizationMapper;

    public String getEffectiveDataScope() {
        SysUser user = getCurrentUser();
        if (user == null) return "1";
        List<RoleUser> roleUsers = roleUserMapper.selectList(
                new LambdaQueryWrapper<RoleUser>().eq(RoleUser::getUserId, user.getId()));
        if (roleUsers.isEmpty()) return "1";
        List<String> roleIds = roleUsers.stream().map(RoleUser::getRoleId).collect(Collectors.toList());
        List<Role> roles = roleMapper.selectList(
                new LambdaQueryWrapper<Role>().in(Role::getId, roleIds));
        return roles.stream()
                .map(r -> r.getDataScope() != null ? r.getDataScope() : "1")
                .min(String::compareTo)
                .orElse("1");
    }

    public String getCurrentUserDeptId() {
        SysUser user = getCurrentUser();
        return user != null ? user.getDepartmentId() : null;
    }

    public String getCurrentUsername() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return auth != null ? auth.getName() : null;
    }

    public List<String> getDeptAndChildren(String deptId) {
        List<String> result = new ArrayList<>();
        result.add(deptId);
        collectChildren(deptId, result);
        return result;
    }

    private void collectChildren(String parentId, List<String> result) {
        var children = organizationMapper.selectList(
                new LambdaQueryWrapper<com.management.entity.Organization>()
                        .eq(com.management.entity.Organization::getSuperOrg, parentId));
        for (var child : children) {
            result.add(child.getId());
            collectChildren(child.getId(), result);
        }
    }

    private SysUser getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null) return null;
        return userMapper.selectOne(
                new LambdaQueryWrapper<SysUser>().eq(SysUser::getAccountNumber, auth.getName()));
    }
}
