package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.entity.RoleUser;

import java.util.List;

public interface IRoleUserService extends IService<RoleUser> {

    void saveUserRole(String userId, String roleId);

    void updateUserRoles(String userId, List<String> roleIds);

    void deleteByUserId(String userId);

    List<String> getRoleIdsByUserId(String userId);

    String getRoleIdByUserId(String userId);
}