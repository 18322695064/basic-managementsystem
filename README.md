# basic-managementsystem

**管理系统 (Management System)** — 前后端分离的企业级后台管理系统。基于 RBAC 权限模型，提供用户、角色、菜单、部门、字典、代码生成等核心功能，可作为业务系统的快速开发脚手架。

---

## 技术栈

| 层级     | 技术                                                              |
| -------- | ----------------------------------------------------------------- |
| 前端框架 | Vue 3 (Composition API) + Vite 8 + TypeScript                     |
| UI 组件  | Ant Design Vue 4                                                  |
| 状态管理 | Pinia 3                                                           |
| 路由     | Vue Router 4                                                      |
| HTTP     | Axios                                                             |
| 国际化   | vue-i18n (zh-CN / en-US)                                          |
| 后端框架 | Spring Boot 3.2.5 + Java 17                                       |
| ORM      | MyBatis-Plus 3.5.5                                                 |
| 安全     | Spring Security + JWT (jjwt) + BCrypt                             |
| 数据库   | PostgreSQL + Redis                                                |
| 工具库   | Hutool 5.8、EasyExcel 3.3、SpringDoc OpenAPI 2.3                  |
| 测试     | Vitest + Playwright (前端) / JUnit 5 + Spring Test (后端)         |

---

## 功能模块

### 系统管理
- **用户管理** — 增删改查、角色分配、部门分配、密码重置、状态启停、Excel 导入导出
- **角色管理** — 增删改查、菜单权限树分配、4 级数据范围（全部/本部/本部及下级/仅本人）
- **菜单管理** — 目录/菜单/按钮三级树形管理、路由路径、组件路径、权限标识、图标选择
- **部门管理** — 组织架构树、导入导出
- **字典管理** — 字典类型 + 字典数据两级管理
- **参数配置** — 系统参数键值对维护
- **通知公告** — 公告增删改查、状态启停

### 监控管理
- **操作日志** — 基于 AOP `@Log` 注解自动记录、按类型/状态筛选、一键清空
- **登录日志** — 记录登录用户/IP/浏览器/OS/状态、筛选导出
- **在线用户** — 查看当前活跃 Token 用户、强制下线

### 开发工具
- **文件管理** — 文件上传（MD5 去重）、下载、删除
- **代码生成器** — 数据库表 → Entity/Mapper/Service/Controller/Vue 全量 CRUD 代码预览与 ZIP 下载，支持在线建表

### 权限体系
- **RBAC 按钮级权限** — 前端 `v-hasPermi` 指令 + 后端 `@PreAuthorize` 双重校验
- **4 级数据范围** — 全部数据 / 本部门 / 本部门及下级 / 仅本人，MyBatis-Plus 拦截器注入
- **JWT 双令牌** — Access Token 30min + Refresh Token 7d，登出加入黑名单
- **登录安全** — 图形验证码 (Redis)、5 次失败锁定 10 分钟、接口限流 `@RateLimit`

---

## 目录结构

```
management/
├── backend/                    # Spring Boot 后端
│   ├── src/main/java/com/management/
│   │   ├── controller/         # REST 控制器 (Auth/SysUser/SysRole/CodeGen...)
│   │   ├── service/            # 业务逻辑层
│   │   ├── mapper/             # MyBatis-Plus Mapper
│   │   ├── entity/             # 实体类
│   │   ├── dto/                # 数据传输对象
│   │   ├── security/           # JWT + Spring Security 配置
│   │   ├── config/             # 项目配置 (Security/Redis/MyBatis...)
│   │   ├── aspectj/            # AOP 操作日志切面
│   │   ├── interceptor/        # 接口限流拦截器
│   │   ├── filter/             # XSS 过滤器
│   │   └── annotation/         # @Log @RateLimit 自定义注解
│   └── src/test/               # 后端单元测试
│
├── frontend/                   # Vue 3 前端
│   ├── src/
│   │   ├── api/                # API 接口封装 (11 个模块)
│   │   ├── views/              # 页面组件
│   │   │   ├── dashboard/      # 首页仪表盘
│   │   │   ├── login/          # 登录页
│   │   │   ├── system/         # 系统管理 (user/role/menu/dept/dict/config/notice)
│   │   │   ├── monitor/        # 监控管理 (operlog/loginlog/online)
│   │   │   └── tool/           # 开发工具 (gen/file)
│   │   ├── store/              # Pinia 状态管理 (user/permission/app/dict)
│   │   ├── router/             # 路由配置 (含权限守卫)
│   │   ├── layout/             # 主布局 (侧边栏/顶栏/标签页)
│   │   ├── components/         # 公共组件
│   │   ├── directive/          # 自定义指令 v-hasPermi / v-hasRole
│   │   ├── i18n/               # 国际化语言包
│   │   └── utils/              # 工具函数 (Axios 封装/token 管理)
│   ├── e2e/                    # Playwright E2E 测试
│   └── public/                 # 静态资源
│
└── db/                         # 数据库脚本
    ├── init.sql                # 15 张表 DDL + 初始化数据
    └── menu_gen.sql            # 代码生成器菜单权限
```

---

## 环境变量

| 变量                  | 说明           | 默认值      |
| --------------------- | -------------- | ----------- |
| `VITE_API_BASE_URL`   | 后端 API 前缀  | `/api`      |
| `VITE_APP_TITLE`      | 应用标题       | `管理系统`  |

前端开发模式通过 Vite proxy 将 `/api` 代理到 `http://localhost:8080`。

---

## API 文档

后端集成 SpringDoc OpenAPI，启动后端后访问：

- Swagger UI: `http://localhost:8080/swagger-ui`
- OpenAPI JSON: `http://localhost:8080/v3/api-docs`

---

## 快速启动

```bash
# 1. 初始化数据库 — 在 PostgreSQL 中执行 db/init.sql + db/menu_gen.sql
# 2. 配置 application.yml 中的数据库和 Redis 连接信息

# 启动后端 (JDK 17 + Maven)
cd backend && mvn spring-boot:run          # 端口 8080

# 启动前端
cd frontend && npm install && npm run dev   # 端口 3000
```

默认管理员账号：`admin` / `superAdmin@088`

---

## 运行测试

```bash
# 前端单元测试 (Vitest)
cd frontend && npm test

# 前端 E2E 测试 (Playwright, 需先启动前后端)
cd frontend && npx playwright test

# 后端测试
cd backend && mvn test
```
