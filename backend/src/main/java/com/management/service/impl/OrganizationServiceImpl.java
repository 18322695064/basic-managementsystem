package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.entity.Organization;
import com.management.mapper.OrganizationMapper;
import com.management.security.DataScopeHelper;
import com.management.service.IOrganizationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrganizationServiceImpl extends ServiceImpl<OrganizationMapper, Organization> implements IOrganizationService {

    private final DataScopeHelper dataScopeHelper;

    @Override
    public List<Organization> listDepts(String deptName, String status) {
        LambdaQueryWrapper<Organization> wrapper = new LambdaQueryWrapper<>();
        if (deptName != null && !deptName.isEmpty()) {
            wrapper.like(Organization::getOrgName, deptName);
        }

        String dataScope = dataScopeHelper.getEffectiveDataScope();
        String userDeptId = dataScopeHelper.getCurrentUserDeptId();
        switch (dataScope) {
            case "2":
            case "3":
                if (userDeptId != null) {
                    List<String> deptIds = dataScopeHelper.getDeptAndChildren(userDeptId);
                    wrapper.in(Organization::getId, deptIds);
                }
                break;
            default:
                break;
        }

        wrapper.orderByAsc(Organization::getSortorder);
        return list(wrapper);
    }

    @Override
    public Organization addDept(Organization dept) {
        dept.setId(UUID.randomUUID().toString().replace("-", ""));
        dept.setCreateTime(LocalDateTime.now());
        dept.setUpdateTime(LocalDateTime.now());
        save(dept);
        return dept;
    }

    @Override
    public Organization updateDept(Organization dept) {
        dept.setUpdateTime(LocalDateTime.now());
        updateById(dept);
        return dept;
    }

    @Override
    public List<Organization> getDeptOptionSelect() {
        LambdaQueryWrapper<Organization> wrapper = new LambdaQueryWrapper<>();
        wrapper.select(Organization::getId, Organization::getOrgName, Organization::getSuperOrg);
        wrapper.orderByAsc(Organization::getSortorder);
        return list(wrapper);
    }
}