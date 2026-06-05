package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.common.PageResult;
import com.management.dto.role.*;
import com.management.entity.Role;

import java.util.List;

public interface IRoleService extends IService<Role> {

    PageResult<RoleVO> pageRoles(RoleQueryDTO queryDTO);

    RoleVO getRoleById(String roleId);

    void addRole(RoleCreateDTO dto);

    void updateRole(RoleUpdateDTO dto);

    void deleteRoles(List<String> roleIds);

    void updateDataScope(Role role);

    void updateMenuPerms(String roleId, List<Long> menuIds);

    List<Role> getRoleOptionSelect();
}