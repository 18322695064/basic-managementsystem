package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.common.PageResult;
import com.management.entity.SysDictData;

import java.util.List;

public interface ISysDictDataService extends IService<SysDictData> {

    List<SysDictData> selectDictDataByType(String dictType);

    PageResult<SysDictData> pageDictData(String dictType, String dictLabel, String status, int pageNum, int pageSize);
}