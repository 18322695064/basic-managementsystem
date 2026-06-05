package com.management.controller;

import com.management.annotation.Log;
import com.management.common.PageResult;
import com.management.common.Result;
import com.management.entity.SysConfig;
import com.management.service.ISysConfigService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/system/config")
@RequiredArgsConstructor
public class SysConfigController {

    private final ISysConfigService configService;

    @PreAuthorize("@ss.hasPermi('system:config:list') or @ss.hasPermi('system:config:query')")
    @Log(module = "参数设置", businessType = 4, description = "查询参数列表")
    @GetMapping("/list")
    public Result<PageResult<SysConfig>> list(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String configName,
            @RequestParam(required = false) String configKey,
            @RequestParam(required = false) String configType) {
        return Result.success(configService.pageConfigs(configName, configKey, configType, pageNum, pageSize));
    }

    @PreAuthorize("@ss.hasPermi('system:config:query')")
    @Log(module = "参数设置", businessType = 4, description = "查询参数详情")
    @GetMapping("/{configId}")
    public Result<SysConfig> getInfo(@PathVariable Long configId) {
        return Result.success(configService.getById(configId));
    }

    @GetMapping("/key/{configKey}")
    public Result<String> getConfigByKey(@PathVariable String configKey) {
        return Result.success(configService.selectConfigByKey(configKey));
    }

    @PreAuthorize("@ss.hasPermi('system:config:add')")
    @Log(module = "参数设置", businessType = 1, description = "新增参数")
    @PostMapping
    public Result<Void> add(@RequestBody SysConfig config) {
        configService.save(config);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:config:edit')")
    @Log(module = "参数设置", businessType = 2, description = "修改参数")
    @PutMapping
    public Result<Void> edit(@RequestBody SysConfig config) {
        configService.updateById(config);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:config:remove')")
    @Log(module = "参数设置", businessType = 3, description = "删除参数")
    @DeleteMapping("/{configIds}")
    public Result<Void> remove(@PathVariable String configIds) {
        for (String id : configIds.split(",")) {
            configService.removeById(Long.parseLong(id));
        }
        return Result.success();
    }
}