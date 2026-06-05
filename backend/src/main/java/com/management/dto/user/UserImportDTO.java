package com.management.dto.user;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

@Data
public class UserImportDTO {

    @ExcelProperty("用户名")
    private String accountNumber;

    @ExcelProperty("昵称")
    private String nickName;

    @ExcelProperty("密码")
    private String password;

    @ExcelProperty("真实姓名")
    private String realName;

    @ExcelProperty("邮箱")
    private String email;

    @ExcelProperty("手机号")
    private String phoneNumber;

    @ExcelProperty("部门")
    private String deptName;

    @ExcelProperty("职务")
    private String duty;
}
