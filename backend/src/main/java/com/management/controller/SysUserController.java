package com.management.controller;

import com.management.annotation.Log;
import com.management.common.PageResult;
import com.management.common.Result;
import com.management.dto.user.UserCreateDTO;
import com.management.dto.user.UserImportDTO;
import com.management.dto.user.UserQueryDTO;
import com.management.dto.user.UserUpdateDTO;
import com.management.dto.user.UserVO;
import com.management.entity.Organization;
import com.management.entity.SysUser;
import com.management.service.ISysUserService;
import com.management.mapper.OrganizationMapper;
import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/system/user")
@RequiredArgsConstructor
public class SysUserController {

    private final ISysUserService userService;
    private final OrganizationMapper organizationMapper;
    private final PasswordEncoder passwordEncoder;

    @PreAuthorize("@ss.hasPermi('system:user:list') or @ss.hasPermi('system:user:query')")
    @Log(module = "用户管理", businessType = 4, description = "查询用户列表")
    @GetMapping("/list")
    public Result<PageResult<UserVO>> list(UserQueryDTO queryDTO) {
        return Result.success(userService.pageUsers(queryDTO));
    }

    @PreAuthorize("@ss.hasPermi('system:user:query')")
    @Log(module = "用户管理", businessType = 4, description = "查询用户详情")
    @GetMapping("/{userId}")
    public Result<UserVO> getInfo(@PathVariable String userId) {
        UserVO user = userService.getUserById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }
        return Result.success(user);
    }

    @PreAuthorize("@ss.hasPermi('system:user:add')")
    @Log(module = "用户管理", businessType = 1, description = "新增用户")
    @PostMapping
    public Result<Void> add(@Valid @RequestBody UserCreateDTO dto) {
        try {
            userService.createUser(dto);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    @PreAuthorize("@ss.hasPermi('system:user:edit')")
    @Log(module = "用户管理", businessType = 2, description = "修改用户")
    @PutMapping
    public Result<Void> edit(@Valid @RequestBody UserUpdateDTO dto) {
        try {
            userService.updateUser(dto);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    @PreAuthorize("@ss.hasPermi('system:user:export')")
    @GetMapping("/export")
    public void export(UserQueryDTO queryDTO, HttpServletResponse response) throws Exception {
        queryDTO.setPageSize(Integer.MAX_VALUE);
        PageResult<UserVO> page = userService.pageUsers(queryDTO);
        List<UserVO> users = page.getRows();

        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=users.csv");
        response.setCharacterEncoding("UTF-8");
        PrintWriter writer = response.getWriter();
        writer.write('\ufeff');
        writer.println("用户ID,用户名,昵称,部门,手机号,邮箱,状态,创建时间");

        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        for (UserVO u : users) {
            writer.printf("%s,%s,%s,%s,%s,%s,%s,%s\n",
                    u.getId(),
                    csvEscape(u.getAccountNumber()),
                    csvEscape(u.getNickName()),
                    csvEscape(u.getDeptName()),
                    u.getPhoneNumber() != null ? u.getPhoneNumber() : "",
                    u.getEmail() != null ? u.getEmail() : "",
                    "1".equals(u.getActivateStatus()) ? "正常" : "停用",
                    u.getAddTime() != null ? fmt.format(u.getAddTime()) : ""
            );
        }
        writer.flush();
    }

    private String csvEscape(String val) {
        if (val == null) return "";
        if (val.contains(",") || val.contains("\"") || val.contains("\n")) {
            return "\"" + val.replace("\"", "\"\"") + "\"";
        }
        return val;
    }

    @PreAuthorize("@ss.hasPermi('system:user:remove')")
    @Log(module = "用户管理", businessType = 3, description = "删除用户")
    @DeleteMapping("/{userIds}")
    public Result<Void> remove(@PathVariable String userIds) {
        try {
            userService.deleteUsers(Arrays.asList(userIds.split(",")));
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    @PreAuthorize("@ss.hasPermi('system:user:resetPwd')")
    @Log(module = "用户管理", businessType = 2, description = "重置密码")
    @PutMapping("/resetPwd")
    public Result<Void> resetPwd(@RequestBody Map<String, String> params) {
        String userId = params.get("userId");
        String password = params.get("password");
        if (password == null || password.isEmpty()) {
            return Result.error("新密码不能为空");
        }
        userService.resetPassword(userId, password);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:user:edit')")
    @Log(module = "用户管理", businessType = 2, description = "修改用户状态")
    @PutMapping("/changeStatus")
    public Result<Void> changeStatus(@RequestBody Map<String, String> params) {
        String userId = params.get("userId");
        String status = params.get("status");
        userService.changeStatus(userId, status);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:user:import')")
    @Log(module = "用户管理", businessType = 4, description = "下载用户导入模板")
    @GetMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setCharacterEncoding("utf-8");
        response.setHeader("Content-Disposition",
                "attachment; filename=" + URLEncoder.encode("用户导入模板.xlsx", StandardCharsets.UTF_8));

        List<UserImportDTO> list = new ArrayList<>();
        UserImportDTO example = new UserImportDTO();
        example.setAccountNumber("zhangsan");
        example.setNickName("张三");
        example.setPassword("123456");
        example.setRealName("张三丰");
        example.setEmail("zhangsan@example.com");
        example.setPhoneNumber("13800138000");
        example.setDeptName("研发部");
        list.add(example);

        EasyExcel.write(response.getOutputStream(), UserImportDTO.class).sheet("用户导入").doWrite(list);
    }

    @PreAuthorize("@ss.hasPermi('system:user:import')")
    @Log(module = "用户管理", businessType = 2, description = "导入用户")
    @PostMapping("/importData")
    public Result<String> importData(@RequestParam("file") MultipartFile file) throws IOException {
        List<UserImportDTO> list = EasyExcel.read(file.getInputStream())
                .head(UserImportDTO.class).sheet().doReadSync();

        int success = 0, fail = 0;
        for (UserImportDTO dto : list) {
            if (dto.getAccountNumber() == null || dto.getAccountNumber().isEmpty()
                    || dto.getNickName() == null || dto.getNickName().isEmpty()) {
                fail++;
                continue;
            }
            try {
                if (userService.selectUserByAccountNumber(dto.getAccountNumber()) != null) {
                    fail++;
                    continue;
                }
                SysUser user = new SysUser();
                user.setId(UUID.randomUUID().toString().replace("-", ""));
                user.setAccountNumber(dto.getAccountNumber());
                user.setNickName(dto.getNickName());
                user.setRealName(dto.getRealName());
                user.setEmail(dto.getEmail());
                user.setPhoneNumber(dto.getPhoneNumber());
                if (dto.getDeptName() != null && !dto.getDeptName().isEmpty()) {
                    LambdaQueryWrapper<Organization> deptWrapper = new LambdaQueryWrapper<>();
                    deptWrapper.eq(Organization::getOrgName, dto.getDeptName());
                    Organization dept = organizationMapper.selectOne(deptWrapper);
                    if (dept != null) {
                        user.setDepartmentId(dept.getId());
                    }
                }
                user.setDuty(dto.getDuty());
                user.setPassword(passwordEncoder.encode(
                        dto.getPassword() != null ? dto.getPassword() : "123456"));
                user.setActivateStatus("1");
                user.setAddTime(LocalDateTime.now());
                userService.save(user);
                success++;
            } catch (Exception e) {
                fail++;
            }
        }
        return Result.success("成功导入 " + success + " 条，失败 " + fail + " 条");
    }
}