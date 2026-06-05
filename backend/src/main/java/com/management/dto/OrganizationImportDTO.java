package com.management.dto;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

@Data
public class OrganizationImportDTO {

    @ExcelProperty("组织名称")
    private String orgName;

    @ExcelProperty("组织地址")
    private String orgAddress;

    @ExcelProperty("上级组织编号")
    private String superOrg;

    @ExcelProperty("备注")
    private String remark;

    @ExcelProperty("级别")
    private String grade;

    @ExcelProperty("排序")
    private Integer sortorder;
}
