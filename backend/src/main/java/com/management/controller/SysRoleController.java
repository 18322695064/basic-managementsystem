package com.management.controller;

import com.management.annotation.Log;
import com.management.common.PageResult;
import com.management.common.Result;
import com.management.dto.role.RoleCreateDTO;
import com.management.dto.role.RoleQueryDTO;
import com.management.dto.role.RoleUpdateDTO;
import com.management.dto.role.RoleVO;
import com.management.entity.Role;
import com.management.service.IRoleService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/system/role")
@RequiredArgsConstructor
public class SysRoleController {

    private final IRoleService roleService;

    @PreAuthorize("@ss.hasPermi('system:role:list') or @ss.hasPermi('system:role:query')")
    @Log(module = "角色管理", businessType = 4, description = "查询角色列表")
    @GetMapping("/list")
    public Result<PageResult<RoleVO>> list(RoleQueryDTO queryDTO) {
        return Result.success(roleService.pageRoles(queryDTO));
    }

    @PreAuthorize("@ss.hasPermi('system:role:query')")
    @Log(module = "角色管理", businessType = 4, description = "查询角色详情")
    @GetMapping("/{roleId}")
    public Result<RoleVO> getInfo(@PathVariable String roleId) {
        RoleVO role = roleService.getRoleById(roleId);
        if (role == null) {
            return Result.error("角色不存在");
        }
        return Result.success(role);
    }

    @PreAuthorize("@ss.hasPermi('system:role:add')")
    @Log(module = "角色管理", businessType = 1, description = "新增角色")
    @PostMapping
    public Result<Void> add(@Valid @RequestBody RoleCreateDTO dto) {
        roleService.addRole(dto);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:role:edit')")
    @Log(module = "角色管理", businessType = 2, description = "修改角色")
    @PutMapping
    public Result<Void> edit(@Valid @RequestBody RoleUpdateDTO dto) {
        try {
            roleService.updateRole(dto);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    @PreAuthorize("@ss.hasPermi('system:role:remove')")
    @Log(module = "角色管理", businessType = 3, description = "删除角色")
    @DeleteMapping("/{roleIds}")
    public Result<Void> remove(@PathVariable String roleIds) {
        try {
            roleService.deleteRoles(Arrays.asList(roleIds.split(",")));
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    @PreAuthorize("@ss.hasPermi('system:role:edit')")
    @Log(module = "角色管理", businessType = 2, description = "修改数据权限")
    @PutMapping("/dataScope")
    public Result<Void> dataScope(@RequestBody Role role) {
        try {
            roleService.updateDataScope(role);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    @GetMapping("/optionselect")
    public Result<List<Role>> optionselect() {
        return Result.success(roleService.getRoleOptionSelect());
    }

    @PreAuthorize("@ss.hasPermi('system:role:edit')")
    @Log(module = "角色管理", businessType = 2, description = "修改菜单权限")
    @PutMapping("/menuPerms")
    public Result<Void> menuPerms(@RequestBody Map<String, Object> params) {
        String roleId = String.valueOf(params.get("id"));
        @SuppressWarnings("unchecked")
        List<?> rawIds = (List<?>) params.get("menuIds");
        List<Long> menuIds = rawIds != null 
                ? rawIds.stream().map(id -> {
                    if (id instanceof Number) {
                        return ((Number) id).longValue();
                    }
                    return Long.parseLong(id.toString());
                }).toList() 
                : List.of();
        roleService.updateMenuPerms(roleId, menuIds);
        return Result.success();
    }
}