package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.management.common.PageResult;
import com.management.entity.SysFile;
import com.management.mapper.SysFileMapper;
import com.management.service.ISysFileService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.security.MessageDigest;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@Service
public class SysFileServiceImpl extends ServiceImpl<SysFileMapper, SysFile> implements ISysFileService {

    private static final Set<String> ALLOWED_EXTENSIONS = new HashSet<>(Arrays.asList(
            ".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp",
            ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx",
            ".txt", ".csv", ".zip", ".rar", ".7z",
            ".mp4", ".mp3", ".wav", ".avi"
    ));

    private static final long MAX_FILE_SIZE = 50 * 1024 * 1024;

    @Override
    public SysFile uploadFile(MultipartFile file) {
        if (file.isEmpty()) {
            throw new RuntimeException("上传文件不能为空");
        }
        if (file.getSize() > MAX_FILE_SIZE) {
            throw new RuntimeException("文件大小不能超过50MB");
        }

        String originalName = file.getOriginalFilename();
        String ext = originalName != null && originalName.contains(".")
                ? originalName.substring(originalName.lastIndexOf(".")).toLowerCase()
                : "";

        if (!ext.isEmpty() && !ALLOWED_EXTENSIONS.contains(ext)) {
            throw new RuntimeException("不支持的文件类型: " + ext);
        }

        try {
            String fileName = java.util.UUID.randomUUID().toString() + ext;

            byte[] fileContent = file.getBytes();
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(fileContent);
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            String md5 = sb.toString();

            LambdaQueryWrapper<SysFile> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(SysFile::getMd5, md5);
            SysFile existing = getOne(wrapper);
            if (existing != null) {
                existing.setFileContent(null);
                return existing;
            }

            SysFile sysFile = new SysFile();
            sysFile.setFileName(fileName);
            sysFile.setOriginalName(originalName);
            sysFile.setFileContent(fileContent);
            sysFile.setFileSize(file.getSize());
            sysFile.setFileType(file.getContentType());
            sysFile.setFileExt(ext);
            sysFile.setMd5(md5);
            sysFile.setUploadTime(LocalDateTime.now());
            save(sysFile);

            sysFile.setFileContent(null);
            return sysFile;
        } catch (Exception e) {
            throw new RuntimeException("文件上传失败: " + e.getMessage(), e);
        }
    }

    @Override
    public PageResult<SysFile> pageFiles(String originalName, String fileType, int pageNum, int pageSize) {
        Page<SysFile> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<SysFile> wrapper = new LambdaQueryWrapper<>();
        if (originalName != null && !originalName.isEmpty()) {
            wrapper.like(SysFile::getOriginalName, originalName);
        }
        if (fileType != null && !fileType.isEmpty()) {
            wrapper.like(SysFile::getFileType, fileType);
        }
        wrapper.orderByDesc(SysFile::getUploadTime);
        wrapper.select(SysFile::getId, SysFile::getFileName, SysFile::getOriginalName,
                      SysFile::getFileSize, SysFile::getFileType, SysFile::getFileExt,
                      SysFile::getMd5, SysFile::getUploadBy, SysFile::getUploadTime);
        Page<SysFile> result = page(page, wrapper);
        return new PageResult<>(result.getTotal(), result.getRecords());
    }

    @Override
    public byte[] downloadFile(Long fileId) {
        SysFile file = getById(fileId);
        return file != null ? file.getFileContent() : null;
    }
}