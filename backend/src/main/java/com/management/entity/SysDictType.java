package com.management.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.management.common.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_dict_type")
public class SysDictType extends BaseEntity {

    private String dictName;
    private String dictType;
    private String status;
    private String remark;
}
