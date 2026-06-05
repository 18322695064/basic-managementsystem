package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.common.PageResult;
import com.management.entity.SysConfig;
import com.management.mapper.SysConfigMapper;
import com.management.service.ISysConfigService;
import org.springframework.stereotype.Service;

@Service
public class SysConfigServiceImpl extends ServiceImpl<SysConfigMapper, SysConfig> implements ISysConfigService {

    @Override
    public String selectConfigByKey(String configKey) {
        LambdaQueryWrapper<SysConfig> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysConfig::getConfigKey, configKey);
        SysConfig config = getOne(wrapper);
        return config != null ? config.getConfigValue() : null;
    }

    @Override
    public PageResult<SysConfig> pageConfigs(String configName, String configKey, String configType, int pageNum, int pageSize) {
        Page<SysConfig> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<SysConfig> wrapper = new LambdaQueryWrapper<>();
        if (configName != null && !configName.isEmpty()) {
            wrapper.like(SysConfig::getConfigName, configName);
        }
        if (configKey != null && !configKey.isEmpty()) {
            wrapper.like(SysConfig::getConfigKey, configKey);
        }
        if (configType != null && !configType.isEmpty()) {
            wrapper.eq(SysConfig::getConfigType, configType);
        }
        wrapper.orderByDesc(SysConfig::getCreateTime);
        Page<SysConfig> result = page(page, wrapper);
        return new PageResult<>(result.getTotal(), result.getRecords());
    }
}