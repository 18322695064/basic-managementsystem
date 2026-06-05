package com.management.controller;

import com.management.annotation.Log;
import com.management.common.PageResult;
import com.management.common.Result;
import com.management.dto.CodeGenTable;
import com.management.service.ICodeGenService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Map;

@RestController
@RequestMapping("/tool/gen")
@RequiredArgsConstructor
public class CodeGenController {

    private final ICodeGenService codeGenService;

    @PreAuthorize("@ss.hasPermi('tool:gen:list')")
    @Log(module = "代码生成", businessType = 4, description = "查询数据库表列表")
    @GetMapping("/list")
    public Result<PageResult<CodeGenTable>> list(
            @RequestParam(defaultValue = "") String tableName,
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        return Result.success(codeGenService.selectTableList(tableName, pageNum, pageSize));
    }

    @PreAuthorize("@ss.hasPermi('tool:gen:query')")
    @GetMapping("/{tableName}")
    public Result<Map<String, Object>> getInfo(@PathVariable String tableName) {
        return Result.success(codeGenService.selectTableInfo(tableName));
    }

    @PreAuthorize("@ss.hasPermi('tool:gen:preview')")
    @Log(module = "代码生成", businessType = 9, description = "预览代码")
    @GetMapping("/preview/{tableName}")
    public Result<Map<String, String>> preview(@PathVariable String tableName) {
        return Result.success(codeGenService.previewCode(tableName));
    }

    @PreAuthorize("@ss.hasPermi('tool:gen:generate')")
    @Log(module = "代码生成", businessType = 9, description = "生成代码")
    @PostMapping("/generate/{tableName}")
    public void generate(@PathVariable String tableName, HttpServletResponse response) throws IOException {
        byte[] data = codeGenService.generateCode(tableName);
        response.setContentType("application/zip");
        response.setHeader("Content-Disposition", "attachment; filename=codegen_" + tableName + ".zip");
        response.getOutputStream().write(data);
        response.getOutputStream().flush();
    }

    @PreAuthorize("@ss.hasPermi('tool:gen:add')")
    @Log(module = "代码生成", businessType = 1, description = "新增表定义")
    @PostMapping("/table")
    public Result<Void> createTable(@RequestBody Map<String, Object> tableDef) {
        codeGenService.createTable(tableDef);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('tool:gen:edit')")
    @Log(module = "代码生成", businessType = 2, description = "修改表定义")
    @PutMapping("/table/{tableName}")
    public Result<Void> updateTable(@PathVariable String tableName, @RequestBody Map<String, Object> tableDef) {
        codeGenService.updateTable(tableName, tableDef);
        return Result.success();
    }
}
