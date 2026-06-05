package com.management.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("sys_file")
public class SysFile {

    private Long id;
    private String fileName;
    private String originalName;
    private byte[] fileContent;
    private Long fileSize;
    private String fileType;
    private String fileExt;
    private String md5;
    private String uploadBy;
    private LocalDateTime uploadTime;
    private Integer deleted;
}
