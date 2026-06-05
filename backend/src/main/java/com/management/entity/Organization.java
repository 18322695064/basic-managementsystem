package com.management.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("organization")
public class Organization implements Serializable {

    @TableId(type = IdType.INPUT)
    private String id;
    private String orgName;
    private String orgAddress;
    private String orgDuty;
    private String superOrg;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private String remark;
    private String grade;
    private String cityCode;
    private Integer admin;
    private Integer isWarn;
    private Integer groupNum;
    private Integer adminLevel;
    private Integer orgType;
    private String adId;
    private Integer sortorder;
    private String isfold;
    private String iske;
}
