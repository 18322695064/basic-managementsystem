package com.management.dto;

import lombok.Data;

@Data
public class CodeGenColumn {
    private String columnName;
    private String columnType;
    private String columnComment;
    private Integer ordinalPosition;
    private String isNullable;
    private Integer charMaxLength;
    private String javaType;
    private String javaField;
}
