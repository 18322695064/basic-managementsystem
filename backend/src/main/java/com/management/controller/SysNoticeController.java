package com.management.controller;

import com.management.annotation.Log;
import com.management.common.PageResult;
import com.management.common.Result;
import com.management.entity.SysNotice;
import com.management.service.ISysNoticeService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/system/notice")
@RequiredArgsConstructor
@Validated
public class SysNoticeController {

    private final ISysNoticeService noticeService;

    @PreAuthorize("@ss.hasPermi('system:notice:list') or @ss.hasPermi('system:notice:query')")
    @Log(module = "通知公告", businessType = 4, description = "查询公告列表")
    @GetMapping("/list")
    public Result<PageResult<SysNotice>> list(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String noticeTitle,
            @RequestParam(required = false) String noticeType,
            @RequestParam(required = false) String createBy) {
        return Result.success(noticeService.pageNotices(noticeTitle, noticeType, createBy, pageNum, pageSize));
    }

    @PreAuthorize("@ss.hasPermi('system:notice:query')")
    @Log(module = "通知公告", businessType = 4, description = "查询公告详情")
    @GetMapping("/{noticeId}")
    public Result<SysNotice> getInfo(@PathVariable Long noticeId) {
        return Result.success(noticeService.getById(noticeId));
    }

    @PreAuthorize("@ss.hasPermi('system:notice:add')")
    @Log(module = "通知公告", businessType = 1, description = "新增公告")
    @PostMapping
    public Result<Void> add(@Valid @RequestBody SysNotice notice) {
        noticeService.save(notice);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:notice:edit')")
    @Log(module = "通知公告", businessType = 2, description = "修改公告")
    @PutMapping
    public Result<Void> edit(@Valid @RequestBody SysNotice notice) {
        noticeService.updateById(notice);
        return Result.success();
    }

    @PreAuthorize("@ss.hasPermi('system:notice:remove')")
    @Log(module = "通知公告", businessType = 3, description = "删除公告")
    @DeleteMapping("/{noticeIds}")
    public Result<Void> remove(@PathVariable String noticeIds) {
        for (String id : noticeIds.split(",")) {
            noticeService.removeById(Long.parseLong(id));
        }
        return Result.success();
    }
}