package com.management.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.management.common.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_job")
public class SysJob extends BaseEntity {

    private String jobName;
    private String jobGroup;
    private String invokeTarget;
    private String cronExpression;
    private String misfirePolicy;
    private String concurrent;
    private String status;
    private String remark;
}
