package com.management.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Data
@TableName("role")
public class Role implements Serializable {

    @TableId(type = IdType.INPUT)
    private String id;
    private String roleName;
    private LocalDateTime createTime;
    private String remarks;
    private String roleType;
    private String roleCode;
    private String roleSystem;
    private LocalDateTime updateTime;
    private Integer deleted;
    private String dataScope;

    @TableField(exist = false)
    private List<Long> menuIds;
}
