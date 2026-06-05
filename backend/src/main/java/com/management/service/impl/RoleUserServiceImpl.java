package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.entity.RoleUser;
import com.management.mapper.RoleUserMapper;
import com.management.security.UserDetailsServiceImpl;
import com.management.service.IRoleUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RoleUserServiceImpl extends ServiceImpl<RoleUserMapper, RoleUser> implements IRoleUserService {

    private final UserDetailsServiceImpl userDetailsService;

    @Override
    public void saveUserRole(String userId, String roleId) {
        if (roleId == null || roleId.isEmpty()) return;
        RoleUser roleUser = new RoleUser();
        roleUser.setId(UUID.randomUUID().toString().replace("-", ""));
        roleUser.setUserId(userId);
        roleUser.setRoleId(roleId);
        save(roleUser);
        userDetailsService.clearUserCache(userId);
    }

    @Override
    public void updateUserRoles(String userId, List<String> roleIds) {
        deleteByUserId(userId);
        if (roleIds != null && !roleIds.isEmpty()) {
            for (String roleId : roleIds) {
                RoleUser roleUser = new RoleUser();
                roleUser.setId(UUID.randomUUID().toString().replace("-", ""));
                roleUser.setUserId(userId);
                roleUser.setRoleId(roleId);
                save(roleUser);
            }
        }
        userDetailsService.clearUserCache(userId);
    }

    @Override
    public void deleteByUserId(String userId) {
        LambdaQueryWrapper<RoleUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RoleUser::getUserId, userId);
        remove(wrapper);
        userDetailsService.clearUserCache(userId);
    }

    @Override
    public List<String> getRoleIdsByUserId(String userId) {
        LambdaQueryWrapper<RoleUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RoleUser::getUserId, userId);
        List<RoleUser> list = list(wrapper);
        return list.stream().map(RoleUser::getRoleId).collect(Collectors.toList());
    }

    @Override
    public String getRoleIdByUserId(String userId) {
        LambdaQueryWrapper<RoleUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RoleUser::getUserId, userId);
        RoleUser roleUser = getOne(wrapper, false);
        return roleUser != null ? roleUser.getRoleId() : null;
    }
}