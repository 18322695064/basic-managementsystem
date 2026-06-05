package com.management.dto.role;

import lombok.Data;

@Data
public class RoleQueryDTO {

    private Integer pageNum = 1;
    private Integer pageSize = 10;
    private String roleName;
    private String roleKey;
    private String status;
}