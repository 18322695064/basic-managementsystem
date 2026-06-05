package com.management.dto.user;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class UserVO {

    private String id;
    private String accountNumber;
    private String nickName;
    private String realName;
    private String email;
    private String phoneNumber;
    private String departmentId;
    private String deptName;
    private LocalDateTime addTime;
    private LocalDateTime loginTime;
    private String activateStatus;
    private String roleName;
    private List<String> roleIds;
    private String unitId;
    private String duty;
    private String sfzhm;
}