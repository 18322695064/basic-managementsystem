package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.common.PageResult;
import com.management.entity.SysConfig;

public interface ISysConfigService extends IService<SysConfig> {

    String selectConfigByKey(String configKey);

    PageResult<SysConfig> pageConfigs(String configName, String configKey, String configType, int pageNum, int pageSize);
}