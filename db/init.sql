-- ============================================================
-- 管理系统 数据库初始化脚本
-- 数据库: management_system (PostgreSQL)
-- 导出时间: 2026-06-03
-- 使用方法: psql -U postgres -d management_system -f db/init.sql
-- ============================================================

-- -------------------------------------------
-- 表: organization
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS organization (
    id character varying(32) NOT NULL,
    org_name character varying(100) NOT NULL,
    org_address character varying(200),
    org_duty character varying(100),
    super_org character varying(32),
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    remark character varying(200),
    grade character varying(10) NOT NULL,
    city_code character varying,
    admin integer,
    is_warn integer,
    group_num integer,
    admin_level integer,
    org_type integer,
    ad_id character varying(60),
    sortorder integer,
    isfold character varying(10),
    iske character varying(10),
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: role
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS role (
    id character varying(32) NOT NULL DEFAULT NULL::character varying,
    role_name character varying(60) NOT NULL DEFAULT NULL::character varying,
    create_time timestamp without time zone DEFAULT NULL::timestamp without time zone,
    remarks text DEFAULT NULL::character varying,
    role_type character varying(60),
    role_code character varying(100),
    role_system character varying(100),
    update_time timestamp without time zone,
    deleted integer DEFAULT 0,
    data_scope character varying(20) DEFAULT '1'::character varying,
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: role_menu
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS role_menu (
    id bigint NOT NULL DEFAULT nextval('role_menu_id_seq'::regclass),
    role_id character varying NOT NULL,
    menu_id bigint NOT NULL,
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: role_user
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS role_user (
    id character varying(32) NOT NULL DEFAULT NULL::character varying,
    user_id character varying(32) NOT NULL DEFAULT NULL::character varying,
    role_id character varying(32) NOT NULL DEFAULT NULL::character varying,
    remark character varying(100) DEFAULT NULL::character varying,
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: sys_config
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS sys_config (
    id bigint NOT NULL,
    config_name character varying(100) NOT NULL,
    config_key character varying(100) NOT NULL,
    config_value character varying(1000) NOT NULL,
    config_type character(1) DEFAULT 'N'::bpchar,
    remark character varying(500),
    create_by character varying(64),
    create_time timestamp without time zone,
    update_by character varying(64),
    update_time timestamp without time zone,
    deleted smallint DEFAULT 0,
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: sys_dict_data
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS sys_dict_data (
    id bigint NOT NULL,
    dict_type character varying(100) NOT NULL,
    dict_label character varying(100) NOT NULL,
    dict_value character varying(100) NOT NULL,
    dict_sort integer DEFAULT 0,
    css_class character varying(100),
    list_class character varying(100),
    is_default character(1) DEFAULT 'N'::bpchar,
    status character(1) DEFAULT '0'::bpchar,
    create_by character varying(64),
    create_time timestamp without time zone,
    update_by character varying(64),
    update_time timestamp without time zone,
    deleted smallint DEFAULT 0,
    remark character varying(500),
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: sys_dict_type
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS sys_dict_type (
    id bigint NOT NULL,
    dict_name character varying(100) NOT NULL,
    dict_type character varying(100) NOT NULL,
    status character(1) DEFAULT '0'::bpchar,
    remark character varying(500),
    create_by character varying(64),
    create_time timestamp without time zone,
    update_by character varying(64),
    update_time timestamp without time zone,
    deleted smallint DEFAULT 0,
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: sys_file
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS sys_file (
    id bigint NOT NULL,
    file_name character varying(255) NOT NULL,
    original_name character varying(255) NOT NULL,
    file_content bytea NOT NULL,
    file_size bigint NOT NULL,
    file_type character varying(100),
    file_ext character varying(20),
    md5 character varying(32),
    upload_by character varying(64),
    upload_time timestamp without time zone,
    deleted smallint DEFAULT 0,
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: sys_job
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS sys_job (
    id bigint NOT NULL,
    job_name character varying(64) NOT NULL,
    job_group character varying(64) DEFAULT 'DEFAULT'::character varying,
    invoke_target character varying(500) NOT NULL,
    cron_expression character varying(255),
    misfire_policy character varying(20),
    concurrent character(1) DEFAULT '1'::bpchar,
    status character(1) DEFAULT '0'::bpchar,
    remark character varying(500),
    create_by character varying(64),
    create_time timestamp without time zone,
    update_by character varying(64),
    update_time timestamp without time zone,
    deleted smallint DEFAULT 0,
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: sys_job_log
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS sys_job_log (
    id bigint NOT NULL DEFAULT nextval('sys_job_log_id_seq'::regclass),
    job_id bigint NOT NULL,
    job_name character varying(64) NOT NULL,
    job_group character varying(64) NOT NULL DEFAULT 'DEFAULT'::character varying,
    invoke_target character varying(500) NOT NULL,
    status character varying(1) DEFAULT '0'::character varying,
    exception_info text,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    create_time timestamp without time zone DEFAULT now(),
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: sys_login_log
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS sys_login_log (
    id bigint NOT NULL,
    user_id bigint,
    account_number character varying(64),
    login_ip character varying(128),
    login_location character varying(255),
    browser character varying(50),
    os character varying(50),
    login_status character(1),
    msg character varying(255),
    login_time timestamp without time zone,
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: sys_menu
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS sys_menu (
    id bigint NOT NULL,
    parent_id bigint DEFAULT 0,
    menu_name character varying(100) NOT NULL,
    menu_type character(1) NOT NULL,
    path character varying(200),
    component character varying(255),
    perms character varying(200),
    icon character varying(100),
    sort_order integer DEFAULT 0,
    status character(1) DEFAULT '0'::bpchar,
    visible character(1) DEFAULT '0'::bpchar,
    create_by character varying(64),
    create_time timestamp without time zone,
    update_by character varying(64),
    update_time timestamp without time zone,
    deleted smallint DEFAULT 0,
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: sys_notice
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS sys_notice (
    id bigint NOT NULL,
    notice_title character varying(200) NOT NULL,
    notice_type character(1) NOT NULL,
    notice_content text,
    status character(1) DEFAULT '0'::bpchar,
    create_by character varying(64),
    create_time timestamp without time zone,
    update_by character varying(64),
    update_time timestamp without time zone,
    deleted smallint DEFAULT 0,
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: t_log
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS t_log (
    id character varying(225) NOT NULL,
    realname character varying(60),
    client_ip character varying(20),
    create_time timestamp without time zone,
    account_number character varying(60),
    user_id character varying(255),
    log_type smallint,
    log_content text,
    is_error smallint,
    department_id character varying(60),
    PRIMARY KEY (id)
);

-- -------------------------------------------
-- 表: t_user
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS t_user (
    id character varying(255) NOT NULL,
    account_number character varying(32),
    nick_name character varying(255),
    real_name character varying(255),
    email character varying(255),
    department_id character varying(32),
    add_time timestamp without time zone,
    login_time timestamp without time zone,
    activate_status character varying(16),
    password character varying(256),
    unit_id character varying(32),
    phone_number character varying(255),
    duty character varying(255),
    salt character varying(255),
    password_level smallint,
    sfzhm character varying(60),
    create_by character varying(64),
    update_by character varying(64),
    update_time timestamp without time zone,
    deleted integer DEFAULT 0,
    remark character varying(500),
    PRIMARY KEY (id)
);

-- ============================================================
-- 索引
-- ============================================================

-- organization
CREATE UNIQUE INDEX idindex ON public.organization USING btree (id);

-- organization
CREATE INDEX org_nameindex ON public.organization USING btree (org_name, remark);

-- role
CREATE INDEX idx_role_deleted ON public.role USING btree (deleted);

-- role
CREATE INDEX idx_role_role_code ON public.role USING btree (role_code);

-- sys_config
CREATE UNIQUE INDEX sys_config_config_key_key ON public.sys_config USING btree (config_key);

-- sys_dict_data
CREATE INDEX idx_sys_dict_data_dict_type ON public.sys_dict_data USING btree (dict_type);

-- sys_dict_type
CREATE UNIQUE INDEX sys_dict_type_dict_type_key ON public.sys_dict_type USING btree (dict_type);

-- sys_file
CREATE INDEX idx_sys_file_md5 ON public.sys_file USING btree (md5);

-- sys_job_log
CREATE INDEX idx_sys_job_log_create_time ON public.sys_job_log USING btree (create_time);

-- sys_job_log
CREATE INDEX idx_sys_job_log_job_id ON public.sys_job_log USING btree (job_id);

-- sys_job_log
CREATE INDEX idx_sys_job_log_status ON public.sys_job_log USING btree (status);

-- sys_login_log
CREATE INDEX idx_sys_login_log_account_number ON public.sys_login_log USING btree (account_number);

-- sys_login_log
CREATE INDEX idx_sys_login_log_login_time ON public.sys_login_log USING btree (login_time);

-- sys_login_log
CREATE INDEX idx_sys_login_log_status ON public.sys_login_log USING btree (login_status);

-- sys_login_log
CREATE INDEX idx_sys_login_log_user_id ON public.sys_login_log USING btree (user_id);

-- sys_menu
CREATE INDEX idx_sys_menu_parent_id ON public.sys_menu USING btree (parent_id);

-- sys_menu
CREATE INDEX idx_sys_menu_perms ON public.sys_menu USING btree (perms);

-- sys_menu
CREATE INDEX idx_sys_menu_status ON public.sys_menu USING btree (status);

-- sys_notice
CREATE INDEX idx_sys_notice_create_time ON public.sys_notice USING btree (create_time);

-- sys_notice
CREATE INDEX idx_sys_notice_status ON public.sys_notice USING btree (status);

-- t_log
CREATE INDEX idx_t_log_account_number ON public.t_log USING btree (account_number);

-- t_log
CREATE INDEX idx_t_log_is_error ON public.t_log USING btree (is_error);

-- t_user
CREATE INDEX idx_t_user_activate_status ON public.t_user USING btree (activate_status);

-- t_user
CREATE INDEX idx_t_user_deleted ON public.t_user USING btree (deleted);

-- ============================================================
-- 字段注释
-- ============================================================

COMMENT ON COLUMN organization.id IS 'id';
COMMENT ON COLUMN organization.org_name IS '组织名称';
COMMENT ON COLUMN organization.org_address IS '组织地址';
COMMENT ON COLUMN organization.org_duty IS '统一社会信用代码';
COMMENT ON COLUMN organization.super_org IS '上级组织';
COMMENT ON COLUMN organization.create_time IS '创建时间';
COMMENT ON COLUMN organization.update_time IS '更新时间';
COMMENT ON COLUMN organization.remark IS '备注';
COMMENT ON COLUMN organization.grade IS '层级';
COMMENT ON COLUMN organization.city_code IS '地市代码';
COMMENT ON COLUMN organization.admin IS '是否是管理部门';
COMMENT ON COLUMN organization.is_warn IS '是否产生预警 0不产生 1产生';
COMMENT ON COLUMN organization.group_num IS '分组（0省级单位，1分局，2支队，3执法站，4大队，5其他）';
COMMENT ON COLUMN organization.admin_level IS '行政级别（0省，1市，2县，3乡镇）';
COMMENT ON COLUMN organization.org_type IS '部门类型，继承自父部门，0交警，1农业农村，2交通运输,3其他';
COMMENT ON COLUMN organization.ad_id IS '行政区划id';
COMMENT ON COLUMN organization.sortorder IS '排序字段';
COMMENT ON COLUMN organization.isfold IS '是否为文件夹';
COMMENT ON COLUMN organization.iske IS '1局部门，2 科室';
COMMENT ON COLUMN role.id IS '唯一标识';
COMMENT ON COLUMN role.role_name IS '角色名称';
COMMENT ON COLUMN role.create_time IS '创建时间';
COMMENT ON COLUMN role.remarks IS '备注';
COMMENT ON COLUMN role.role_type IS '角色分类';
COMMENT ON COLUMN role.role_code IS '角色编码';
COMMENT ON COLUMN role.role_system IS '所属系统';
COMMENT ON COLUMN role_user.id IS '唯一标识';
COMMENT ON COLUMN role_user.user_id IS '用户id';
COMMENT ON COLUMN role_user.role_id IS '角色id';
COMMENT ON COLUMN role_user.remark IS '备注';
COMMENT ON COLUMN sys_file.file_content IS '文件内容二进制';
COMMENT ON COLUMN sys_menu.parent_id IS '父菜单ID';
COMMENT ON COLUMN sys_menu.menu_name IS '菜单名称';
COMMENT ON COLUMN sys_menu.menu_type IS 'M目录 C菜单 F按钮';
COMMENT ON COLUMN sys_menu.path IS '路由地址';
COMMENT ON COLUMN sys_menu.component IS '组件路径';
COMMENT ON COLUMN sys_menu.perms IS '权限标识';
COMMENT ON COLUMN sys_menu.icon IS '菜单图标';
COMMENT ON COLUMN sys_menu.sort_order IS '排序';
COMMENT ON COLUMN sys_menu.status IS '0正常 1停用';
COMMENT ON COLUMN sys_menu.visible IS '0显示 1隐藏';
COMMENT ON COLUMN sys_menu.deleted IS '0未删除 1已删除';
COMMENT ON COLUMN t_log.id IS '唯一标识';
COMMENT ON COLUMN t_log.realname IS '用户真实姓名';
COMMENT ON COLUMN t_log.client_ip IS '登陆客户端ip';
COMMENT ON COLUMN t_log.create_time IS '创建时间';
COMMENT ON COLUMN t_log.account_number IS '登陆用户名';
COMMENT ON COLUMN t_log.user_id IS '用户id';
COMMENT ON COLUMN t_log.log_type IS '日志类型0登录 1查询 2插入 3删除 4修改 5登出';
COMMENT ON COLUMN t_log.log_content IS '日志内容';
COMMENT ON COLUMN t_log.is_error IS '是否为异常请求 0正常1 异常';
COMMENT ON COLUMN t_log.department_id IS '部门id';
COMMENT ON COLUMN t_user.id IS '唯一标识';
COMMENT ON COLUMN t_user.account_number IS '账号';
COMMENT ON COLUMN t_user.nick_name IS '用户昵称';
COMMENT ON COLUMN t_user.real_name IS '真实姓名';
COMMENT ON COLUMN t_user.email IS '邮箱';
COMMENT ON COLUMN t_user.department_id IS '部门';
COMMENT ON COLUMN t_user.add_time IS '添加时间';
COMMENT ON COLUMN t_user.login_time IS '最后登录时间';
COMMENT ON COLUMN t_user.activate_status IS '激活状态，0禁用，1正常';
COMMENT ON COLUMN t_user.password IS '密码';
COMMENT ON COLUMN t_user.unit_id IS '单位编号';
COMMENT ON COLUMN t_user.phone_number IS '手机号';
COMMENT ON COLUMN t_user.duty IS '职务';
COMMENT ON COLUMN t_user.salt IS '密码盐值';
COMMENT ON COLUMN t_user.password_level IS '密码级别';
COMMENT ON COLUMN t_user.sfzhm IS '身份证号码';
