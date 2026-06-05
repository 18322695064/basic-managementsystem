package com.management.service.impl;

import com.management.common.PageResult;
import com.management.dto.CodeGenColumn;
import com.management.dto.CodeGenTable;
import com.management.service.ICodeGenService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class CodeGenServiceImpl implements ICodeGenService {

    private final JdbcTemplate jdbcTemplate;

    private static final Set<String> BASE_ENTITY_FIELDS = Set.of(
        "id", "create_by", "create_time", "update_by", "update_time", "deleted"
    );

    @Override
    public PageResult<CodeGenTable> selectTableList(String tableName, int pageNum, int pageSize) {
        String countSql = "SELECT count(*) FROM pg_tables WHERE schemaname = 'public'";
        String dataSql = "SELECT tablename AS table_name, obj_description(pc.oid) AS table_comment " +
                         "FROM pg_tables pt LEFT JOIN pg_class pc ON pt.tablename = pc.relname " +
                         "WHERE schemaname = 'public'";
        List<Object> params = new ArrayList<>();
        if (tableName != null && !tableName.isEmpty()) {
            String filter = " AND tablename LIKE ?";
            countSql += filter;
            dataSql += filter;
            params.add("%" + tableName + "%");
        }

        Long total = jdbcTemplate.queryForObject(countSql, Long.class, params.toArray());
        dataSql += " ORDER BY tablename LIMIT ? OFFSET ?";
        params.add(pageSize);
        params.add((pageNum - 1) * pageSize);

        List<CodeGenTable> rows = jdbcTemplate.query(dataSql, (rs, rowNum) -> {
            CodeGenTable t = new CodeGenTable();
            t.setTableName(rs.getString("table_name"));
            t.setTableComment(rs.getString("table_comment"));
            return t;
        }, params.toArray());

        return new PageResult<>(total, rows);
    }

    @Override
    public Map<String, Object> selectTableInfo(String tableName) {
        Map<String, Object> result = new LinkedHashMap<>();

        String tableSql = "SELECT obj_description(pc.oid) AS table_comment " +
                         "FROM pg_tables pt LEFT JOIN pg_class pc ON pt.tablename = pc.relname " +
                         "WHERE schemaname = 'public' AND tablename = ?";
        List<Map<String, Object>> tableRows = jdbcTemplate.queryForList(tableSql, tableName);
        String tableComment = tableRows.isEmpty() ? tableName :
            (String) tableRows.get(0).getOrDefault("table_comment", tableName);
        if (tableComment == null) tableComment = tableName;

        result.put("tableName", tableName);
        result.put("tableComment", tableComment);

        String colSql = "SELECT column_name, data_type, is_nullable, ordinal_position, " +
                        "character_maximum_length, col_description(pc.oid, ordinal_position) AS column_comment " +
                        "FROM information_schema.columns c " +
                        "LEFT JOIN pg_class pc ON c.table_name = pc.relname " +
                        "WHERE table_schema = 'public' AND table_name = ? " +
                        "ORDER BY ordinal_position";
        List<CodeGenColumn> columns = jdbcTemplate.query(colSql, (rs, rowNum) -> {
            CodeGenColumn col = new CodeGenColumn();
            col.setColumnName(rs.getString("column_name"));
            col.setColumnType(rs.getString("data_type"));
            col.setColumnComment(rs.getString("column_comment"));
            col.setIsNullable(rs.getString("is_nullable"));
            col.setOrdinalPosition(rs.getInt("ordinal_position"));
            col.setCharMaxLength(rs.getInt("character_maximum_length"));
            col.setJavaType(mapPgTypeToJava(rs.getString("data_type")));
            col.setJavaField(columnToField(rs.getString("column_name")));
            return col;
        }, tableName);
        result.put("columns", columns);

        return result;
    }

    @Override
    public Map<String, String> previewCode(String tableName) {
        Map<String, Object> tableInfo = selectTableInfo(tableName);
        return generateAllCode(tableInfo);
    }

    @Override
    public byte[] generateCode(String tableName) {
        Map<String, Object> tableInfo = selectTableInfo(tableName);
        Map<String, String> codes = generateAllCode(tableInfo);
        String className = tableNameToClassName(tableName);

        importMenusToDatabase(codes.get("sql"));

        try (ByteArrayOutputStream baos = new ByteArrayOutputStream();
             ZipOutputStream zos = new ZipOutputStream(baos)) {

            addToZip(zos, "java/com/management/entity/" + className + ".java", codes.get("entity"));
            addToZip(zos, "java/com/management/mapper/" + className + "Mapper.java", codes.get("mapper"));
            addToZip(zos, "java/com/management/service/I" + className + "Service.java", codes.get("service"));
            addToZip(zos, "java/com/management/service/impl/" + className + "ServiceImpl.java", codes.get("serviceImpl"));
            addToZip(zos, "java/com/management/controller/" + className + "Controller.java", codes.get("controller"));
            addToZip(zos, "vue/views/" + tableName + "/index.vue", codes.get("vue"));
            addToZip(zos, "vue/api/" + tableName + ".js", codes.get("api"));
            addToZip(zos, "sql/" + tableName + "_menu.sql", codes.get("sql"));

            zos.finish();
            return baos.toByteArray();
        } catch (IOException e) {
            log.error("生成代码失败", e);
            throw new RuntimeException("生成代码失败: " + e.getMessage());
        }
    }

    private void importMenusToDatabase(String sql) {
        if (sql == null || sql.isEmpty()) return;
        try {
            for (String stmt : sql.split(";")) {
                String trimmed = stmt.trim();
                if (trimmed.isEmpty() || trimmed.startsWith("--")) continue;
                jdbcTemplate.execute(trimmed);
            }
            log.info("菜单权限已自动导入 sys_menu 表");
        } catch (Exception e) {
            log.warn("自动导入菜单失败（可手动执行 Menu.sql）: {}", e.getMessage());
        }
    }

    private void addToZip(ZipOutputStream zos, String path, String content) throws IOException {
        zos.putNextEntry(new ZipEntry(path));
        zos.write(content.getBytes(StandardCharsets.UTF_8));
        zos.closeEntry();
    }

    @SuppressWarnings("unchecked")
    private Map<String, String> generateAllCode(Map<String, Object> tableInfo) {
        String tableName = (String) tableInfo.get("tableName");
        String tableComment = (String) tableInfo.get("tableComment");
        List<CodeGenColumn> columns = (List<CodeGenColumn>) tableInfo.get("columns");
        List<CodeGenColumn> bizColumns = columns.stream()
            .filter(c -> !BASE_ENTITY_FIELDS.contains(c.getColumnName()))
            .collect(Collectors.toList());

        String className = tableNameToClassName(tableName);
        String moduleName = tableNameToModuleName(tableName);
        String businessName = tableComment != null && !tableComment.isEmpty() ? tableComment : className;
        String author = "CodeGenerator";
        String date = LocalDate.now().toString();
        String packageName = "com.management";

        Map<String, String> codes = new LinkedHashMap<>();
        codes.put("entity", genEntity(packageName, className, tableName, tableComment, bizColumns, author, date));
        codes.put("mapper", genMapper(packageName, className, author, date));
        codes.put("service", genService(packageName, className, author, date));
        codes.put("serviceImpl", genServiceImpl(packageName, className, moduleName, tableName, bizColumns, author, date));
        codes.put("controller", genController(packageName, className, moduleName, businessName, author, date));
        codes.put("vue", genVue(className, moduleName, businessName, bizColumns));
        codes.put("api", genApi(moduleName, className));
        codes.put("sql", genMenuSql(moduleName, className, businessName));
        return codes;
    }

    private String genEntity(String packageName, String className, String tableName,
                             String tableComment, List<CodeGenColumn> columns,
                             String author, String date) {
        StringBuilder sb = new StringBuilder();
        sb.append("package ").append(packageName).append(".entity;\n\n");
        sb.append("import com.baomidou.mybatisplus.annotation.TableName;\n");
        sb.append("import com.management.common.BaseEntity;\n");
        boolean hasBigDecimal = columns.stream().anyMatch(c -> "BigDecimal".equals(c.getJavaType()));
        boolean hasLocalDate = columns.stream().anyMatch(c -> "LocalDate".equals(c.getJavaType()));
        boolean hasLocalDateTime = columns.stream().anyMatch(c -> "LocalDateTime".equals(c.getJavaType()));
        if (hasBigDecimal) sb.append("import java.math.BigDecimal;\n");
        if (hasLocalDate) sb.append("import java.time.LocalDate;\n");
        if (hasLocalDateTime) sb.append("import java.time.LocalDateTime;\n");
        sb.append("import lombok.Data;\n");
        sb.append("import lombok.EqualsAndHashCode;\n\n");
        if (tableComment != null && !tableComment.isEmpty() && !tableComment.equals(tableName)) {
            sb.append("/**\n * ").append(tableComment).append("\n");
            sb.append(" * @author ").append(author).append("\n");
            sb.append(" * @date ").append(date).append("\n */\n");
        }
        sb.append("@Data\n");
        sb.append("@EqualsAndHashCode(callSuper = true)\n");
        sb.append("@TableName(\"").append(tableName).append("\")\n");
        sb.append("public class ").append(className).append(" extends BaseEntity {\n");
        for (CodeGenColumn col : columns) {
            sb.append("\n");
            if (col.getColumnComment() != null && !col.getColumnComment().isEmpty()) {
                sb.append("    /** ").append(col.getColumnComment()).append(" */\n");
            }
            sb.append("    private ").append(col.getJavaType()).append(" ").append(col.getJavaField()).append(";\n");
        }
        sb.append("}\n");
        return sb.toString();
    }

    private String genMapper(String packageName, String className, String author, String date) {
        return "package " + packageName + ".mapper;\n\n" +
               "import com.baomidou.mybatisplus.core.mapper.BaseMapper;\n" +
               "import " + packageName + ".entity." + className + ";\n" +
               "import org.apache.ibatis.annotations.Mapper;\n\n" +
               "/**\n * " + className + " Mapper\n" +
               " * @author " + author + "\n * @date " + date + "\n */\n" +
               "@Mapper\n" +
               "public interface " + className + "Mapper extends BaseMapper<" + className + "> {\n" +
               "}\n";
    }

    private String genService(String packageName, String className, String author, String date) {
        return "package " + packageName + ".service;\n\n" +
               "import com.baomidou.mybatisplus.extension.service.IService;\n" +
               "import " + packageName + ".entity." + className + ";\n" +
               "import " + packageName + ".common.PageResult;\n\n" +
               "/**\n * " + className + " Service接口\n" +
               " * @author " + author + "\n * @date " + date + "\n */\n" +
               "public interface I" + className + "Service extends IService<" + className + "> {\n" +
               "    PageResult<" + className + "> pageQuery(int pageNum, int pageSize);\n" +
               "}\n";
    }

    private String genServiceImpl(String packageName, String className, String moduleName,
                                  String tableName, List<CodeGenColumn> columns,
                                  String author, String date) {
        StringBuilder sb = new StringBuilder();
        sb.append("package ").append(packageName).append(".service.impl;\n\n");
        sb.append("import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;\n");
        sb.append("import com.baomidou.mybatisplus.extension.plugins.pagination.Page;\n");
        sb.append("import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;\n");
        sb.append("import ").append(packageName).append(".common.PageResult;\n");
        sb.append("import ").append(packageName).append(".entity.").append(className).append(";\n");
        sb.append("import ").append(packageName).append(".mapper.").append(className).append("Mapper;\n");
        sb.append("import ").append(packageName).append(".service.I").append(className).append("Service;\n");
        sb.append("import org.springframework.stereotype.Service;\n\n");
        sb.append("/**\n * ").append(className).append(" Service实现\n");
        sb.append(" * @author ").append(author).append("\n");
        sb.append(" * @date ").append(date).append("\n */\n");
        sb.append("@Service\n");
        sb.append("public class ").append(className).append("ServiceImpl extends ServiceImpl<")
          .append(className).append("Mapper, ").append(className).append("> implements I")
          .append(className).append("Service {\n\n");
        sb.append("    @Override\n");
        sb.append("    public PageResult<").append(className).append("> pageQuery(int pageNum, int pageSize) {\n");
        sb.append("        Page<").append(className).append("> page = new Page<>(pageNum, pageSize);\n");
        sb.append("        LambdaQueryWrapper<").append(className).append("> wrapper = new LambdaQueryWrapper<>();\n");
        sb.append("        wrapper.orderByDesc(").append(className).append("::getCreateTime);\n");
        sb.append("        Page<").append(className).append("> result = page(page, wrapper);\n");
        sb.append("        return new PageResult<>(result.getTotal(), result.getRecords());\n");
        sb.append("    }\n");
        sb.append("}\n");
        return sb.toString();
    }

    private String genController(String packageName, String className, String moduleName,
                                 String businessName, String author, String date) {
        String permsPrefix = "tool:" + moduleName;
        String urlPrefix = "/" + moduleName.replace('-', '/');
        return "package " + packageName + ".controller;\n\n" +
               "import " + packageName + ".annotation.Log;\n" +
               "import " + packageName + ".common.PageResult;\n" +
               "import " + packageName + ".common.Result;\n" +
               "import " + packageName + ".entity." + className + ";\n" +
               "import " + packageName + ".service.I" + className + "Service;\n" +
               "import lombok.RequiredArgsConstructor;\n" +
               "import org.springframework.security.access.prepost.PreAuthorize;\n" +
               "import org.springframework.web.bind.annotation.*;\n\n" +
               "/**\n * " + businessName + " Controller\n" +
               " * @author " + author + "\n * @date " + date + "\n */\n" +
               "@RestController\n" +
               "@RequestMapping(\"" + urlPrefix + "\")\n" +
               "@RequiredArgsConstructor\n" +
               "public class " + className + "Controller {\n\n" +
               "    private final I" + className + "Service " + lowerFirst(className) + "Service;\n\n" +
               "    @PreAuthorize(\"@ss.hasPermi('" + permsPrefix + ":list')\")\n" +
               "    @Log(module = \"" + businessName + "\", businessType = 4, description = \"查询列表\")\n" +
               "    @GetMapping(\"/list\")\n" +
               "    public Result<PageResult<" + className + ">> list(\n" +
               "            @RequestParam(defaultValue = \"1\") Integer pageNum,\n" +
               "            @RequestParam(defaultValue = \"10\") Integer pageSize) {\n" +
               "        return Result.success(" + lowerFirst(className) + "Service.pageQuery(pageNum, pageSize));\n" +
               "    }\n\n" +
               "    @PreAuthorize(\"@ss.hasPermi('" + permsPrefix + ":query')\")\n" +
               "    @Log(module = \"" + businessName + "\", businessType = 4, description = \"查询详情\")\n" +
               "    @GetMapping(\"/{id}\")\n" +
               "    public Result<" + className + "> getInfo(@PathVariable Long id) {\n" +
               "        return Result.success(" + lowerFirst(className) + "Service.getById(id));\n" +
               "    }\n\n" +
               "    @PreAuthorize(\"@ss.hasPermi('" + permsPrefix + ":add')\")\n" +
               "    @Log(module = \"" + businessName + "\", businessType = 1, description = \"新增\")\n" +
               "    @PostMapping\n" +
               "    public Result<Void> add(@RequestBody " + className + " entity) {\n" +
               "        " + lowerFirst(className) + "Service.save(entity);\n" +
               "        return Result.success();\n" +
               "    }\n\n" +
               "    @PreAuthorize(\"@ss.hasPermi('" + permsPrefix + ":edit')\")\n" +
               "    @Log(module = \"" + businessName + "\", businessType = 2, description = \"修改\")\n" +
               "    @PutMapping\n" +
               "    public Result<Void> edit(@RequestBody " + className + " entity) {\n" +
               "        " + lowerFirst(className) + "Service.updateById(entity);\n" +
               "        return Result.success();\n" +
               "    }\n\n" +
               "    @PreAuthorize(\"@ss.hasPermi('" + permsPrefix + ":remove')\")\n" +
               "    @Log(module = \"" + businessName + "\", businessType = 3, description = \"删除\")\n" +
               "    @DeleteMapping(\"/{ids}\")\n" +
               "    public Result<Void> remove(@PathVariable String ids) {\n" +
               "        for (String id : ids.split(\",\")) {\n" +
               "            " + lowerFirst(className) + "Service.removeById(Long.parseLong(id));\n" +
               "        }\n" +
               "        return Result.success();\n" +
               "    }\n" +
               "}\n";
    }

    private String genVue(String className, String moduleName, String businessName,
                         List<CodeGenColumn> columns) {
        String camelName = lowerFirst(className);
        StringBuilder sb = new StringBuilder();
        sb.append("<script setup>\n");
        sb.append("import { ref, reactive, onMounted } from 'vue'\n");
        sb.append("import { list").append(className).append(", add").append(className)
          .append(", update").append(className).append(", del").append(className)
          .append(" } from '@/api/").append(moduleName).append("'\n");
        sb.append("import { message, Modal } from 'ant-design-vue'\n\n");

        sb.append("const loading = ref(false)\n");
        sb.append("const dataSource = ref([])\n");
        sb.append("const total = ref(0)\n");
        sb.append("const queryParams = reactive({\n");
        sb.append("  pageNum: 1,\n");
        sb.append("  pageSize: 10\n");
        sb.append("})\n\n");

        sb.append("const visible = ref(false)\n");
        sb.append("const formTitle = ref('')\n");
        sb.append("const form = reactive({\n");
        sb.append("  id: undefined,\n");
        for (CodeGenColumn col : columns) {
            String defaultValue = getJsDefaultValue(col);
            sb.append("  ").append(col.getJavaField()).append(": ").append(defaultValue).append(",\n");
        }
        sb.append("})\n\n");

        sb.append("const columns = [\n");
        for (CodeGenColumn col : columns) {
            if ("id".equals(col.getColumnName())) {
                sb.append("  { title: 'ID', dataIndex: '").append(col.getJavaField())
                  .append("', width: 80 },\n");
            } else {
                sb.append("  { title: '").append(col.getColumnComment() != null ? col.getColumnComment() : col.getJavaField())
                  .append("', dataIndex: '").append(col.getJavaField()).append("', width: 150 },\n");
            }
        }
        sb.append("  { title: '创建时间', dataIndex: 'createTime', width: 180 },\n");
        sb.append("  { title: '操作', key: 'action', width: 150, fixed: 'right' }\n");
        sb.append("]\n\n");

        sb.append("const getList = async () => {\n");
        sb.append("  loading.value = true\n");
        sb.append("  try {\n");
        sb.append("    const res = await list").append(className).append("(queryParams)\n");
        sb.append("    dataSource.value = res.data.rows || []\n");
        sb.append("    total.value = res.data.total || 0\n");
        sb.append("  } finally {\n");
        sb.append("    loading.value = false\n");
        sb.append("  }\n");
        sb.append("}\n\n");

        sb.append("const handleAdd = () => {\n");
        sb.append("  formTitle.value = '新增").append(businessName).append("'\n");
        sb.append("  Object.assign(form, { id: undefined");
        for (CodeGenColumn col : columns) {
            sb.append(", ").append(col.getJavaField()).append(": ").append(getJsDefaultValue(col));
        }
        sb.append(" })\n");
        sb.append("  visible.value = true\n");
        sb.append("}\n\n");

        sb.append("const handleEdit = (record) => {\n");
        sb.append("  formTitle.value = '修改").append(businessName).append("'\n");
        sb.append("  Object.assign(form, record)\n");
        sb.append("  visible.value = true\n");
        sb.append("}\n\n");

        sb.append("const handleDelete = (record) => {\n");
        sb.append("  Modal.confirm({\n");
        sb.append("    title: '确认删除',\n");
        sb.append("    content: `确定要删除该记录吗？`,\n");
        sb.append("    okText: '确定',\n");
        sb.append("    cancelText: '取消',\n");
        sb.append("    onOk: async () => {\n");
        sb.append("      await del").append(className).append("(record.id)\n");
        sb.append("      message.success('删除成功')\n");
        sb.append("      getList()\n");
        sb.append("    }\n");
        sb.append("  })\n");
        sb.append("}\n\n");

        sb.append("const handleSubmit = async () => {\n");
        sb.append("  if (form.id) {\n");
        sb.append("    await update").append(className).append("(form)\n");
        sb.append("    message.success('修改成功')\n");
        sb.append("  } else {\n");
        sb.append("    await add").append(className).append("(form)\n");
        sb.append("    message.success('新增成功')\n");
        sb.append("  }\n");
        sb.append("  visible.value = false\n");
        sb.append("  getList()\n");
        sb.append("}\n\n");

        sb.append("const handleSearch = () => {\n");
        sb.append("  queryParams.pageNum = 1\n");
        sb.append("  getList()\n");
        sb.append("}\n\n");

        sb.append("const handleReset = () => {\n");
        sb.append("  queryParams.pageNum = 1\n");
        sb.append("  getList()\n");
        sb.append("}\n\n");

        sb.append("const handleTableChange = (pagination) => {\n");
        sb.append("  queryParams.pageNum = pagination.current\n");
        sb.append("  queryParams.pageSize = pagination.pageSize\n");
        sb.append("  getList()\n");
        sb.append("}\n\n");

        sb.append("onMounted(() => {\n");
        sb.append("  getList()\n");
        sb.append("})\n");
        sb.append("</script>\n\n");

        sb.append("<template>\n");
        sb.append("  <div>\n");
        sb.append("    <a-card>\n");
        sb.append("      <a-form layout=\"inline\" style=\"margin-bottom: 16px\">\n");
        sb.append("        <a-form-item>\n");
        sb.append("          <a-space>\n");
        sb.append("            <a-button type=\"primary\" @click=\"handleSearch\">搜索</a-button>\n");
        sb.append("            <a-button @click=\"handleReset\">重置</a-button>\n");
        sb.append("          </a-space>\n");
        sb.append("        </a-form-item>\n");
        sb.append("      </a-form>\n\n");

        sb.append("      <a-space style=\"margin-bottom: 16px\">\n");
        sb.append("        <a-button type=\"primary\" @click=\"handleAdd\" v-hasPermi=\"['tool:").append(moduleName).append(":add']\">新增</a-button>\n");
        sb.append("      </a-space>\n\n");

        sb.append("      <a-table\n");
        sb.append("        :columns=\"columns\"\n");
        sb.append("        :data-source=\"dataSource\"\n");
        sb.append("        :loading=\"loading\"\n");
        sb.append("        :pagination=\"{\n");
        sb.append("          current: queryParams.pageNum,\n");
        sb.append("          pageSize: queryParams.pageSize,\n");
        sb.append("          total: total,\n");
        sb.append("          showSizeChanger: true,\n");
        sb.append("          showQuickJumper: true,\n");
        sb.append("          showTotal: (total) => `共 ${total} 条`\n");
        sb.append("        }\"\n");
        sb.append("        @change=\"handleTableChange\"\n");
        sb.append("        row-key=\"id\"\n");
        sb.append("        :scroll=\"{ x: 1000 }\"\n");
        sb.append("      >\n");
        sb.append("        <template #bodyCell=\"{ column, record }\">\n");
        sb.append("          <template v-if=\"column.key === 'action'\">\n");
        sb.append("            <a-space>\n");
        sb.append("              <a @click=\"handleEdit(record)\" v-hasPermi=\"['tool:").append(moduleName).append(":edit']\">修改</a>\n");
        sb.append("              <a @click=\"handleDelete(record)\" style=\"color: #ff4d4f\" v-hasPermi=\"['tool:").append(moduleName).append(":remove']\">删除</a>\n");
        sb.append("            </a-space>\n");
        sb.append("          </template>\n");
        sb.append("        </template>\n");
        sb.append("      </a-table>\n");
        sb.append("    </a-card>\n\n");

        sb.append("    <a-modal v-model:open=\"visible\" :title=\"formTitle\" @ok=\"handleSubmit\" :width=\"600\" okText=\"确定\" cancelText=\"取消\">\n");
        sb.append("      <a-form :model=\"form\" :label-col=\"{ span: 4 }\">\n");
        for (CodeGenColumn col : columns) {
            sb.append("        <a-form-item label=\"").append(col.getColumnComment() != null ? col.getColumnComment() : col.getJavaField()).append("\">\n");
            sb.append("          <a-input v-model:value=\"form.").append(col.getJavaField()).append("\" placeholder=\"请输入")
              .append(col.getColumnComment() != null ? col.getColumnComment() : col.getJavaField()).append("\" />\n");
            sb.append("        </a-form-item>\n");
        }
        sb.append("      </a-form>\n");
        sb.append("    </a-modal>\n");
        sb.append("  </div>\n");
        sb.append("</template>\n");

        return sb.toString();
    }

    private String genApi(String moduleName, String className) {
        return "import request from '@/utils/request'\n\n" +
               "export function list" + className + "(params) {\n" +
               "  return request({\n" +
               "    url: '/" + moduleName + "/list',\n" +
               "    method: 'get',\n" +
               "    params\n" +
               "  })\n" +
               "}\n\n" +
               "export function get" + className + "(id) {\n" +
               "  return request({\n" +
               "    url: '/" + moduleName + "/' + id,\n" +
               "    method: 'get'\n" +
               "  })\n" +
               "}\n\n" +
               "export function add" + className + "(data) {\n" +
               "  return request({\n" +
               "    url: '/" + moduleName + "',\n" +
               "    method: 'post',\n" +
               "    data\n" +
               "  })\n" +
               "}\n\n" +
               "export function update" + className + "(data) {\n" +
               "  return request({\n" +
               "    url: '/" + moduleName + "',\n" +
               "    method: 'put',\n" +
               "    data\n" +
               "  })\n" +
               "}\n\n" +
               "export function del" + className + "(ids) {\n" +
               "  return request({\n" +
               "    url: '/" + moduleName + "/' + ids,\n" +
               "    method: 'delete'\n" +
               "  })\n" +
               "}\n";
    }

    private String genMenuSql(String moduleName, String className, String businessName) {
        Long maxId = jdbcTemplate.queryForObject("SELECT COALESCE(MAX(id), 0) FROM sys_menu", Long.class);
        long parentId = (maxId != null ? maxId : 0) + 1;
        long menuId = parentId + 1;
        long btnBase = parentId + 2;

        return "-- " + businessName + " 菜单权限SQL\n" +
               "-- 自动生成，已执行到数据库\n\n" +
               "INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, path, component, perms, icon, sort_order, status, visible, deleted) VALUES\n" +
               "(" + parentId + ", 0, '" + businessName + "管理', 'M', '" + moduleName + "', NULL, NULL, 'AppstoreOutlined', 0, '0', '0', 0);\n\n" +
               "INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, path, component, perms, icon, sort_order, status, visible, deleted) VALUES\n" +
               "(" + menuId + ", " + parentId + ", '" + businessName + "查询', 'C', '" + moduleName + "', '" + moduleName + "/index', 'tool:" + moduleName + ":list', 'SearchOutlined', 0, '0', '0', 0);\n\n" +
               "INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, perms, sort_order, status, deleted) VALUES\n" +
               "(" + (btnBase) + ", " + menuId + ", '" + businessName + "新增', 'F', 'tool:" + moduleName + ":add', 0, '0', 0);\n\n" +
               "INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, perms, sort_order, status, deleted) VALUES\n" +
               "(" + (btnBase + 1) + ", " + menuId + ", '" + businessName + "修改', 'F', 'tool:" + moduleName + ":edit', 0, '0', 0);\n\n" +
               "INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, perms, sort_order, status, deleted) VALUES\n" +
               "(" + (btnBase + 2) + ", " + menuId + ", '" + businessName + "删除', 'F', 'tool:" + moduleName + ":remove', 0, '0', 0);\n\n" +
               "INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, perms, sort_order, status, deleted) VALUES\n" +
               "(" + (btnBase + 3) + ", " + menuId + ", '" + businessName + "详情', 'F', 'tool:" + moduleName + ":query', 0, '0', 0);\n";
    }

    private String mapPgTypeToJava(String pgType) {
        if (pgType == null) return "String";
        return switch (pgType.toLowerCase()) {
            case "bigint", "int8" -> "Long";
            case "integer", "int", "int4" -> "Integer";
            case "smallint", "int2" -> "Integer";
            case "character varying", "varchar", "char", "character", "text", "uuid", "json", "jsonb" -> "String";
            case "timestamp without time zone", "timestamp with time zone", "timestamptz" -> "LocalDateTime";
            case "date" -> "LocalDate";
            case "numeric", "decimal" -> "BigDecimal";
            case "boolean", "bool" -> "Boolean";
            case "double precision", "float8" -> "Double";
            case "real", "float4" -> "Float";
            case "time without time zone", "time with time zone" -> "LocalTime";
            default -> "String";
        };
    }

    private String columnToField(String columnName) {
        if (columnName == null || columnName.isEmpty()) return "";
        String[] parts = columnName.split("_");
        StringBuilder sb = new StringBuilder(parts[0].toLowerCase());
        for (int i = 1; i < parts.length; i++) {
            String part = parts[i];
            sb.append(part.substring(0, 1).toUpperCase());
            sb.append(part.substring(1).toLowerCase());
        }
        return sb.toString();
    }

    private String tableNameToClassName(String tableName) {
        if (tableName == null || tableName.isEmpty()) return "";
        String[] parts = tableName.split("_");
        StringBuilder sb = new StringBuilder();
        for (String part : parts) {
            if (!part.isEmpty()) {
                sb.append(part.substring(0, 1).toUpperCase());
                if (part.length() > 1) sb.append(part.substring(1).toLowerCase());
            }
        }
        return sb.toString();
    }

    private String tableNameToModuleName(String tableName) {
        return tableName.replace('_', '-').toLowerCase();
    }

    private String lowerFirst(String s) {
        if (s == null || s.isEmpty()) return s;
        return s.substring(0, 1).toLowerCase() + s.substring(1);
    }

    private String getJsDefaultValue(CodeGenColumn col) {
        String type = col.getJavaType();
        if ("Long".equals(type) || "Integer".equals(type) || "Double".equals(type) || "Float".equals(type)) return "undefined";
        if ("Boolean".equals(type)) return "false";
        return "''";
    }

    @Override
    public void createTable(Map<String, Object> tableDef) {
        String tableName = (String) tableDef.get("tableName");
        String tableComment = (String) tableDef.getOrDefault("tableComment", "");
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> columns = (List<Map<String, Object>>) tableDef.get("columns");

        validateIdentifier(tableName);
        StringBuilder sql = new StringBuilder();
        sql.append("CREATE TABLE ").append(quoteIdentifier(tableName)).append(" (\n");
        sql.append("  id bigint NOT NULL PRIMARY KEY,\n");

        for (int i = 0; i < columns.size(); i++) {
            Map<String, Object> col = columns.get(i);
            String colName = (String) col.get("columnName");
            String colType = (String) col.get("columnType");
            Integer colLength = parseLength(col.get("length"));
            String isNullable = (String) col.getOrDefault("isNullable", "YES");
            String defaultValue = (String) col.get("defaultValue");
            if (colName == null || colName.isEmpty()) continue;
            if (BASE_ENTITY_FIELDS.contains(colName)) continue;
            validateIdentifier(colName);

            sql.append("  ").append(quoteIdentifier(colName)).append(" ").append(buildColumnType(colType, colLength));
            if ("NO".equals(isNullable)) {
                sql.append(" NOT NULL");
            }
            if (defaultValue != null && !defaultValue.isEmpty()) {
                sql.append(" DEFAULT ").append(defaultValue);
            }
            sql.append(",\n");
        }

        sql.append("  create_by varchar(64),\n");
        sql.append("  create_time timestamp,\n");
        sql.append("  update_by varchar(64),\n");
        sql.append("  update_time timestamp,\n");
        sql.append("  deleted smallint DEFAULT 0\n");
        sql.append(")");

        log.info("执行建表SQL: {}", sql);
        jdbcTemplate.execute(sql.toString());

        if (tableComment != null && !tableComment.isEmpty()) {
            jdbcTemplate.execute("COMMENT ON TABLE " + quoteIdentifier(tableName) + " IS '" + tableComment.replace("'", "''") + "'");
        }
        for (Map<String, Object> col : columns) {
            String colName = (String) col.get("columnName");
            String colComment = (String) col.getOrDefault("comment", "");
            if (colComment != null && !colComment.isEmpty()) {
                jdbcTemplate.execute("COMMENT ON COLUMN " + quoteIdentifier(tableName) + "." + quoteIdentifier(colName) + " IS '" + colComment.replace("'", "''") + "'");
            }
        }
    }

    @Override
    public void updateTable(String tableName, Map<String, Object> tableDef) {
        validateIdentifier(tableName);
        String tableComment = (String) tableDef.getOrDefault("tableComment", "");
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> columns = (List<Map<String, Object>>) tableDef.getOrDefault("columns", List.of());

        if (tableComment != null && !tableComment.isEmpty()) {
            jdbcTemplate.execute("COMMENT ON TABLE " + quoteIdentifier(tableName) + " IS '" + tableComment.replace("'", "''") + "'");
        }

        for (Map<String, Object> col : columns) {
            String colName = (String) col.get("columnName");
            if (colName == null || colName.isEmpty()) continue;
            validateIdentifier(colName);
            String action = (String) col.getOrDefault("_action", "");
            boolean isExisting = Boolean.TRUE.equals(col.get("_existing"));

            if ("drop".equals(action)) {
                jdbcTemplate.execute("ALTER TABLE " + quoteIdentifier(tableName) + " DROP COLUMN " + quoteIdentifier(colName));
                continue;
            }

            if ("modify".equals(action) && isExisting) {
                alterColumn(tableName, col);
                continue;
            }

            if (!isExisting) {
                addColumn(tableName, col);
            }
        }
    }

    private void alterColumn(String tableName, Map<String, Object> col) {
        String colName = (String) col.get("columnName");
        if (BASE_ENTITY_FIELDS.contains(colName)) return;
        String colType = (String) col.get("columnType");
        Integer colLength = parseLength(col.get("length"));
        String isNullable = (String) col.getOrDefault("isNullable", "YES");
        String defaultValue = (String) col.getOrDefault("defaultValue", "");

        jdbcTemplate.execute("ALTER TABLE " + quoteIdentifier(tableName)
            + " ALTER COLUMN " + quoteIdentifier(colName)
            + " TYPE " + buildColumnType(colType, colLength)
            + " USING " + quoteIdentifier(colName) + "::" + buildColumnType(colType, colLength));

        if ("NO".equals(isNullable)) {
            jdbcTemplate.execute("ALTER TABLE " + quoteIdentifier(tableName)
                + " ALTER COLUMN " + quoteIdentifier(colName) + " SET NOT NULL");
        } else {
            jdbcTemplate.execute("ALTER TABLE " + quoteIdentifier(tableName)
                + " ALTER COLUMN " + quoteIdentifier(colName) + " DROP NOT NULL");
        }

        if (defaultValue != null && !defaultValue.isEmpty()) {
            jdbcTemplate.execute("ALTER TABLE " + quoteIdentifier(tableName)
                + " ALTER COLUMN " + quoteIdentifier(colName) + " SET DEFAULT " + defaultValue);
        } else {
            try {
                jdbcTemplate.execute("ALTER TABLE " + quoteIdentifier(tableName)
                    + " ALTER COLUMN " + quoteIdentifier(colName) + " DROP DEFAULT");
            } catch (Exception ignored) {}
        }

        String colComment = (String) col.getOrDefault("comment", "");
        if (colComment != null && !colComment.isEmpty()) {
            jdbcTemplate.execute("COMMENT ON COLUMN " + quoteIdentifier(tableName) + "." + quoteIdentifier(colName) + " IS '" + colComment.replace("'", "''") + "'");
        }
    }

    private void addColumn(String tableName, Map<String, Object> col) {
        String colName = (String) col.get("columnName");
        if (BASE_ENTITY_FIELDS.contains(colName)) return;
        String colType = (String) col.get("columnType");
        Integer colLength = parseLength(col.get("length"));
        String isNullable = (String) col.getOrDefault("isNullable", "YES");
        String defaultValue = (String) col.get("defaultValue");

        StringBuilder alterSql = new StringBuilder();
        alterSql.append("ALTER TABLE ").append(quoteIdentifier(tableName))
                 .append(" ADD COLUMN ").append(quoteIdentifier(colName))
                 .append(" ").append(buildColumnType(colType, colLength));
        if ("NO".equals(isNullable)) {
            alterSql.append(" NOT NULL");
        }
        if (defaultValue != null && !defaultValue.isEmpty()) {
            alterSql.append(" DEFAULT ").append(defaultValue);
        }
        jdbcTemplate.execute(alterSql.toString());

        String colComment = (String) col.getOrDefault("comment", "");
        if (colComment != null && !colComment.isEmpty()) {
            jdbcTemplate.execute("COMMENT ON COLUMN " + quoteIdentifier(tableName) + "." + quoteIdentifier(colName) + " IS '" + colComment.replace("'", "''") + "'");
        }
    }

    private void validateIdentifier(String name) {
        if (name == null || !name.matches("^[a-zA-Z_][a-zA-Z0-9_]*$")) {
            throw new IllegalArgumentException("非法标识符: " + name);
        }
    }

    private String quoteIdentifier(String name) {
        return "\"" + name.replace("\"", "\"\"") + "\"";
    }

    private Integer parseLength(Object val) {
        if (val == null) return null;
        if (val instanceof Number) return ((Number) val).intValue();
        try {
            return Integer.parseInt(val.toString().trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private String buildColumnType(String colType, Integer length) {
        if (colType == null) return "varchar(255)";
        String type = colType.toLowerCase();
        if (length != null && length > 0) {
            if ("varchar".equals(type) || "character varying".equals(type) || "char".equals(type)) {
                return type + "(" + length + ")";
            }
            if ("numeric".equals(type) || "decimal".equals(type)) {
                return type + "(" + length + ",2)";
            }
        }
        return switch (type) {
            case "varchar", "character varying" -> "varchar(255)";
            case "char", "character" -> "char(1)";
            case "int", "integer", "int4" -> "integer";
            case "bigint", "int8" -> "bigint";
            case "smallint", "int2" -> "smallint";
            case "numeric", "decimal" -> "numeric(10,2)";
            case "boolean", "bool" -> "boolean";
            case "text" -> "text";
            case "timestamp" -> "timestamp";
            case "date" -> "date";
            case "double", "double precision", "float8" -> "double precision";
            case "float", "real", "float4" -> "real";
            default -> type;
        };
    }
}
