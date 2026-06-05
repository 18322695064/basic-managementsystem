package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.entity.SysMenu;
import com.management.mapper.SysMenuMapper;
import com.management.service.ISysMenuService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Slf4j
@Service
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements ISysMenuService {

    @Override
    public List<SysMenu> selectMenuList(Long userId) {
        LambdaQueryWrapper<SysMenu> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByAsc(SysMenu::getSortOrder);
        return list(wrapper);
    }

    @Override
    public List<SysMenu> selectMenusByPermissions(List<String> permissions) {
        log.info("selectMenusByPermissions called with {} permissions: {}", permissions.size(), permissions);
        if (permissions == null || permissions.isEmpty()) {
            log.warn("No permissions, returning empty list");
            return List.of();
        }
        LambdaQueryWrapper<SysMenu> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByAsc(SysMenu::getSortOrder);
        List<SysMenu> allMenus = list(wrapper);
        log.info("Total menus in DB: {}", allMenus.size());

        Set<Long> matchedIds = new HashSet<>();
        for (SysMenu menu : allMenus) {
            if (menu.getPerms() != null && !menu.getPerms().isEmpty()) {
                for (String perm : menu.getPerms().split(",")) {
                    if (permissions.contains(perm.trim())) {
                        matchedIds.add(menu.getId());
                        break;
                    }
                }
            }
        }
        log.info("Directly matched menu IDs: {}", matchedIds);

        for (SysMenu menu : allMenus) {
            if ("M".equals(menu.getMenuType()) && (menu.getPerms() == null || menu.getPerms().isEmpty())) {
                matchedIds.add(menu.getId());
            }
        }
        log.info("With M-type dirs: {}", matchedIds);

        Set<Long> ancestorIds = new HashSet<>();
        for (Long id : matchedIds) {
            collectAncestors(allMenus, id, ancestorIds);
        }
        matchedIds.addAll(ancestorIds);
        log.info("With ancestors: {}", matchedIds);

        List<SysMenu> result = allMenus.stream()
                .filter(menu -> matchedIds.contains(menu.getId()))
                .toList();
        log.info("Final result count: {}", result.size());
        for (SysMenu m : result) {
            log.info("  id={}, type={}, name={}", m.getId(), m.getMenuType(), m.getMenuName());
        }
        return result;
    }

    private void collectAncestors(List<SysMenu> allMenus, Long menuId, Set<Long> ancestorIds) {
        for (SysMenu menu : allMenus) {
            if (menu.getId().equals(menuId) && menu.getParentId() != 0) {
                // find parent
                for (SysMenu parent : allMenus) {
                    if (parent.getId().equals(menu.getParentId())) {
                        if (ancestorIds.add(parent.getId())) {
                            collectAncestors(allMenus, parent.getId(), ancestorIds);
                        }
                        break;
                    }
                }
                break;
            }
        }
    }

    @Override
    public boolean removeMenu(Long menuId) {
        LambdaQueryWrapper<SysMenu> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysMenu::getParentId, menuId);
        long childCount = count(wrapper);
        if (childCount > 0) {
            return false;
        }
        return removeById(menuId);
    }
}
