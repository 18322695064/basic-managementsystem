package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.common.PageResult;
import com.management.dto.user.*;
import com.management.entity.RoleUser;
import com.management.entity.SysUser;
import com.management.entity.Organization;
import com.management.mapper.SysUserMapper;
import com.management.mapper.OrganizationMapper;
import com.management.security.DataScopeHelper;
import com.management.service.IRoleUserService;
import com.management.service.ISysUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements ISysUserService {

    private final PasswordEncoder passwordEncoder;
    private final IRoleUserService roleUserService;
    private final OrganizationMapper organizationMapper;
    private final DataScopeHelper dataScopeHelper;

    @Override
    public SysUser selectUserByAccountNumber(String accountNumber) {
        LambdaQueryWrapper<SysUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysUser::getAccountNumber, accountNumber);
        return getOne(wrapper);
    }

    @Override
    public PageResult<UserVO> pageUsers(UserQueryDTO queryDTO) {
        Page<SysUser> page = new Page<>(queryDTO.getPageNum(), queryDTO.getPageSize());
        LambdaQueryWrapper<SysUser> wrapper = new LambdaQueryWrapper<>();

        if (queryDTO.getUsername() != null && !queryDTO.getUsername().isEmpty()) {
            wrapper.like(SysUser::getAccountNumber, queryDTO.getUsername());
        }
        if (queryDTO.getNickname() != null && !queryDTO.getNickname().isEmpty()) {
            wrapper.like(SysUser::getNickName, queryDTO.getNickname());
        }
        if (queryDTO.getStatus() != null && !queryDTO.getStatus().isEmpty()) {
            wrapper.eq(SysUser::getActivateStatus, queryDTO.getStatus());
        }
        if (queryDTO.getDeptId() != null && !queryDTO.getDeptId().isEmpty()) {
            wrapper.eq(SysUser::getDepartmentId, queryDTO.getDeptId());
        }
        if (queryDTO.getPhoneNumber() != null && !queryDTO.getPhoneNumber().isEmpty()) {
            wrapper.eq(SysUser::getPhoneNumber, queryDTO.getPhoneNumber());
        }

        String dataScope = dataScopeHelper.getEffectiveDataScope();
        switch (dataScope) {
            case "2":
                String deptId = dataScopeHelper.getCurrentUserDeptId();
                if (deptId != null) wrapper.eq(SysUser::getDepartmentId, deptId);
                break;
            case "3":
                String deptId2 = dataScopeHelper.getCurrentUserDeptId();
                if (deptId2 != null) {
                    List<String> deptIds = dataScopeHelper.getDeptAndChildren(deptId2);
                    wrapper.in(SysUser::getDepartmentId, deptIds);
                }
                break;
            case "4":
                String username = dataScopeHelper.getCurrentUsername();
                if (username != null) wrapper.eq(SysUser::getCreateBy, username);
                break;
            default:
                break;
        }

        wrapper.orderByDesc(SysUser::getAddTime);

        Page<SysUser> result = page(page, wrapper);
        List<UserVO> voList = result.getRecords().stream()
                .map(user -> {
                    UserVO vo = UserConverter.toVO(user);
                    vo.setRoleIds(roleUserService.getRoleIdsByUserId(user.getId()));
                    if (user.getDepartmentId() != null) {
                        Organization org = organizationMapper.selectById(user.getDepartmentId());
                        if (org != null) {
                            vo.setDeptName(org.getOrgName());
                        }
                    }
                    return vo;
                })
                .collect(Collectors.toList());
        return new PageResult<>(result.getTotal(), voList);
    }

    @Override
    public UserVO getUserById(String userId) {
        SysUser user = getById(userId);
        if (user == null) return null;
        user.setPassword(null);
        user.setSalt(null);
        UserVO vo = UserConverter.toVO(user);
        vo.setRoleIds(roleUserService.getRoleIdsByUserId(userId));
        return vo;
    }

    @Override
    @Transactional
    public void createUser(UserCreateDTO dto) {
        SysUser existing = selectUserByAccountNumber(dto.getAccountNumber());
        if (existing != null) {
            throw new RuntimeException("用户名已存在");
        }
        SysUser user = UserConverter.toEntity(dto);
        user.setId(UUID.randomUUID().toString().replace("-", ""));
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setActivateStatus("1");
        user.setAddTime(LocalDateTime.now());
        save(user);

        if (dto.getRoleIds() != null && !dto.getRoleIds().isEmpty()) {
            roleUserService.updateUserRoles(user.getId(), dto.getRoleIds());
        }
    }

    @Override
    @Transactional
    public void updateUser(UserUpdateDTO dto) {
        SysUser user = getById(dto.getId());
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        UserConverter.updateEntity(user, dto);
        user.setPassword(null);
        user.setSalt(null);
        updateById(user);

        if (dto.getRoleIds() != null) {
            roleUserService.updateUserRoles(dto.getId(), dto.getRoleIds());
        }
    }

    @Override
    @Transactional
    public void deleteUsers(List<String> userIds) {
        for (String id : userIds) {
            if ("7acc64c6e6e54eae9eb883adc5f887b5".equals(id)) {
                throw new RuntimeException("不允许删除超级管理员");
            }
            roleUserService.deleteByUserId(id);
            removeById(id);
        }
    }

    @Override
    public void resetPassword(String userId, String password) {
        SysUser updateUser = new SysUser();
        updateUser.setId(userId);
        updateUser.setPassword(passwordEncoder.encode(password));
        updateById(updateUser);
    }

    @Override
    public void changeStatus(String userId, String status) {
        SysUser updateUser = new SysUser();
        updateUser.setId(userId);
        updateUser.setActivateStatus(status);
        updateById(updateUser);
    }
}