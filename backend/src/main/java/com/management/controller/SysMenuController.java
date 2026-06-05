package com.management.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.management.annotation.Log;
import com.management.common.Result;
import com.management.entity.SysMenu;
import com.management.service.ISysMenuService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/system/menu")
@RequiredArgsConstructor
public class SysMenuController {

    private final ISysMenuService menuService;

    @PreAuthorize("@ss.hasPermi('system:menu:list') or @ss.hasPermi('system:menu:query')")
    @Log(module = "菜单管理", businessType = 4, description = "查询菜单列表")
    @GetMapping("/list")
    public Result<List<SysMenu>> list(@RequestParam(required = false) String menuName,
                                       @RequestParam(required = false) String status) {
        LambdaQueryWrapper<SysMenu> wrapper = new LambdaQueryWrapper<>();
        if (menuName != null && !menuName.isEmpty()) {
            wrapper.like(SysMenu::getMenuName, menuName);
        }
        if (status != null && !status.isEmpty()) {
            wrapper.eq(SysMenu::getStatus, status);
        }
        wrapper.orderByAsc(SysMenu::getSortOrder);
        return Result.success(menuService.list(wrapper));
    }

    @PreAuthorize("@ss.hasPermi('system:menu:query')")
    @Log(module = "菜单管理", businessType = 4, description = "查询菜单详情")
    @GetMapping("/{menuId}")
    public Result<SysMenu> getInfo(@PathVariable Long menuId) {
        SysMenu menu = menuService.getById(menuId);
        if (menu == null) {
            return Result.error("菜单不存在");
        }
        return Result.success(menu);
    }

    @PreAuthorize("@ss.hasPermi('system:menu:add')")
    @Log(module = "菜单管理", businessType = 1, description = "新增菜单")
    @PostMapping
    public Result<Void> add(@RequestBody SysMenu menu) {
        menuService.save(menu);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:menu:edit')")
    @Log(module = "菜单管理", businessType = 2, description = "修改菜单")
    @PutMapping
    public Result<Void> edit(@RequestBody SysMenu menu) {
        menuService.updateById(menu);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:menu:remove')")
    @Log(module = "菜单管理", businessType = 3, description = "删除菜单")
    @DeleteMapping("/{menuId}")
    public Result<Void> remove(@PathVariable Long menuId) {
        if (!menuService.removeMenu(menuId)) {
            return Result.error("存在子菜单，不允许删除");
        }
        return Result.success();
    }
}