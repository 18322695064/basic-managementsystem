package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.common.PageResult;
import com.management.dto.role.*;
import com.management.entity.Role;
import com.management.entity.RoleUser;
import com.management.mapper.RoleMapper;
import com.management.mapper.RoleUserMapper;
import com.management.service.IRoleMenuService;
import com.management.service.IRoleService;
import com.management.security.UserDetailsServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    private final RoleUserMapper roleUserMapper;
    private final IRoleMenuService roleMenuService;
    private final UserDetailsServiceImpl userDetailsService;

    @Override
    public PageResult<RoleVO> pageRoles(RoleQueryDTO queryDTO) {
        Page<Role> page = new Page<>(queryDTO.getPageNum(), queryDTO.getPageSize());
        LambdaQueryWrapper<Role> wrapper = new LambdaQueryWrapper<>();

        if (queryDTO.getRoleName() != null && !queryDTO.getRoleName().isEmpty()) {
            wrapper.like(Role::getRoleName, queryDTO.getRoleName());
        }
        if (queryDTO.getRoleKey() != null && !queryDTO.getRoleKey().isEmpty()) {
            wrapper.like(Role::getRoleCode, queryDTO.getRoleKey());
        }
        wrapper.orderByDesc(Role::getCreateTime);

        Page<Role> result = page(page, wrapper);
        List<RoleVO> voList = result.getRecords().stream()
                .map(RoleConverter::toVO)
                .collect(Collectors.toList());
        return new PageResult<>(result.getTotal(), voList);
    }

    @Override
    public RoleVO getRoleById(String roleId) {
        Role role = getById(roleId);
        if (role == null) return null;
        List<Long> menuIds = roleMenuService.getMenuIdsByRoleId(roleId);
        role.setMenuIds(menuIds);
        return RoleConverter.toVO(role);
    }

    @Override
    @Transactional
    public void addRole(RoleCreateDTO dto) {
        Role role = RoleConverter.toEntity(dto);
        role.setId(UUID.randomUUID().toString().replace("-", ""));
        role.setCreateTime(LocalDateTime.now());
        save(role);

        if (dto.getMenuIds() != null && !dto.getMenuIds().isEmpty()) {
            roleMenuService.saveRoleMenus(role.getId(), dto.getMenuIds());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateRole(RoleUpdateDTO dto) {
        Role role = getById(dto.getId());
        if (role == null) {
            throw new RuntimeException("角色不存在");
        }
        RoleConverter.updateEntity(role, dto);
        updateById(role);

        if (dto.getMenuIds() != null) {
            roleMenuService.updateRoleMenus(dto.getId(), dto.getMenuIds());
            // clear cache for all users with this role
            LambdaQueryWrapper<RoleUser> ruWrapper = new LambdaQueryWrapper<>();
            ruWrapper.eq(RoleUser::getRoleId, dto.getId());
            List<RoleUser> roleUsers = roleUserMapper.selectList(ruWrapper);
            for (RoleUser ru : roleUsers) {
                userDetailsService.clearUserCache(ru.getUserId());
            }
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteRoles(List<String> roleIds) {
        for (String id : roleIds) {
            LambdaQueryWrapper<RoleUser> ruWrapper = new LambdaQueryWrapper<>();
            ruWrapper.eq(RoleUser::getRoleId, id);
            Long userCount = roleUserMapper.selectCount(ruWrapper);
            if (userCount > 0) {
                Role role = getById(id);
                throw new RuntimeException("角色【" + (role != null ? role.getRoleName() : id) + "】已分配给用户，不能删除");
            }

            roleMenuService.deleteByRoleId(id);
            removeById(id);
        }
    }

    @Override
    public void updateDataScope(Role role) {
        Role entity = getById(role.getId());
        if (entity == null) {
            throw new RuntimeException("角色不存在");
        }
        entity.setDataScope(role.getDataScope());
        updateById(entity);
    }

    @Override
    public void updateMenuPerms(String roleId, List<Long> menuIds) {
        roleMenuService.updateRoleMenus(roleId, menuIds);
        // clear cache for all users with this role
        LambdaQueryWrapper<RoleUser> ruWrapper = new LambdaQueryWrapper<>();
        ruWrapper.eq(RoleUser::getRoleId, roleId);
        List<RoleUser> roleUsers = roleUserMapper.selectList(ruWrapper);
        for (RoleUser ru : roleUsers) {
            userDetailsService.clearUserCache(ru.getUserId());
        }
    }

    @Override
    public List<Role> getRoleOptionSelect() {
        LambdaQueryWrapper<Role> wrapper = new LambdaQueryWrapper<>();
        wrapper.select(Role::getId, Role::getRoleName);
        wrapper.orderByDesc(Role::getCreateTime);
        return list(wrapper);
    }
}