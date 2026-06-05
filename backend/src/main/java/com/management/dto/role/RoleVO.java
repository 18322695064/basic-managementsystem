package com.management.dto.role;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class RoleVO {

    private String id;
    private String roleName;
    private String roleCode;
    private String roleType;
    private String roleSystem;
    private String remarks;
    private String dataScope;
    private LocalDateTime createTime;
    private List<Long> menuIds;
}