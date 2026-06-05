package com.management.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.management.common.BaseEntity;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_notice")
public class SysNotice extends BaseEntity {

    @NotBlank(message = "公告标题不能为空")
    @Size(max = 50, message = "公告标题长度不能超过50个字符")
    private String noticeTitle;

    @NotBlank(message = "公告类型不能为空")
    private String noticeType;

    @NotBlank(message = "公告内容不能为空")
    private String noticeContent;

    private String status;
}
