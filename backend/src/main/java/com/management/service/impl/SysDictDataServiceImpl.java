package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.common.PageResult;
import com.management.entity.SysDictData;
import com.management.mapper.SysDictDataMapper;
import com.management.service.ISysDictDataService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysDictDataServiceImpl extends ServiceImpl<SysDictDataMapper, SysDictData> implements ISysDictDataService {

    @Override
    public List<SysDictData> selectDictDataByType(String dictType) {
        LambdaQueryWrapper<SysDictData> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysDictData::getDictType, dictType)
               .orderByAsc(SysDictData::getDictSort);
        return list(wrapper);
    }

    @Override
    public PageResult<SysDictData> pageDictData(String dictType, String dictLabel, String status, int pageNum, int pageSize) {
        Page<SysDictData> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<SysDictData> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysDictData::getDictType, dictType);
        if (dictLabel != null && !dictLabel.isEmpty()) {
            wrapper.like(SysDictData::getDictLabel, dictLabel);
        }
        if (status != null && !status.isEmpty()) {
            wrapper.eq(SysDictData::getStatus, status);
        }
        wrapper.orderByAsc(SysDictData::getDictSort);
        Page<SysDictData> result = page(page, wrapper);
        return new PageResult<>(result.getTotal(), result.getRecords());
    }
}