package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.common.PageResult;
import com.management.entity.SysNotice;

public interface ISysNoticeService extends IService<SysNotice> {

    PageResult<SysNotice> pageNotices(String noticeTitle, String noticeType, String createBy, int pageNum, int pageSize);
}