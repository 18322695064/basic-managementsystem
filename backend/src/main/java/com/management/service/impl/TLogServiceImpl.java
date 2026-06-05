package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.common.PageResult;
import com.management.entity.TLog;
import com.management.mapper.TLogMapper;
import com.management.service.ITLogService;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import org.springframework.stereotype.Service;

@Service
public class TLogServiceImpl extends ServiceImpl<TLogMapper, TLog> implements ITLogService {

    @Override
    public PageResult<TLog> pageOperLogs(String operName, Integer status, int pageNum, int pageSize) {
        Page<TLog> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<TLog> wrapper = new LambdaQueryWrapper<>();
        if (operName != null && !operName.isEmpty()) {
            wrapper.like(TLog::getRealname, operName);
        }
        if (status != null) {
            wrapper.eq(TLog::getIsError, status);
        }
        wrapper.orderByDesc(TLog::getCreateTime);
        Page<TLog> result = page(page, wrapper);
        return new PageResult<>(result.getTotal(), result.getRecords());
    }

    @Override
    public void cleanOperLogs() {
        LambdaQueryWrapper<TLog> wrapper = new LambdaQueryWrapper<>();
        wrapper.lt(TLog::getCreateTime, LocalDateTime.now().minus(30, ChronoUnit.DAYS));
        remove(wrapper);
    }
}