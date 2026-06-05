package com.management.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("t_log")
public class TLog implements Serializable {

    @TableId(type = IdType.INPUT)
    private String id;
    private String realname;
    private String clientIp;
    private LocalDateTime createTime;
    private String accountNumber;
    private String userId;
    private Integer logType;
    private String logContent;
    private Integer isError;
    private String departmentId;
}
