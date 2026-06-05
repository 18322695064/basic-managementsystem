package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.common.PageResult;
import com.management.entity.TLog;

public interface ITLogService extends IService<TLog> {

    PageResult<TLog> pageOperLogs(String operName, Integer status, int pageNum, int pageSize);

    void cleanOperLogs();
}