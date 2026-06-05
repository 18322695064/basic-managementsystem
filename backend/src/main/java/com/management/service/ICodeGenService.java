package com.management.service;

import com.management.common.PageResult;
import com.management.dto.CodeGenTable;

import java.util.List;
import java.util.Map;

public interface ICodeGenService {
    PageResult<CodeGenTable> selectTableList(String tableName, int pageNum, int pageSize);
    Map<String, Object> selectTableInfo(String tableName);
    Map<String, String> previewCode(String tableName);
    byte[] generateCode(String tableName);
    void createTable(Map<String, Object> tableDef);
    void updateTable(String tableName, Map<String, Object> tableDef);
}
