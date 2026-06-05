package com.management.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("t_user")
public class SysUser implements Serializable {

    @TableId(type = IdType.INPUT)
    private String id;

    @NotBlank(message = "账号不能为空", groups = {Add.class, Edit.class})
    @Size(min = 3, max = 20, message = "账号长度必须在3-20个字符之间")
    private String accountNumber;

    @NotBlank(message = "昵称不能为空", groups = {Add.class, Edit.class})
    @Size(max = 30, message = "昵称长度不能超过30个字符")
    private String nickName;

    private String realName;

    @Email(message = "邮箱格式不正确")
    @Size(max = 50, message = "邮箱长度不能超过50个字符")
    private String email;

    private String departmentId;
    private LocalDateTime addTime;
    private LocalDateTime loginTime;
    private String activateStatus;

    @NotBlank(message = "密码不能为空", groups = {Add.class})
    @Size(min = 6, max = 20, message = "密码长度必须在6-20个字符之间")
    private String password;

    private String unitId;

    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String phoneNumber;

    private String duty;
    private String salt;
    private Integer passwordLevel;
    private String sfzhm;

    private String createBy;
    private String updateBy;
    private LocalDateTime updateTime;
    private Integer deleted;
    private String remark;

    public interface Add {}
    public interface Edit {}
}
