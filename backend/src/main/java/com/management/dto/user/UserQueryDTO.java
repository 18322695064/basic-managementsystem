package com.management.dto.user;

import lombok.Data;

@Data
public class UserQueryDTO {

    private Integer pageNum = 1;
    private Integer pageSize = 10;
    private String username;
    private String nickname;
    private String status;
    private String deptId;
    private String phoneNumber;
}