package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.common.PageResult;
import com.management.entity.SysDictType;
import com.management.mapper.SysDictTypeMapper;
import com.management.service.ISysDictTypeService;
import org.springframework.stereotype.Service;

@Service
public class SysDictTypeServiceImpl extends ServiceImpl<SysDictTypeMapper, SysDictType> implements ISysDictTypeService {

    @Override
    public PageResult<SysDictType> pageDictTypes(String dictName, String dictType, String status, int pageNum, int pageSize) {
        Page<SysDictType> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<SysDictType> wrapper = new LambdaQueryWrapper<>();
        if (dictName != null && !dictName.isEmpty()) {
            wrapper.like(SysDictType::getDictName, dictName);
        }
        if (dictType != null && !dictType.isEmpty()) {
            wrapper.like(SysDictType::getDictType, dictType);
        }
        if (status != null && !status.isEmpty()) {
            wrapper.eq(SysDictType::getStatus, status);
        }
        Page<SysDictType> result = page(page, wrapper);
        return new PageResult<>(result.getTotal(), result.getRecords());
    }
}