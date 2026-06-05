package com.management.dto.user;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;
import java.util.List;

@Data
public class UserUpdateDTO {

    @NotBlank(message = "用户ID不能为空")
    private String id;

    @NotBlank(message = "昵称不能为空")
    @Size(max = 30, message = "昵称长度不能超过30个字符")
    private String nickName;

    private String realName;

    @Email(message = "邮箱格式不正确")
    @Size(max = 50, message = "邮箱长度不能超过50个字符")
    private String email;

    private String departmentId;

    private String unitId;

    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String phoneNumber;

    private String duty;

    private String activateStatus;

    private String sfzhm;
    private List<String> roleIds;
}