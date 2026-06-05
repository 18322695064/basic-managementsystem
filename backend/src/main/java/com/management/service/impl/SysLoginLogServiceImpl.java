package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.common.PageResult;
import com.management.entity.SysLoginLog;
import com.management.mapper.SysLoginLogMapper;
import com.management.service.ISysLoginLogService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@Service
public class SysLoginLogServiceImpl extends ServiceImpl<SysLoginLogMapper, SysLoginLog> implements ISysLoginLogService {

    @Override
    public PageResult<SysLoginLog> pageLoginLogs(String accountNumber, String loginIp, String loginStatus, int pageNum, int pageSize) {
        Page<SysLoginLog> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<SysLoginLog> wrapper = new LambdaQueryWrapper<>();
        if (accountNumber != null && !accountNumber.isEmpty()) {
            wrapper.like(SysLoginLog::getAccountNumber, accountNumber);
        }
        if (loginIp != null && !loginIp.isEmpty()) {
            wrapper.like(SysLoginLog::getLoginIp, loginIp);
        }
        if (loginStatus != null && !loginStatus.isEmpty()) {
            wrapper.eq(SysLoginLog::getLoginStatus, loginStatus);
        }
        wrapper.orderByDesc(SysLoginLog::getLoginTime);
        Page<SysLoginLog> result = page(page, wrapper);
        return new PageResult<>(result.getTotal(), result.getRecords());
    }

    @Override
    public void cleanLoginLogs() {
        LambdaQueryWrapper<SysLoginLog> wrapper = new LambdaQueryWrapper<>();
        wrapper.lt(SysLoginLog::getLoginTime, LocalDateTime.now().minus(30, ChronoUnit.DAYS));
        remove(wrapper);
    }
}