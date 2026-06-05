package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.entity.RoleMenu;

import java.util.List;

public interface IRoleMenuService extends IService<RoleMenu> {

    void saveRoleMenus(String roleId, List<Long> menuIds);

    void updateRoleMenus(String roleId, List<Long> menuIds);

    void deleteByRoleId(String roleId);

    List<Long> getMenuIdsByRoleId(String roleId);
}