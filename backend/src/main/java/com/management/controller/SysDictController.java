package com.management.controller;

import com.management.annotation.Log;
import com.management.common.PageResult;
import com.management.common.Result;
import com.management.entity.SysDictData;
import com.management.entity.SysDictType;
import com.management.service.ISysDictDataService;
import com.management.service.ISysDictTypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/system/dict")
@RequiredArgsConstructor
public class SysDictController {

    private final ISysDictTypeService dictTypeService;
    private final ISysDictDataService dictDataService;

    @PreAuthorize("@ss.hasPermi('system:dict:list') or @ss.hasPermi('system:dict:query')")
    @Log(module = "字典管理", businessType = 4, description = "查询字典类型列表")
    @GetMapping("/type/list")
    public Result<PageResult<SysDictType>> typeList(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String dictName,
            @RequestParam(required = false) String dictType,
            @RequestParam(required = false) String status) {
        return Result.success(dictTypeService.pageDictTypes(dictName, dictType, status, pageNum, pageSize));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:query')")
    @Log(module = "字典管理", businessType = 4, description = "查询字典类型详情")
    @GetMapping("/type/{dictId}")
    public Result<SysDictType> getTypeInfo(@PathVariable Long dictId) {
        return Result.success(dictTypeService.getById(dictId));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:add')")
    @Log(module = "字典管理", businessType = 1, description = "新增字典类型")
    @PostMapping("/type")
    public Result<Void> addType(@RequestBody SysDictType dictType) {
        dictTypeService.save(dictType);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:dict:edit')")
    @Log(module = "字典管理", businessType = 2, description = "修改字典类型")
    @PutMapping("/type")
    public Result<Void> editType(@RequestBody SysDictType dictType) {
        dictTypeService.updateById(dictType);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:dict:remove')")
    @Log(module = "字典管理", businessType = 3, description = "删除字典类型")
    @DeleteMapping("/type/{dictIds}")
    public Result<Void> removeType(@PathVariable String dictIds) {
        for (String id : dictIds.split(",")) {
            dictTypeService.removeById(Long.parseLong(id));
        }
        return Result.success();
    }

    @GetMapping("/data/list")
    public Result<PageResult<SysDictData>> dataList(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam String dictType,
            @RequestParam(required = false) String dictLabel,
            @RequestParam(required = false) String status) {
        return Result.success(dictDataService.pageDictData(dictType, dictLabel, status, pageNum, pageSize));
    }

    @GetMapping("/data/type/{dictType}")
    public Result<List<SysDictData>> dataType(@PathVariable String dictType) {
        return Result.success(dictDataService.selectDictDataByType(dictType));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:query')")
    @GetMapping("/data/{dictId}")
    public Result<SysDictData> getDataInfo(@PathVariable Long dictId) {
        return Result.success(dictDataService.getById(dictId));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:add')")
    @PostMapping("/data")
    public Result<Void> addData(@RequestBody SysDictData dictData) {
        dictDataService.save(dictData);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:dict:edit')")
    @PutMapping("/data")
    public Result<Void> editData(@RequestBody SysDictData dictData) {
        dictDataService.updateById(dictData);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:dict:remove')")
    @DeleteMapping("/data/{dictIds}")
    public Result<Void> removeData(@PathVariable String dictIds) {
        for (String id : dictIds.split(",")) {
            dictDataService.removeById(Long.parseLong(id));
        }
        return Result.success();
    }
}