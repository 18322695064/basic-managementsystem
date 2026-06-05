package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.common.PageResult;
import com.management.entity.SysLoginLog;

public interface ISysLoginLogService extends IService<SysLoginLog> {

    PageResult<SysLoginLog> pageLoginLogs(String accountNumber, String loginIp, String loginStatus, int pageNum, int pageSize);

    void cleanLoginLogs();
}