package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.common.PageResult;
import com.management.entity.SysFile;
import org.springframework.web.multipart.MultipartFile;

public interface ISysFileService extends IService<SysFile> {

    SysFile uploadFile(MultipartFile file);

    PageResult<SysFile> pageFiles(String originalName, String fileType, int pageNum, int pageSize);

    byte[] downloadFile(Long fileId);
}