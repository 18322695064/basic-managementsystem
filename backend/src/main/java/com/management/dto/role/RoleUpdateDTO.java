package com.management.dto.role;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import java.util.List;

@Data
public class RoleUpdateDTO {

    @NotBlank(message = "角色ID不能为空")
    private String id;

    @NotBlank(message = "角色名称不能为空")
    @Size(max = 30, message = "角色名称长度不能超过30个字符")
    private String roleName;

    @NotBlank(message = "角色编码不能为空")
    @Size(max = 30, message = "角色编码长度不能超过30个字符")
    private String roleCode;

    private String roleType;
    private String roleSystem;
    private String remarks;
    private List<Long> menuIds;
    private String status;
}