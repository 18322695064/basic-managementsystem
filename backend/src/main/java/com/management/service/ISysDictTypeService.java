package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.common.PageResult;
import com.management.entity.SysDictType;

public interface ISysDictTypeService extends IService<SysDictType> {

    PageResult<SysDictType> pageDictTypes(String dictName, String dictType, String status, int pageNum, int pageSize);
}