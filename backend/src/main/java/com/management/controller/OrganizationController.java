package com.management.controller;

import com.management.annotation.Log;
import com.management.common.Result;
import com.management.dto.OrganizationImportDTO;
import com.management.entity.Organization;
import com.management.service.IOrganizationService;
import com.alibaba.excel.EasyExcel;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/system/dept")
@RequiredArgsConstructor
public class OrganizationController {

    private final IOrganizationService organizationService;

    @PreAuthorize("@ss.hasPermi('system:dept:list') or @ss.hasPermi('system:dept:query')")
    @Log(module = "组织管理", businessType = 4, description = "查询组织列表")
    @GetMapping("/list")
    public Result<List<Organization>> list(
            @RequestParam(required = false) String deptName,
            @RequestParam(required = false) String status) {
        return Result.success(organizationService.listDepts(deptName, status));
    }

    @PreAuthorize("@ss.hasPermi('system:dept:query')")
    @Log(module = "组织管理", businessType = 4, description = "查询组织详情")
    @GetMapping("/{deptId}")
    public Result<Organization> getInfo(@PathVariable String deptId) {
        Organization dept = organizationService.getById(deptId);
        if (dept == null) {
            return Result.error("组织不存在");
        }
        return Result.success(dept);
    }

    @PreAuthorize("@ss.hasPermi('system:dept:add')")
    @Log(module = "组织管理", businessType = 1, description = "新增组织")
    @PostMapping
    public Result<Void> add(@RequestBody Organization dept) {
        organizationService.addDept(dept);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:dept:edit')")
    @Log(module = "组织管理", businessType = 2, description = "修改组织")
    @PutMapping
    public Result<Void> edit(@RequestBody Organization dept) {
        organizationService.updateDept(dept);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:dept:remove')")
    @Log(module = "组织管理", businessType = 3, description = "删除组织")
    @DeleteMapping("/{deptId}")
    public Result<Void> remove(@PathVariable String deptId) {
        organizationService.removeById(deptId);
        return Result.success();
    }

    @GetMapping("/optionselect")
    public Result<List<Organization>> optionselect() {
        return Result.success(organizationService.getDeptOptionSelect());
    }

    @PreAuthorize("@ss.hasPermi('system:dept:import')")
    @Log(module = "组织管理", businessType = 4, description = "下载组织导入模板")
    @GetMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setCharacterEncoding("utf-8");
        response.setHeader("Content-Disposition",
                "attachment; filename=" + URLEncoder.encode("组织导入模板.xlsx", StandardCharsets.UTF_8));

        List<OrganizationImportDTO> list = new ArrayList<>();
        OrganizationImportDTO example = new OrganizationImportDTO();
        example.setOrgName("研发部");
        example.setOrgAddress("A栋3楼");
        example.setGrade("1");
        example.setSortorder(1);
        list.add(example);

        EasyExcel.write(response.getOutputStream(), OrganizationImportDTO.class).sheet("组织导入").doWrite(list);
    }

    @PreAuthorize("@ss.hasPermi('system:dept:import')")
    @Log(module = "组织管理", businessType = 2, description = "导入组织")
    @PostMapping("/importData")
    public Result<String> importData(@RequestParam("file") MultipartFile file) throws IOException {
        List<OrganizationImportDTO> list = EasyExcel.read(file.getInputStream())
                .head(OrganizationImportDTO.class).sheet().doReadSync();

        int success = 0, fail = 0;
        for (OrganizationImportDTO dto : list) {
            if (dto.getOrgName() == null || dto.getOrgName().isEmpty()) {
                fail++;
                continue;
            }
            try {
                Organization org = new Organization();
                org.setId(UUID.randomUUID().toString().replace("-", ""));
                org.setOrgName(dto.getOrgName());
                org.setOrgAddress(dto.getOrgAddress());
                org.setSuperOrg(dto.getSuperOrg());
                org.setRemark(dto.getRemark());
                org.setGrade(dto.getGrade());
                org.setSortorder(dto.getSortorder() != null ? dto.getSortorder() : 0);
                org.setCreateTime(LocalDateTime.now());
                org.setUpdateTime(LocalDateTime.now());
                organizationService.save(org);
                success++;
            } catch (Exception e) {
                fail++;
            }
        }
        return Result.success("成功导入 " + success + " 条，失败 " + fail + " 条");
    }
}