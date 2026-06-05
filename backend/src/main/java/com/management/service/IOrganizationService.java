package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.common.PageResult;
import com.management.entity.Organization;

import java.util.List;

public interface IOrganizationService extends IService<Organization> {

    List<Organization> listDepts(String deptName, String status);

    Organization addDept(Organization dept);

    Organization updateDept(Organization dept);

    List<Organization> getDeptOptionSelect();
}