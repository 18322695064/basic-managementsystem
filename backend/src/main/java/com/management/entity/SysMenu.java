package com.management.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.management.common.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_menu")
public class SysMenu extends BaseEntity {

    private Long parentId;
    private String menuName;
    private String menuType;
    private String path;
    private String component;
    private String perms;
    private String icon;
    private Integer sortOrder;
    private String status;
    private String visible;
}
