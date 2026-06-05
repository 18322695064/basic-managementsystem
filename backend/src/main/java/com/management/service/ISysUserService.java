package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.common.PageResult;
import com.management.dto.user.*;
import com.management.entity.SysUser;

import java.util.List;

public interface ISysUserService extends IService<SysUser> {

    SysUser selectUserByAccountNumber(String accountNumber);

    PageResult<UserVO> pageUsers(UserQueryDTO queryDTO);

    UserVO getUserById(String userId);

    void createUser(UserCreateDTO dto);

    void updateUser(UserUpdateDTO dto);

    void deleteUsers(List<String> userIds);

    void resetPassword(String userId, String password);

    void changeStatus(String userId, String status);
}