package com.management.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@Data
@TableName("role_menu")
public class RoleMenu implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String roleId;
    private Long menuId;
}
