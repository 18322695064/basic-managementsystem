# basic-managementsystem
管理系统 (Management System) — 一套前后端分离的企业级后台管理系统。
技术栈
层级	技术
前端	Vue 3 + Vite 8 + Ant Design Vue 4 + Pinia 3 + Vue Router 4
后端	Spring Boot 3.2.5 + MyBatis-Plus 3.5.5 + Java 17
安全	Spring Security + JWT (jjwt) + BCrypt
数据库	PostgreSQL + Redis
工具	Hutool, EasyExcel, SpringDoc OpenAPI, vue-i18n
功能模块
- 系统管理：用户 / 角色 / 菜单权限 / 组织架构 / 字典 / 参数配置 / 通知公告
- 监控管理：操作日志 / 登录日志 / 在线用户
- 开发工具：文件管理（MD5 去重上传下载） / 代码生成器（数据库表 → 全量 CRUD 代码）
- 权限体系：RBAC 按钮级权限 + 4 级数据范围（全部/部门/部门及子级/仅本人）
- 国际化：中英文双语（前后端均支持）
目录结构
management/
├── backend/     # Spring Boot 后端 (Maven)
├── frontend/    # Vue 3 前端 (npm/Vite)
├── db/          # 数据库初始化脚本 (15 张表)
└── 系统评价.md   # 项目评估文档
快速启动
# 后端 (JDK 17, PostgreSQL, Redis 需已运行)
cd backend && mvn spring-boot:run

# 前端 (端口 3000, 代理 /api 到 8080)
cd frontend && npm run dev
