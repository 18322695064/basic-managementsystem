package com.management.dto.user;

import com.management.entity.SysUser;

public class UserConverter {

    public static UserVO toVO(SysUser entity) {
        if (entity == null) return null;
        UserVO vo = new UserVO();
        vo.setId(entity.getId());
        vo.setAccountNumber(entity.getAccountNumber());
        vo.setNickName(entity.getNickName());
        vo.setRealName(entity.getRealName());
        vo.setEmail(entity.getEmail());
        vo.setPhoneNumber(entity.getPhoneNumber());
        vo.setDepartmentId(entity.getDepartmentId());
        vo.setAddTime(entity.getAddTime());
        vo.setLoginTime(entity.getLoginTime());
        vo.setActivateStatus(entity.getActivateStatus());
        vo.setUnitId(entity.getUnitId());
        vo.setDuty(entity.getDuty());
        vo.setSfzhm(entity.getSfzhm());
        return vo;
    }

    public static SysUser toEntity(UserCreateDTO dto) {
        if (dto == null) return null;
        SysUser entity = new SysUser();
        entity.setAccountNumber(dto.getAccountNumber());
        entity.setNickName(dto.getNickName());
        entity.setRealName(dto.getRealName());
        entity.setEmail(dto.getEmail());
        entity.setPhoneNumber(dto.getPhoneNumber());
        entity.setDepartmentId(dto.getDepartmentId());
        entity.setPassword(dto.getPassword());
        entity.setUnitId(dto.getUnitId());
        entity.setDuty(dto.getDuty());
        entity.setSfzhm(dto.getSfzhm());
        return entity;
    }

    public static void updateEntity(SysUser entity, UserUpdateDTO dto) {
        if (dto == null || entity == null) return;
        entity.setNickName(dto.getNickName());
        entity.setRealName(dto.getRealName());
        entity.setEmail(dto.getEmail());
        entity.setPhoneNumber(dto.getPhoneNumber());
        entity.setDepartmentId(dto.getDepartmentId());
        entity.setUnitId(dto.getUnitId());
        entity.setDuty(dto.getDuty());
        entity.setSfzhm(dto.getSfzhm());
        if (dto.getActivateStatus() != null) {
            entity.setActivateStatus(dto.getActivateStatus());
        }
    }
}