package com.management.controller;

import com.management.common.PageResult;
import com.management.common.Result;
import com.management.entity.SysLoginLog;
import com.management.entity.TLog;
import com.management.service.ISysLoginLogService;
import com.management.service.ITLogService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/system/log")
@RequiredArgsConstructor
public class SysLogController {

    private final ITLogService tLogService;
    private final ISysLoginLogService loginLogService;

    @PreAuthorize("@ss.hasPermi('system:log:oper:list') or @ss.hasPermi('system:log:oper:query')")
    @GetMapping("/oper/list")
    public Result<PageResult<TLog>> operList(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String module,
            @RequestParam(required = false) String operName,
            @RequestParam(required = false) Integer businessType,
            @RequestParam(required = false) Integer status) {
        return Result.success(tLogService.pageOperLogs(operName, status, pageNum, pageSize));
    }

    @PreAuthorize("@ss.hasPermi('system:log:oper:remove')")
    @DeleteMapping("/oper/clean")
    public Result<Void> cleanOper() {
        tLogService.cleanOperLogs();
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:log:login:list') or @ss.hasPermi('system:log:login:query')")
    @GetMapping("/login/list")
    public Result<PageResult<SysLoginLog>> loginList(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String accountNumber,
            @RequestParam(required = false) String loginIp,
            @RequestParam(required = false) String loginStatus) {
        return Result.success(loginLogService.pageLoginLogs(accountNumber, loginIp, loginStatus, pageNum, pageSize));
    }

    @PreAuthorize("@ss.hasPermi('system:log:login:remove')")
    @DeleteMapping("/login/clean")
    public Result<Void> cleanLogin() {
        loginLogService.cleanLoginLogs();
        return Result.success();
    }
}