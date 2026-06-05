package com.management.controller;

import com.management.annotation.Log;
import com.management.common.PageResult;
import com.management.common.Result;
import com.management.entity.SysFile;
import com.management.service.ISysFileService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/system/file")
@RequiredArgsConstructor
public class SysFileController {

    private final ISysFileService fileService;

    @PreAuthorize("@ss.hasPermi('system:file:upload')")
    @Log(module = "文件管理", businessType = 1, description = "上传文件")
    @PostMapping("/upload")
    public Result<SysFile> upload(@RequestParam("file") MultipartFile file) {
        try {
            return Result.success(fileService.uploadFile(file));
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    @PreAuthorize("@ss.hasPermi('system:file:download')")
    @Log(module = "文件管理", businessType = 4, description = "下载文件")
    @GetMapping("/download/{fileId}")
    public ResponseEntity<byte[]> download(@PathVariable Long fileId) {
        SysFile file = fileService.getById(fileId);
        if (file == null || file.getFileContent() == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(file.getFileType()))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getOriginalName() + "\"")
                .body(file.getFileContent());
    }

    @PreAuthorize("@ss.hasPermi('system:file:download')")
    @GetMapping("/preview/{fileId}")
    public ResponseEntity<byte[]> preview(@PathVariable Long fileId) {
        SysFile file = fileService.getById(fileId);
        if (file == null || file.getFileContent() == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(file.getFileType()))
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + file.getOriginalName() + "\"")
                .body(file.getFileContent());
    }

    @PreAuthorize("@ss.hasPermi('system:file:list') or @ss.hasPermi('system:file:query')")
    @Log(module = "文件管理", businessType = 4, description = "查询文件列表")
    @GetMapping("/list")
    public Result<PageResult<SysFile>> list(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String originalName,
            @RequestParam(required = false) String fileType) {
        return Result.success(fileService.pageFiles(originalName, fileType, pageNum, pageSize));
    }

    @PreAuthorize("@ss.hasPermi('system:file:remove')")
    @Log(module = "文件管理", businessType = 3, description = "删除文件")
    @DeleteMapping("/{fileIds}")
    public Result<Void> remove(@PathVariable String fileIds) {
        for (String id : fileIds.split(",")) {
            fileService.removeById(Long.parseLong(id));
        }
        return Result.success();
    }
}