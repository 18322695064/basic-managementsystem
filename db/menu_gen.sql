-- =============================================
-- 代码生成器 菜单权限 SQL
-- 执行前请确认 sys_menu 表中无冲突的 ID
-- =============================================

-- 1. 父目录: 开发工具 (M类型)
INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, path, component, perms, icon, sort_order, status, visible, deleted)
VALUES (2000, 0, '开发工具', 'M', 'tool', NULL, NULL, 'AppstoreOutlined', 3, '0', '0', 0);

-- 2. 菜单: 代码生成器 (C类型)
INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, path, component, perms, icon, sort_order, status, visible, deleted)
VALUES (2001, 2000, '代码生成器', 'C', 'gen', 'tool/gen/index', 'tool:gen:list', 'CodeOutlined', 1, '0', '0', 0);

-- 3. 按钮: 查询详情
INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, perms, sort_order, status, deleted)
VALUES (2002, 2001, '查询详情', 'F', 'tool:gen:query', 1, '0', 0);

-- 4. 按钮: 预览代码
INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, perms, sort_order, status, deleted)
VALUES (2003, 2001, '预览代码', 'F', 'tool:gen:preview', 2, '0', 0);

-- 5. 按钮: 生成代码
INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, perms, sort_order, status, deleted)
VALUES (2004, 2001, '生成代码', 'F', 'tool:gen:generate', 3, '0', 0);

-- 6. 按钮: 新增表
INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, perms, sort_order, status, deleted)
VALUES (2005, 2001, '新增表', 'F', 'tool:gen:add', 4, '0', 0);

-- 7. 按钮: 修改表
INSERT INTO sys_menu (id, parent_id, menu_name, menu_type, perms, sort_order, status, deleted)
VALUES (2006, 2001, '修改表', 'F', 'tool:gen:edit', 5, '0', 0);
