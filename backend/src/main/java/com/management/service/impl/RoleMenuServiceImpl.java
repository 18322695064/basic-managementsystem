package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.entity.RoleMenu;
import com.management.mapper.RoleMenuMapper;
import com.management.service.IRoleMenuService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleMenuServiceImpl extends ServiceImpl<RoleMenuMapper, RoleMenu> implements IRoleMenuService {

    @Override
    public void saveRoleMenus(String roleId, List<Long> menuIds) {
        if (menuIds == null || menuIds.isEmpty()) return;
        for (Long menuId : menuIds) {
            RoleMenu roleMenu = new RoleMenu();
            roleMenu.setRoleId(roleId);
            roleMenu.setMenuId(menuId);
            save(roleMenu);
        }
    }

    @Override
    public void updateRoleMenus(String roleId, List<Long> menuIds) {
        deleteByRoleId(roleId);
        saveRoleMenus(roleId, menuIds);
    }

    @Override
    public void deleteByRoleId(String roleId) {
        LambdaQueryWrapper<RoleMenu> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RoleMenu::getRoleId, roleId);
        remove(wrapper);
    }

    @Override
    public List<Long> getMenuIdsByRoleId(String roleId) {
        LambdaQueryWrapper<RoleMenu> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RoleMenu::getRoleId, roleId);
        return list(wrapper).stream().map(RoleMenu::getMenuId).toList();
    }
}