package com.management.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@Data
@TableName("role_user")
public class RoleUser implements Serializable {

    @TableId(type = IdType.INPUT)
    private String id;
    private String userId;
    private String roleId;
    private String remark;
}
