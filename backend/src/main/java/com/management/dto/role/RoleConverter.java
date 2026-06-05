package com.management.dto.role;

import com.management.entity.Role;

public class RoleConverter {

    public static RoleVO toVO(Role entity) {
        if (entity == null) return null;
        RoleVO vo = new RoleVO();
        vo.setId(entity.getId());
        vo.setRoleName(entity.getRoleName());
        vo.setRoleCode(entity.getRoleCode());
        vo.setRoleType(entity.getRoleType());
        vo.setRoleSystem(entity.getRoleSystem());
        vo.setRemarks(entity.getRemarks());
        vo.setDataScope(entity.getDataScope());
        vo.setCreateTime(entity.getCreateTime());
        vo.setMenuIds(entity.getMenuIds());
        return vo;
    }

    public static Role toEntity(RoleCreateDTO dto) {
        if (dto == null) return null;
        Role entity = new Role();
        entity.setRoleName(dto.getRoleName());
        entity.setRoleCode(dto.getRoleCode());
        entity.setRoleType(dto.getRoleType());
        entity.setRoleSystem(dto.getRoleSystem());
        entity.setRemarks(dto.getRemarks());
        entity.setMenuIds(dto.getMenuIds());
        return entity;
    }

    public static void updateEntity(Role entity, RoleUpdateDTO dto) {
        if (dto == null || entity == null) return;
        entity.setRoleName(dto.getRoleName());
        entity.setRoleCode(dto.getRoleCode());
        entity.setRoleType(dto.getRoleType());
        entity.setRoleSystem(dto.getRoleSystem());
        entity.setRemarks(dto.getRemarks());
        if (dto.getMenuIds() != null) {
            entity.setMenuIds(dto.getMenuIds());
        }
    }
}