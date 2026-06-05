package com.management.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("sys_login_log")
public class SysLoginLog {

    private Long id;
    private Long userId;
    private String accountNumber;
    private String loginIp;
    private String loginLocation;
    private String browser;
    private String os;
    private String loginStatus;
    private String msg;
    private LocalDateTime loginTime;
}
