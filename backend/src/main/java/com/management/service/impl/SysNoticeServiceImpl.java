package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.common.PageResult;
import com.management.entity.SysNotice;
import com.management.mapper.SysNoticeMapper;
import com.management.service.ISysNoticeService;
import org.springframework.stereotype.Service;

@Service
public class SysNoticeServiceImpl extends ServiceImpl<SysNoticeMapper, SysNotice> implements ISysNoticeService {

    @Override
    public PageResult<SysNotice> pageNotices(String noticeTitle, String noticeType, String createBy, int pageNum, int pageSize) {
        Page<SysNotice> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<SysNotice> wrapper = new LambdaQueryWrapper<>();
        if (noticeTitle != null && !noticeTitle.isEmpty()) {
            wrapper.like(SysNotice::getNoticeTitle, noticeTitle);
        }
        if (noticeType != null && !noticeType.isEmpty()) {
            wrapper.eq(SysNotice::getNoticeType, noticeType);
        }
        if (createBy != null && !createBy.isEmpty()) {
            wrapper.eq(SysNotice::getCreateBy, createBy);
        }
        wrapper.orderByDesc(SysNotice::getCreateTime);
        Page<SysNotice> result = page(page, wrapper);
        return new PageResult<>(result.getTotal(), result.getRecords());
    }
}