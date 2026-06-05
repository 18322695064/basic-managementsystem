/*
 Navicat Premium Dump SQL

 Source Server         : 192.168.2.227
 Source Server Type    : PostgreSQL
 Source Server Version : 90615 (90615)
 Source Host           : 192.168.2.227:5432
 Source Catalog        : management_system
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 90615 (90615)
 File Encoding         : 65001

 Date: 05/06/2026 16:06:47
*/


-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS "public"."organization";
CREATE TABLE "public"."organization" (
  "id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "org_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "org_address" varchar(200) COLLATE "pg_catalog"."default",
  "org_duty" varchar(100) COLLATE "pg_catalog"."default",
  "super_org" varchar(32) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_time" timestamp(6),
  "remark" varchar(200) COLLATE "pg_catalog"."default",
  "grade" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "city_code" varchar COLLATE "pg_catalog"."default",
  "admin" int4,
  "is_warn" int4,
  "group_num" int4,
  "admin_level" int4,
  "org_type" int4,
  "ad_id" varchar(60) COLLATE "pg_catalog"."default",
  "sortorder" int4,
  "isfold" varchar(10) COLLATE "pg_catalog"."default",
  "iske" varchar(10) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."organization"."id" IS 'id';
COMMENT ON COLUMN "public"."organization"."org_name" IS '组织名称';
COMMENT ON COLUMN "public"."organization"."org_address" IS '组织地址';
COMMENT ON COLUMN "public"."organization"."org_duty" IS '统一社会信用代码';
COMMENT ON COLUMN "public"."organization"."super_org" IS '上级组织';
COMMENT ON COLUMN "public"."organization"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."organization"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."organization"."remark" IS '备注';
COMMENT ON COLUMN "public"."organization"."grade" IS '层级';
COMMENT ON COLUMN "public"."organization"."city_code" IS '地市代码';
COMMENT ON COLUMN "public"."organization"."admin" IS '是否是管理部门';
COMMENT ON COLUMN "public"."organization"."is_warn" IS '是否产生预警 0不产生 1产生';
COMMENT ON COLUMN "public"."organization"."group_num" IS '分组（0省级单位，1分局，2支队，3执法站，4大队，5其他）';
COMMENT ON COLUMN "public"."organization"."admin_level" IS '行政级别（0省，1市，2县，3乡镇）';
COMMENT ON COLUMN "public"."organization"."org_type" IS '部门类型，继承自父部门，0交警，1农业农村，2交通运输,3其他';
COMMENT ON COLUMN "public"."organization"."ad_id" IS '行政区划id';
COMMENT ON COLUMN "public"."organization"."sortorder" IS '排序字段';
COMMENT ON COLUMN "public"."organization"."isfold" IS '是否为文件夹';
COMMENT ON COLUMN "public"."organization"."iske" IS '1局部门，2 科室';

-- ----------------------------
-- Records of organization
-- ----------------------------
INSERT INTO "public"."organization" VALUES ('4fc7da548c4b4b61b22b90cbe1fabecd', '销售部', 'xxx', '', 'd8de3dbfe6604088a32f954e8573acdf', '2026-03-18 21:15:45', '2026-06-05 15:06:29.319846', '销售部门', '2', NULL, NULL, NULL, NULL, NULL, NULL, 'ea3b14aafe8940c1bac54d0f756530e9', 1000, NULL, NULL);
INSERT INTO "public"."organization" VALUES ('5381c2603459486289152e5f5e2f5278', '办公室中心', 'xxx', '', 'd8de3dbfe6604088a32f954e8573acdf', '2026-06-05 15:07:07.133321', '2026-06-05 15:07:07.133321', '', '2', '', NULL, NULL, NULL, NULL, NULL, 'f79b931083a6488584c46aa9f1f247a8', 9000, NULL, NULL);
INSERT INTO "public"."organization" VALUES ('d8b66b00f68d41619a035864bf744bd9', '开发部', '开发部', NULL, 'd8de3dbfe6604088a32f954e8573acdf', '2026-03-19 00:58:40', '2026-06-05 15:06:49.847658', '开发部', '2', NULL, NULL, NULL, NULL, NULL, NULL, 'f79b931083a6488584c46aa9f1f247a8', 9000, NULL, NULL);
INSERT INTO "public"."organization" VALUES ('d8de3dbfe6604088a32f954e8573acdf', 'xxx公司', '天津市和平区xxx路xxx号', NULL, NULL, '2026-03-18 21:15:45', '2026-06-04 23:39:10.801487', '', '1', NULL, NULL, NULL, NULL, NULL, NULL, 'ea3b14aafe8940c1bac54d0f756530e9', 1000, NULL, NULL);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS "public"."role";
CREATE TABLE "public"."role" (
  "id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL::character varying,
  "role_name" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL::character varying,
  "create_time" timestamp(6) DEFAULT NULL::timestamp without time zone,
  "remarks" text COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "role_type" varchar(60) COLLATE "pg_catalog"."default",
  "role_code" varchar(100) COLLATE "pg_catalog"."default",
  "role_system" varchar(100) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "deleted" int4 DEFAULT 0,
  "data_scope" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '1'::character varying
)
;
COMMENT ON COLUMN "public"."role"."id" IS '唯一标识';
COMMENT ON COLUMN "public"."role"."role_name" IS '角色名称';
COMMENT ON COLUMN "public"."role"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."role"."remarks" IS '备注';
COMMENT ON COLUMN "public"."role"."role_type" IS '角色分类';
COMMENT ON COLUMN "public"."role"."role_code" IS '角色编码';
COMMENT ON COLUMN "public"."role"."role_system" IS '所属系统';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO "public"."role" VALUES ('2ef419c805c44795b6d60f159986d61a', '普通用户', '2026-06-03 12:32:41.933249', '', '通用', 'putonguser', NULL, NULL, 0, '3');
INSERT INTO "public"."role" VALUES ('f73e5fda1a9b46b78fcdb57075ae5ff8', '管理系统超级管理员', '2026-04-13 16:28:44.06', '管理系统超级管理员', '通用类', 'super_admin', '管理系统', NULL, 0, '1');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."role_menu";
CREATE TABLE "public"."role_menu" (
  "id" int8 NOT NULL DEFAULT nextval('role_menu_id_seq'::regclass),
  "role_id" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "menu_id" int8 NOT NULL
)
;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO "public"."role_menu" VALUES (470, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 1);
INSERT INTO "public"."role_menu" VALUES (471, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 2);
INSERT INTO "public"."role_menu" VALUES (472, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 3);
INSERT INTO "public"."role_menu" VALUES (473, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 4);
INSERT INTO "public"."role_menu" VALUES (474, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 5);
INSERT INTO "public"."role_menu" VALUES (475, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 6);
INSERT INTO "public"."role_menu" VALUES (476, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 7);
INSERT INTO "public"."role_menu" VALUES (477, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 100);
INSERT INTO "public"."role_menu" VALUES (478, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 8);
INSERT INTO "public"."role_menu" VALUES (479, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 9);
INSERT INTO "public"."role_menu" VALUES (480, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 10);
INSERT INTO "public"."role_menu" VALUES (481, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 11);
INSERT INTO "public"."role_menu" VALUES (482, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 12);
INSERT INTO "public"."role_menu" VALUES (483, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 13);
INSERT INTO "public"."role_menu" VALUES (484, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 14);
INSERT INTO "public"."role_menu" VALUES (485, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 15);
INSERT INTO "public"."role_menu" VALUES (486, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 16);
INSERT INTO "public"."role_menu" VALUES (487, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 17);
INSERT INTO "public"."role_menu" VALUES (488, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 18);
INSERT INTO "public"."role_menu" VALUES (489, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 19);
INSERT INTO "public"."role_menu" VALUES (490, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 20);
INSERT INTO "public"."role_menu" VALUES (491, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 21);
INSERT INTO "public"."role_menu" VALUES (492, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 22);
INSERT INTO "public"."role_menu" VALUES (493, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 23);
INSERT INTO "public"."role_menu" VALUES (494, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 24);
INSERT INTO "public"."role_menu" VALUES (495, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 25);
INSERT INTO "public"."role_menu" VALUES (496, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 26);
INSERT INTO "public"."role_menu" VALUES (497, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 27);
INSERT INTO "public"."role_menu" VALUES (498, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 28);
INSERT INTO "public"."role_menu" VALUES (499, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 29);
INSERT INTO "public"."role_menu" VALUES (500, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 30);
INSERT INTO "public"."role_menu" VALUES (501, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 31);
INSERT INTO "public"."role_menu" VALUES (502, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 32);
INSERT INTO "public"."role_menu" VALUES (503, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 33);
INSERT INTO "public"."role_menu" VALUES (504, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 34);
INSERT INTO "public"."role_menu" VALUES (505, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 35);
INSERT INTO "public"."role_menu" VALUES (506, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 36);
INSERT INTO "public"."role_menu" VALUES (507, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 37);
INSERT INTO "public"."role_menu" VALUES (508, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 38);
INSERT INTO "public"."role_menu" VALUES (509, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 39);
INSERT INTO "public"."role_menu" VALUES (510, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 40);
INSERT INTO "public"."role_menu" VALUES (511, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 41);
INSERT INTO "public"."role_menu" VALUES (512, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 42);
INSERT INTO "public"."role_menu" VALUES (513, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 43);
INSERT INTO "public"."role_menu" VALUES (514, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 45);
INSERT INTO "public"."role_menu" VALUES (515, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 44);
INSERT INTO "public"."role_menu" VALUES (516, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 46);
INSERT INTO "public"."role_menu" VALUES (517, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 2000);
INSERT INTO "public"."role_menu" VALUES (518, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 2001);
INSERT INTO "public"."role_menu" VALUES (519, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 2002);
INSERT INTO "public"."role_menu" VALUES (520, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 2003);
INSERT INTO "public"."role_menu" VALUES (521, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 2004);
INSERT INTO "public"."role_menu" VALUES (522, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 2005);
INSERT INTO "public"."role_menu" VALUES (523, 'f73e5fda1a9b46b78fcdb57075ae5ff8', 2006);
INSERT INTO "public"."role_menu" VALUES (524, '2ef419c805c44795b6d60f159986d61a', 3);
INSERT INTO "public"."role_menu" VALUES (525, '2ef419c805c44795b6d60f159986d61a', 19);
INSERT INTO "public"."role_menu" VALUES (526, '2ef419c805c44795b6d60f159986d61a', 34);
INSERT INTO "public"."role_menu" VALUES (527, '2ef419c805c44795b6d60f159986d61a', 29);

-- ----------------------------
-- Table structure for role_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."role_user";
CREATE TABLE "public"."role_user" (
  "id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL::character varying,
  "user_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL::character varying,
  "role_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL::character varying,
  "remark" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
COMMENT ON COLUMN "public"."role_user"."id" IS '唯一标识';
COMMENT ON COLUMN "public"."role_user"."user_id" IS '用户id';
COMMENT ON COLUMN "public"."role_user"."role_id" IS '角色id';
COMMENT ON COLUMN "public"."role_user"."remark" IS '备注';

-- ----------------------------
-- Records of role_user
-- ----------------------------
INSERT INTO "public"."role_user" VALUES ('1', '7acc64c6e6e54eae9eb883adc5f887b5', 'f73e5fda1a9b46b78fcdb57075ae5ff8', NULL);
INSERT INTO "public"."role_user" VALUES ('f98056e9540f4f23a3d5089adade7710', '4e88cf6b95ad496192aff19ce943dafc', '2ef419c805c44795b6d60f159986d61a', NULL);
INSERT INTO "public"."role_user" VALUES ('04e17fd04c4e487f9569301763d39628', '7c077c41f8f14799bf893b109cfd1c3c', '2ef419c805c44795b6d60f159986d61a', NULL);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_config";
CREATE TABLE "public"."sys_config" (
  "id" int8 NOT NULL,
  "config_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "config_key" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "config_value" varchar(1000) COLLATE "pg_catalog"."default" NOT NULL,
  "config_type" char(1) COLLATE "pg_catalog"."default" DEFAULT 'N'::bpchar,
  "remark" varchar(500) COLLATE "pg_catalog"."default",
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "deleted" int2 DEFAULT 0
)
;
COMMENT ON TABLE "public"."sys_config" IS '系统配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO "public"."sys_config" VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_config" VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_config" VALUES (4, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_config" VALUES (5, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_config" VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', NULL, NULL, NULL, 'admin', '2026-06-05 15:12:22', 0);
INSERT INTO "public"."sys_config" VALUES (2062794863713820674, 'tst1', 'sys:methods', 'hhh', 'Y', '', 'admin', '2026-06-05 15:13:15.044746', 'admin', '2026-06-05 15:12:22', 0);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dict_data";
CREATE TABLE "public"."sys_dict_data" (
  "id" int8 NOT NULL,
  "dict_type" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "dict_label" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "dict_value" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "dict_sort" int4 DEFAULT 0,
  "css_class" varchar(100) COLLATE "pg_catalog"."default",
  "list_class" varchar(100) COLLATE "pg_catalog"."default",
  "is_default" char(1) COLLATE "pg_catalog"."default" DEFAULT 'N'::bpchar,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "deleted" int2 DEFAULT 0,
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON TABLE "public"."sys_dict_data" IS '字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO "public"."sys_dict_data" VALUES (2061785490598199298, 'sys_user_sex', '男', '0', 1, '', 'default', 'Y', '0', 'admin', '2026-06-02 20:22:21.751343', 'admin', '2026-06-02 20:22:21.751343', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785490795331586, 'sys_user_sex', '女', '1', 2, '', 'default', 'N', '0', 'admin', '2026-06-02 20:22:21.793408', 'admin', '2026-06-02 20:22:21.793408', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785490862440449, 'sys_user_sex', '未知', '2', 3, '', 'default', 'N', '0', 'admin', '2026-06-02 20:22:21.813392', 'admin', '2026-06-02 20:22:21.813392', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785491059572738, 'sys_show_hide', '显示', '0', 1, '', 'primary', 'Y', '0', 'admin', '2026-06-02 20:22:21.855082', 'admin', '2026-06-02 20:22:21.855082', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785491189596161, 'sys_show_hide', '隐藏', '1', 2, '', 'danger', 'N', '0', 'admin', '2026-06-02 20:22:21.880884', 'admin', '2026-06-02 20:22:21.880884', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785491256705026, 'sys_normal_disable', '正常', '0', 1, '', 'primary', 'Y', '0', 'admin', '2026-06-02 20:22:21.901583', 'admin', '2026-06-02 20:22:21.901583', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785491382534146, 'sys_normal_disable', '停用', '1', 2, '', 'danger', 'N', '0', 'admin', '2026-06-02 20:22:21.933425', 'admin', '2026-06-02 20:22:21.933425', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785491453837314, 'sys_yes_no', '是', 'Y', 1, '', 'primary', 'Y', '0', 'admin', '2026-06-02 20:22:21.952904', 'admin', '2026-06-02 20:22:21.952904', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785491650969602, 'sys_yes_no', '否', 'N', 2, '', 'danger', 'N', '0', 'admin', '2026-06-02 20:22:21.999546', 'admin', '2026-06-02 20:22:21.999546', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785491848101889, 'sys_notice_type', '通知', '1', 1, '', 'primary', 'Y', '0', 'admin', '2026-06-02 20:22:22.044636', 'admin', '2026-06-02 20:22:22.044636', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785491911016450, 'sys_notice_type', '公告', '2', 2, '', 'success', 'N', '0', 'admin', '2026-06-02 20:22:22.063844', 'admin', '2026-06-02 20:22:22.063844', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785492041039874, 'sys_notice_status', '正常', '0', 1, '', 'primary', 'Y', '0', 'admin', '2026-06-02 20:22:22.084156', 'admin', '2026-06-02 20:22:22.084156', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785492108148738, 'sys_notice_status', '关闭', '1', 2, '', 'danger', 'N', '0', 'admin', '2026-06-02 20:22:22.107985', 'admin', '2026-06-02 20:22:22.107985', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785492238172161, 'sys_common_status', '成功', '0', 1, '', 'primary', 'Y', '0', 'admin', '2026-06-02 20:22:22.136505', 'admin', '2026-06-02 20:22:22.136505', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2061785492368195585, 'sys_common_status', '失败', '1', 2, '', 'danger', 'N', '0', 'admin', '2026-06-02 20:22:22.166748', 'admin', '2026-06-02 20:22:22.166748', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2062076874567823361, 'sfefsef', 'efewfe', 'fefe', 0, NULL, NULL, 'N', '0', 'admin', '2026-06-03 15:40:13.093569', 'admin', '2026-06-03 15:40:13.093569', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2062076894511738882, 'sfefsef', 'fesfs', 'fsfe', 0, NULL, NULL, 'N', '0', 'admin', '2026-06-03 15:40:17.857152', 'admin', '2026-06-03 15:40:17.857152', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2062794067760750594, 'sys_test', 'value2', '2', 1, NULL, NULL, 'N', '0', 'admin', '2026-06-05 15:10:05.283582', 'admin', '2026-06-05 15:10:05.283582', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2062794031656181761, 'sys_test', 'value1', '1', 0, NULL, NULL, 'N', '0', 'admin', '2026-06-05 15:09:56', 'admin', '2026-06-05 15:09:56', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2062794249009209346, 'sys_test2', 'test1', '1', 0, NULL, NULL, 'N', '0', 'admin', '2026-06-05 15:09:56', 'admin', '2026-06-05 15:09:56', 0, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (2062794272128212994, 'sys_test2', 'test2', '2', 0, NULL, NULL, 'N', '0', 'admin', '2026-06-05 15:09:56', 'admin', '2026-06-05 15:09:56', 0, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dict_type";
CREATE TABLE "public"."sys_dict_type" (
  "id" int8 NOT NULL,
  "dict_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "dict_type" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "remark" varchar(500) COLLATE "pg_catalog"."default",
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "deleted" int2 DEFAULT 0
)
;
COMMENT ON TABLE "public"."sys_dict_type" IS '字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO "public"."sys_dict_type" VALUES (2061785489180524546, '用户性别', 'sys_user_sex', '0', '用户性别列表', 'admin', '2026-06-02 20:22:21.399625', 'admin', '2026-06-02 20:22:21.399625', 0);
INSERT INTO "public"."sys_dict_type" VALUES (2061785489235050498, '菜单状态', 'sys_show_hide', '0', '菜单状态列表', 'admin', '2026-06-02 20:22:21.416274', 'admin', '2026-06-02 20:22:21.416274', 0);
INSERT INTO "public"."sys_dict_type" VALUES (2061785489365073921, '系统开关', 'sys_normal_disable', '0', '系统开关列表', 'admin', '2026-06-02 20:22:21.449501', 'admin', '2026-06-02 20:22:21.449501', 0);
INSERT INTO "public"."sys_dict_type" VALUES (2061785489553817602, '任务状态', 'sys_job_status', '0', '任务状态列表', 'admin', '2026-06-02 20:22:21.496391', 'admin', '2026-06-02 20:22:21.496391', 0);
INSERT INTO "public"."sys_dict_type" VALUES (2061785489683841025, '系统是否', 'sys_yes_no', '0', '系统是否列表', 'admin', '2026-06-02 20:22:21.528128', 'admin', '2026-06-02 20:22:21.528128', 0);
INSERT INTO "public"."sys_dict_type" VALUES (2061785489746755585, '通知类型', 'sys_notice_type', '0', '通知类型列表', 'admin', '2026-06-02 20:22:21.549284', 'admin', '2026-06-02 20:22:21.549284', 0);
INSERT INTO "public"."sys_dict_type" VALUES (2061785489948082178, '通知状态', 'sys_notice_status', '0', '通知状态列表', 'admin', '2026-06-02 20:22:21.591009', 'admin', '2026-06-02 20:22:21.592022', 0);
INSERT INTO "public"."sys_dict_type" VALUES (2061785490015191041, '操作类型', 'sys_oper_type', '0', '操作类型列表', 'admin', '2026-06-02 20:22:21.609512', 'admin', '2026-06-02 20:22:21.609512', 0);
INSERT INTO "public"."sys_dict_type" VALUES (2061785490212323330, '系统状态', 'sys_common_status', '0', '系统状态列表', 'admin', '2026-06-02 20:22:21.652119', 'admin', '2026-06-02 20:22:21.652119', 0);
INSERT INTO "public"."sys_dict_type" VALUES (2062793848469954562, 'tet1', 'sys_test', '0', '', 'admin', '2026-06-05 15:09:12.995402', 'admin', '2026-06-05 15:09:12.998384', 0);
INSERT INTO "public"."sys_dict_type" VALUES (2062793900059893762, 'test2', 'sys_test2', '0', 'test2', 'admin', '2026-06-05 15:09:25', 'admin', '2026-06-05 15:09:25', 0);

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_file";
CREATE TABLE "public"."sys_file" (
  "id" int8 NOT NULL,
  "file_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "original_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "file_content" bytea NOT NULL,
  "file_size" int8 NOT NULL,
  "file_type" varchar(100) COLLATE "pg_catalog"."default",
  "file_ext" varchar(20) COLLATE "pg_catalog"."default",
  "md5" varchar(32) COLLATE "pg_catalog"."default",
  "upload_by" varchar(64) COLLATE "pg_catalog"."default",
  "upload_time" timestamp(6),
  "deleted" int2 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."sys_file"."file_content" IS '文件内容二进制';
COMMENT ON TABLE "public"."sys_file" IS '文件存储表';

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO "public"."sys_file" VALUES (2062798295338164226, '4b67f5b0-e7e6-40e3-947d-619eb6e878a3.png', '一体化.png', E'\\211PNG\\015\\012\\032\\012\\000\\000\\000\\015IHDR\\000\\000\\000H\\000\\000\\000H\\010\\006\\000\\000\\000U\\355\\263G\\000\\000\\020\\000IDATx\\001\\354[\\013|T\\325\\231\\377\\276;!!\\005)\\025,TE\\223\\231\\021T|Af\\202\\340\\223ZK-\\253\\354\\252\\270>\\352V]Jf@Ze\\361\\321\\256\\332\\270u\\267em\\027_d&\\374\\320\\365A\\353\\003\\355\\372\\354V\\327-\\276\\212$3\\011R+\\202\\231;a\\0251\\350\\242V#$\\231\\334\\373\\365\\177\\356d\\206y\\335\\231;!\\361\\361\\373ys\\316=\\347|\\337w\\276s\\356\\177\\316=\\347;\\337\\271\\321\\350\\313\\253(\\002_\\002T\\024\\036\\242/\\001\\372\\274\\001t\\360\\225oU{\\002\\233\\216\\362.j;\\263\\266\\241\\365{\\336\\305\\257L-\\321\\307\\317\\224=\\374#\\250Q4o\\260\\365\\024w0\\372+O0\\322Z\\265\\247\\353/D}\\257\\212)?eM\\373 \\266\\362\\270\\327>S\\004J4>l\\000y\\027F=\\236`\\364fOWt\\207\\010?\\307"KI\\310\\217\\376t1\\313\\305z\\270\\316\\037\\017\\371\\236B9/\\324\\\\\\262qlm\\260\\355\\030o\\240eNm\\260e>\\300\\275\\320\\023\\210\\234\\217t\\256\\267\\241e\\346\\244\\313\\332\\017$\\022\\316\\2538\\014\\204!\\007\\010\\300L\\307\\303<&\\232\\274A"\\313\\320\\347\\011\\210*$\\204\\371\\347\\275\\325\\023\\247\\304B\\365k\\210Xh\\340\\362\\004\\333\\352P\\347jOC\\344IO \\272\\3355\\322x_\\023s\\223\\220\\366{M\\264\\207\\000\\356\\257!z?\\322''\\205\\265\\365\\225\\225\\306\\333\\000\\353c\\324y\\311\\333\\020Y\\201\\374\\334\\011\\3136\\215\\202\\314\\220\\207!\\003\\010\\300`\\304D\\036\\021\\226(zy\\026b\\206nn3Y\\363a\\304\\374d\\373\\212I{\\300\\243\\232\\300\\3135x\\300\\345\\356@\\264\\223\\304Tu\\226\\023\\323\\\\\\214\\214\\203\\020K\\216\\016\\300\\253\\0009A\\230\\256P\\300\\215\\356\\356{\\317\\035\\210\\254\\365\\006#g\\021^k\\032\\242+\\343!\\006\\247\\321\\273\\244\\243\\312\\335\\020\\275\\001#\\346U\\022:\\033\\017\\231\\371p&\\264\\376\\373X\\223fv\\206\\352\\376\\204<Y@\\006\\242\\017\\272\\250\\242\\003\\345\\253\\231\\244\\006\\351P\\204j&:W\\204\\036s\\357\\214\\3060\\022\\177\\250\\372\\266\\257\\212\\367\\011 \\265\\032I\\342\\303(\\346\\224\\033\\321\\221j\\304t\\020\\242\\017Hd\\256\\036\\366_\\323\\266\\312\\227P\\235\\305\\353\\360\\013\\321\\010\\223\\262\\234\\007\\301\\012\\304a\\011\\030]\\265Dr+\\372\\326\\341\\015\\264_\\274/\\215\\014\\032 \\214\\232E$\\275\\0214~\\024bN\\340\\327Y\\323\\352\\365\\346\\372\\337+\\206\\232p\\321\\331(^\\207k\\320\\361*E\\373\\224\\342$!\\343^\\274\\312\\353\\016\\013F\\334\\203i\\263|\\200\\032\\245\\002\\015\\2061jV\\022\\363\\310\\334F\\001BK\\317n\\343$\\275\\251.\\246x\\236@\\333\\337\\261i\\256G\\276\\000\\220\\240\\346\\005\\026f\\372\\204\\210?@\\354\\306H4h\\337\\257SM\\241\\215\\356E\\221\\013\\312UU\\026@S.{i?OWT\\215\\212\\206\\302\\015\\361s\\237tW\\236\\366\\366\\2753v)\\276;\\030\\015\\020\\231\\017\\343\\201\\325\\204\\252H\\331\\221\\351\\015\\314\\031w\\212p\\320d\\355d\\3567&\\351\\273\\352F\\304B\\376\\321z\\330\\267?\\342~\\361]\\235U\\206&\\337`6f\\262\\320\\002!n"\\342?\\223\\340\\217\\312\\272\\306\\260I\\277Q\\2579\\221`\\272rV\\3271@\\336%\\033\\306\\364WU)pN+\\244\\032 \\264|\\244U\\237\\271\\363\\276c\\361\\353\\023y\\202\\321\\357\\343\\201VB6\\243\\015V=k\\025\\242\\245\\006U\\324\\352!\\377\\224x\\263\\177A\\274\\331\\027\\356\\014\\325\\275\\030[}\\374vZ\\313\\331#f\\355y\\306\\266\\246\\372\\256X\\350\\370\\015\\261f\\377\\235\\361\\260o1\\200;\\272b\\204\\353`f\\355rb~\\211\\210\\205\\034^\\350\\3005\\336`\\333\\032\\232/.''U2:o/\\256F\\016\\365W<MB\\263\\250\\240\\030w\\364\\364%\\276\\373^\\323\\324n\\305v7\\264\\373 \\333\\214_*\\245_-\\355\\315b\\322\\261\\261\\260\\177F<\\354_\\261-<m\\233\\222\\035l\\334z\\307\\364\\035\\261P\\335J=\\344;\\211E;J\\254\\221E\\252\\235\\222*E\\344B\\317\\270\\3665\\344\\300\\034H=\\200\\275R \\335_Y\\365 \\224\\036_P\\210\\371C\\303\\244\\263\\266\\3379\\353}\\213\\177\\352\\272\\012f\\023\\206\\240\\250\\311x\\017~\\341_\\232U#k\\365\\260?\\020_\\345{\\325\\222\\031\\342[\\254y\\372\\3468F\\026^E7\\336\\235\\025D\\334K%/\\363|\\367\\316\\266\\233K\\211\\225\\004\\310=\\256\\3556(9\\003\\261`\\200\\245\\273`\\333*\\337\\226\\024\\3233e\\364\\205X\\336''\\213\\320\\032\\322d\\012~\\341\\253:o=zg\\212?\\234\\251\\365*\\206\\375K1\\327\\250\\015\\360c\\245\\332\\202\\201\\271\\324\\033\\210\\0245\\003\\212\\002d\\315#$\\213\\354\\032\\302\\257uWGx\\372#Y|\\326&\\263\\346\\232\\035o\\366_\\2547\\325\\277\\225\\305\\373\\224\\012\\261U>\\035#\\366o\\231\\031\\366\\026\\277[\\254Y!\\272\\243\\230\\011`\\013\\220UID\\215\\236\\202\\372\\241\\270\\3134yi.S\\017\\327]\\027\\013M\\177>\\227\\376Y\\224c!\\337\\332\\276\\276\\236i\\370!_(\\322\\376\\030\\021\\016\\333\\361m\\000\\022\\214R\\272\\017\\225\\306 \\026\\014\\232\\310U\\230S\\340\\272(\\310\\376\\334\\020\\337\\272\\353\\304\\035\\261]\\276ob.\\264\\005\\001\\026\\303\\351\\336@\\033F[~\\267\\013\\002\\344\\016F.!\\333\\025K)\\341\\366X\\263\\332\\221\\253\\374\\027 \\302t\\300\\\\\\030\\004H\\327\\333\\365V\\310\\374Wj\\\\\\227\\267\\375\\311\\003h\\312e[\\366c\\341\\177\\263S\\244\\350\\254q\\243J\\277h\\021 \\335D$7\\330\\364\\333\\353}g\\364\\367syy\\000\\031U\\335\\312\\20731W0]fz-\\326T\\367D\\272\\374\\005\\313\\350\\341\\372\\237\\211\\2202`\\363z\\016#\\362\\237\\000 g2\\262\\000:pa\\364+\\260w\\026g\\012\\344\\345\\205l\\337\\345<\\331\\317)!\\276\\265\\373\\012\\000\\361\\207\\002\\335;\\302\\033h\\375v&=\\013\\240\\257T\\320%D4\\016\\321.\\364\\210\\311j\\362\\266\\343\\177\\352t\\345_\\302\\376j^\\315\\342\\350\\014\\307\\215?7\\273\\277\\337\\324\\276\\007\\371\\377G\\314\\012\\360X^\\232I\\310\\002HL*:z0\\004\\377g_W\\256C\\027F\\277\\221\\331\\201\\301\\344\\017]\\320R\\353ih\\375\\2317\\020}\\035\\216\\272\\030\\372\\365\\250\\313\\020\\345\\357v\\254\\356\\377V\\371\\336\\201!{y^\\005\\241\\263\\324\\2763EO\\003\\224<~\\221#S\\214\\302\\251\\374Wazi\\352\\001\\213^\\033\\355\\011Do\\251t\\321\\354\\322\\322\\205%&\\007\\326\\037\\244\\\\-\\025\\025\\256-\\304|\\235\\220\\034nI"cP\\305\\223V\\276\\214\\033\\014\\331\\007!\\376\\277\\210\\231\\241\\232\\022\\332wR\\2044@\\246\\221\\230\\237"\\332\\246\\206\\226\\253\\314V4\\223\\341Y\\324\\346\\035c\\356\\331\\210\\367\\376\\264\\216\\011u\\017d\\362\\234\\346=\\201\\366\\363\\015\\031\\361g\\310\\303\\325"\\225H\\367\\006\\246\\007\\007\\273\\371\\305\\376m\\031L\\032\\331\\253\\014\\275$\\376\\233T9\\015\\020\\023+G{\\212\\236\\227b\\030w\\342\\365z3\\217Q\\202p\\320\\342\\226q\\330\\233\\3757\\232\\3652\\323?S#+?59\\276\\260Y\\3664D\\340\\0310\\356''\\246\\261\\224wq\\314e\\362\\222<\\262C\\002\\366o\\257@4w\\337v*hV\\260\\000:\\346bud"G[\\024\\233\\033\\023\\265\\332\\260\\212\\220\\205\\253\\015\\355~\\000\\344\\205\\320\\037c!\\377\\343H\\313\\010\\302\\236q\\321\\373\\000\\314B\\233J\\317\\3571i\\346\\033\\253|y\\223\\255\\215|A\\262I\\002\\017@\\026kR\\355\\342\\366C\\025\\305\\002h\\367\\350^\\037\\012yV$h{\\2030\\234\\355{\\213Nr\\236`\\3732\\214\\335\\323\\225\\254\\311\\346\\217UZN\\204c\\353Z\\310\\347\\273I\\231\\336\\020\\346\\213\\364\\260o\\366\\216}\\004\\007\\372\\251\\263\\271\\376\\005\\274fY\\317\\247\\231\\3464\\305\\263\\000\\022\\326J\\256\\000B\\332fU\\301i\\364,j\\205\\303\\\\~\\232\\224\\347\\337u\\206f\\274\\230\\314;\\273\\253\\011\\0316Y\\246\\325\\233\\300C\\374\\226M\\236\\003\\213\\370\\360x\\310\\367\\033*\\303\\223H%.\\326\\010\\3722\\204D\\224\\313\\204\\222\\000\\211\\224<\\233r\\271\\314\\355\\031\\325KgM\\355\\227\\360\\267\\214\\302C\\0111g>h\\351\\272\\2200\\270\\362l$8\\024\\340n\\314]\\3131\\231\\036\\2427\\373\\317\\201+\\343\\031\\032B`h\\3402\\315\\212\\265\\003\\331\\201D,L,\\200\\260\\367\\302Y\\367\\000\\335&1\\022\\364\\216\\015+\\217\\354^\\030=\\021\\304\\371\\210D\\032?\\246\\207\\352\\332\\254|97\\221j\\210?oh\\346a\\230\\273\\256\\305d\\3325a\\331\\246Q\\312(t\\007\\332\\376\\003\\033\\352\\307=\\201\\350\\313X\\366_\\302\\211\\3523\\236@\\333\\3558\\212\\012\\324\\0046Z\\017\\206\\272e\\205x\\3634u\\220\\031OW\\022\\315\\262\\327,\\2000\\211\\036\\220f\\330dz\\210\\034O\\204\\232&\\312\\224g\\245\\3120\\350\\027*-7\\366&\\022\\253\\365-\\335\\337R\\300x\\227l:\\330\\023h\\275u\\324\\307};\\205\\351Q&\\363J\\026:\\223H\\224\\033\\370\\0044\\204y\\316\\274\\234YB.\\352\\217C6b\\035\\030\\316\\177\\310\\221c\\236\\322\\027\\247\\267\\037h\\307r\\365$\\001J\\336\\323b\\2052;\\016\\254\\003F\\2058\\3314\\357\\202\\015\\007\\013\\321\\274\\001\\352\\363p\\307\\266\\014\\344\\313J,\\0377\\266\\004\\360j.\\221D\\037\\346?\\376!^\\265Q\\016\\224\\000/\\366\\211:0\\034W\\373\\032\\016\\020\\012\\236\\302\\024\\322\\003\\375{\\373\\312d\\331Z\\232\\022\\304\\257a\\252\\324>r\\0375r\\011\\031\\262.sD\\305e\\310X+"\\334n\\253\\220\\037T\\250\\271\\244s\\244''\\020Q&\\202\\362j\\3567(%DS\\230\\315g\\000\\362\\315\\204\\303\\204R:\\204xcJ\\006\\016A\\313\\361o\\001$D\\326YV\\212\\231\\233\\302\\222/c\\250\\312w\\007\\352\\367\\214\\350M<1\\220/+9r\\376k\\225\\256\\221\\273\\036E\\245\\363\\021\\3671\\210\\206)d\\231\\347\\210\\321\\017*\\275\\305\\224\\365\\216\\374\\372f\\302\\303*\\031`\\362\\241J-\\200\\360.\\277\\255\\012v\\021c\\326\\245>>\\260\\343\\247\\3505Wl\\034\\213\\316(\\233J\\221\\326m\\275\\353\\304\\217U\\246\\334\\330;~\\367j\\364iN\\271\\365\\212\\312\\013\\235\\335;n\\367C\\324\\3308\\360\\314\\371\\322\\333WL\\332#L]I\\016w\\252\\324\\022f\\342\\242\\000Y\\202\\275\\177)9\\314+\\022\\375\\247@Wj\\264\\015\\352\\014\\314\\035l\\273\\024\\277b\\321\\243\\030\\325\\237A\\306y\\356\\256\\271\\327\\027\\253\\013@\\006Nb\\3302\\034QV\\342\\245\\215\\300\\004\\033\\007)\\311b\\3214\\370\\210\\024\\037Ctk*\\3574\\205\\303n<F\\340\\257\\234\\312\\017R\\356zo\\260\\365\\024\\273\\272\\350\\367G\\212\\307\\246X+\\232\\005\\020&2\\365\\205\\227\\242\\333F\\326\\\\\\007\\3332\\007\\030L\\264\\367\\023\\023\\346\\262\\017\\013\\2535\\272\\216I\\2766\\240nX\\022\\364\\321\\205\\343\\252[\\310\\356\\330Y\\250[\\204^\\201A\\252\\253\\016X\\000u\\204\\374\\312@\\332\\245\\010v\\221\\205\\222\\276\\027;\\001E\\027\\331\\013\\220\\211f\\024\\315a\\204q\\371U"\\371GK|\\230oX\\316\\217\\363tE\\376\\241`3L\\0373\\313\\255)\\236\\005\\220*0\\361\\323*\\265\\217r\\254=/\\311\\021\\215G''s\\270k\\350\\006\\022\\307\\301E\\027@vo}\\024\\20670\\034\\364\\005Z\\320\\350Y}\\242\\377\\336\\024''\\015\\020~\\360\\022\\0369N\\255N\\251\\272y)\\213i\\331?\\212\\301\\206Yr\\316Rr\\251\\310"E\\375Q)\\271!L\\217:\\254\\200\\037[o\\0028\\215{m\\276\\275\\000\\365V\\300\\251E\\305\\254\\345\\303\\223\\337''\\333wQ\\204S+\\030\\221\\306\\036{\\311\\034N\\243h\\302|r\\016\\265P1\\201\\327Py\\005\\356\\300\\006\\370&\\274\\366\\267\\240\\3742\\0041\\267\\342^f0\\015\\232[\\252J\\032\\240mwO\\373\\220\\211\\263?D\\310\\252-\\\\9\\322\\370V\\026)\\247\\200\\227jw\\006\\311\\341''wD\\356w^\\361`\\004\\331o#\\222\\306[s_\\205\\253\\006\\347Z''\\353a\\377\\022\\270<\\256\\2175\\373\\257Dy\\026\\263k6L\\203\\262\\027\\0058\\005N\\316\\350o\\301l\\032 \\305e\\321\\212n\\015D\\350\\\\%g\\027\\231(\\275\\343\\207\\354)N\\214K\\245\\213\\271o\\222J\\013E\\014\\015\\203Y\\273\\030\\240\\004\\336\\272c\\372\\216B2\\352c\\011\\255\\302u\\236\\222-\\304\\267\\245\\011\\2258\\244 \\312\\002\\250\\243y\\272\\372\\012b\\243\\235B6i\\316!\\301?}\\315\\216/\\244\\245\\001\\302h\\032E\\306.[{#K\\007\\273\\254\\235s\\026-U\\020\\371\\227X\\270\\356\\327\\251\\242]\\332\\261r\\372\\013\\314\\274\\306\\216oC?\\240\\324\\366#\\013 \\245\\204\\231\\032\\311\\356b\\252\\254\\224^u\\270XX\\202\\351\\315L\\006\\346l{\\331\\014A1\\245/\\243\\230\\231\\215\\217|\\177\\224cw\\211i\\232weVv\\222\\357\\036o\\330\\277\\332P\\240!f\\0058\\247\\224c\\335\\326p\\3040\\276\\2340\\251fU\\032(\\010\\2319\\243O\\316U\\256\\327\\001\\266mbVpa\\033\\214)\\274y\\355T;\\360\\362\\364un\\375d=\\210{\\020\\035\\207~\\243\\257\\267\\230p\\036@\\226\\260&?"\\302\\013E\\005/\\267\\247+Z\\360[\\232\\276\\276\\257\\264\\243\\0060\\304=\\031F\\260\\251\\225t\\326Wh_}\\235r\\332\\203\\022\\303L\\030i{\\204\\234\\\\\\360\\037ALGt\\032z\\340\\364\\337]L\\270 @8q\\\\O,\\330Q\\333Te\\272\\261\\320g\\264\\333\\357\\234\\252>\\344\\264v\\301\\251\\232&I\\203wq\\373\\314T\\271P\\032\\273\\3750\\265\\377\\331\\222\\305c\\212v\\256>\\276\\374\\225\\211\\250\\034\\017\\302\\033Ym\\026(\\024\\004H\\311%\\250\\347Z\\022*\\354\\250\\027\\232\\354\\035\\337\\036PryQ\\350\\331L\\032\\023N\\300\\015s\\365\\0018z\\316\\244\\347\\347\\315,\\023C\\243R\\226}\\276\\206$\\205\\261eI\\346J\\337%gJ\\310\\257\\241\\345\\223\\222\\2247C''} .V\\346\\177\\177\\222\\222}\\027\\323\\274\\251v\\301\\253\\251\\377\\005K3\\361j\\344\\236R\\202''G\\342\\350\\371aZ\\030\\035\\201B\\341\\240\\271\\324\\353\\224nK\\230\\236\\2432\\257\\201\\025\\311\\261\\201*\\254=S\\252\\011[\\200T\\305x\\223\\357%\\021\\276N\\345\\363"\\323XmDOS.=\\376~\\247\\332\\323\\025\\030y2\\307\\243\\311\\275\\003\\017\\221[\\215\\364\\246\\272\\030\\023)\\220\\024\\257\\267\\267\\252o\\203\\312\\224\\023\\023\\373\\357\\206Ya}\\237\\355\\244\\332\\036\\263\\312\\365\\273R\\202E\\001R\\225\\343\\315\\276\\345X\\372\\377S\\345\\363"\\274t\\265\\213"\\331;\\360\\265\\347\\251\\177%\\270=O6I8\\277w\\334\\236g''/\\214\\216O\\026\\263\\357B\\225?&\\222\\315\\240\\276\\274}\\305\\254rV#T!B\\303?\\2602Nn\\314k\\267\\3352\\315r\\253\\026\\023/\\011\\220\\252\\034{\\275{\\241\\020\\027\\334\\314\\262A\\267Nnh9V\\311\\245\\342\\036\\223\\357\\220\\014\\253:EO\\246r\\222\\241I\\013\\334\\033y\\337\\002\\350\\341c\\337\\375H\\0335\\003#\\351\\306\\244\\254\\363;N/|\\370!\\317qR\\003}3\\260\\272.w"\\353\\010 \\302\\362\\331W=A-\\355jC\\233\\245\\027\\235\\032\\325\\317\\256G3G\\205Z:\\341\\355\\200\\251\\220%\\232Yp\\343\\2507\\342\\016Fo\\310}\\345\\324\\377{\\304\\302\\376\\262\\346\\037\\365\\301\\023\\263y\\017\\032p\\366<D\\367\\250\\177_\\200|\\311\\340T!)\\207\\266n\\362<h\\274\\0371+0I\\215\\241\\321\\023\\023\\254\\257D\\222\\254X\\310\\267\\026\\271<Y\\320\\006\\202Ta\\203zc\\357\\376\\273\\333=\\013\\243\\263\\007\\210e''\\352\\037m$\\341\\302\\302 %\\367U\\003\\312\\273\\372\\022\\211\\253\\006\\362%\\023\\307\\000Y\\232V\\371\\022z\\330w\\2210\\377\\234(\\327\\220\\224\\343G\\217J<\\2229"\\272?\\251\\374\\2010\\275B\\305.\\246\\2510\\004\\376\\340\\015F7\\340X\\371\\\\\\262\\261\\322\\013\\251\\250\\015n8\\246\\277\\262j=x\\247":\\011\\375\\244\\361\\205\\326\\241\\244\\023i\\310\\224\\007\\020*\\020\\261\\304C\\276\\237\\210I\\312\\301\\225\\263E\\2209\\275\\343v?Z\\203C?\\302\\245\\376w\\214\\245r\\016\\336\\371l#\\020\\274\\334 "3\\000\\346H\\200\\211\\333\\000\\000\\002rIDATZwWD\\367\\004"\\313\\261E\\231eg\\026\\270\\033Z|\\336@\\344NM\\\\\\352\\314\\377\\250\\\\]6e4\\301K\\364&\\337:\\033~A\\362 \\000J\\352\\211\\257\\362=\\205_~\\032Jj\\357\\206$\\035\\316\\300\\241\\337S\\336\\2136X;t5\\3612\\365a\\371eG\\3136\\023\\327@\\323\\325d\\362\\037\\335,\\037\\000\\254\\365\\236`\\344\\001w\\240u\\015\\346\\254\\247Q\\356b\\326"\\000=}\\202\\013\\371\\022\\001g\\024\\302WbE.\\373\\023\\346A\\003\\244z\\204-\\311[z\\330?\\217\\3315\\217\\2103\\376AN\\276)\\373U\\274\\350]\\260\\311:\\011\\321\\303''\\274k\\364\\214\\233\\215\\271*D\\004\\373\\0347''A-\\000\\220\\233\\211\\032\\177\\317\\304\\027a\\316\\3726\\312y\\306)h\\266A\\204>\\021\\222\\363\\000N\\332\\021o+\\\\\\200\\261O\\000\\245\\364\\301a\\365x\\325\\304\\352)x\\373\\032@S''$H\\344\\030\\251\\350k\\361,\\3328\\013\\005\\332vwmO,\\\\\\277\\210\\311<\\203\\210\\2619\\245\\341\\277\\230\\326\\263K;.\\036\\366gmc\\312ixH\\000R\\015nn\\234\\332\\247\\207\\352W\\351[\\272\\247\\020\\271. &\\365\\377\\255_''\\323X\\347i\\210.Q2*\\306\\3023\\236\\326\\267||\\014\\253\\3777%zO\\321\\206!\\35203.\\202[\\366De\\241\\357\\213\\376!\\003(\\335\\011\\330Lzx\\372\\003z\\310\\177\\206\\241\\211r\\245^%\\232\\234\\356\\011F\\357\\361.iO~\\207\\004\\231X\\250n\\245\\321\\323}\\0101+\\247Z$]\\177\\220\\031\\353U\\022\\372-\\274\\232g\\352\\023}\\223;\\206\\350\\023\\275\\241\\007(\\343\\001\\325\\307Oz\\330w[<\\344?K\\237Pw\\251K(k\\263\\272\\355\\356\\331=z\\310w\\217\\036\\366\\327k\\232v$\\023-%k\\027\\317N\\376\\017MmEp\\242\\301\\267\\231822{\\307\\217\\2177\\373\\317\\211\\207\\353\\236\\244\\306\\\\\\023\\204\\006}\\015+@Y\\275B\\247\\267\\3328\\335\\225\\\\GS\\335\\353\\260\\240W\\350a\\337w\\020\\307\\232\\375#''\\232\\254\\235\\214\\325\\352\\\\\\214\\216\\013\\325H3\\205\\346\\213\\306''\\221\\246\\035\\206Wy\\214\\036\\366\\317\\322\\303\\276\\037u6\\327?\\241\\3468\\245g\\250\\343\\247\\007P\\231=\\357\\\\}\\364\\316\\316P\\335\\213\\361\\260\\377\\221x\\263\\377~5\\322:\\233\\375\\017\\307\\341a\\320\\261\\363''\\274\\246e\\252\\034\\224\\370\\347\\026\\240A=M9\\225\\034\\312~\\011P\\011\\240\\376\\012\\000\\000\\377\\377h\\303\\213\\231\\000\\000\\000\\006IDAT\\003\\0008\\255\\255\\353~,\\214G\\000\\000\\000\\000IEND\\256B`\\202', 4809, 'image/png', '.png', '0461e76e0f1d8543b7a0e5b437bfdf02', NULL, '2026-06-05 15:26:53.219198', 0);
INSERT INTO "public"."sys_file" VALUES (2062798678794018817, '8adf3790-d305-4988-b43e-3d82611560f0.txt', '密码重置sql.txt', E'update t_user set password = ''$2a$10$/7risgVoVkOgM3Ih.Z.4d.sX/xA/QHQBmCokvmK9LQRpVCSXfuB62''', 91, 'text/plain', '.txt', '7a93a7681b4a52e7e5d1cea99e96cefd', NULL, '2026-06-05 15:28:24.629559', 0);

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_login_log";
CREATE TABLE "public"."sys_login_log" (
  "id" int8 NOT NULL,
  "user_id" int8,
  "account_number" varchar(64) COLLATE "pg_catalog"."default",
  "login_ip" varchar(128) COLLATE "pg_catalog"."default",
  "login_location" varchar(255) COLLATE "pg_catalog"."default",
  "browser" varchar(50) COLLATE "pg_catalog"."default",
  "os" varchar(50) COLLATE "pg_catalog"."default",
  "login_status" char(1) COLLATE "pg_catalog"."default",
  "msg" varchar(255) COLLATE "pg_catalog"."default",
  "login_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."sys_login_log" IS '登录日志表';

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------
INSERT INTO "public"."sys_login_log" VALUES (2061655245853347841, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 11:44:48.961454');
INSERT INTO "public"."sys_login_log" VALUES (2061657055590662146, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '用户名或密码错误', '2026-06-02 11:52:00.437229');
INSERT INTO "public"."sys_login_log" VALUES (2061657130026975233, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 11:52:18.200365');
INSERT INTO "public"."sys_login_log" VALUES (2061657510240632834, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 11:53:48.851017');
INSERT INTO "public"."sys_login_log" VALUES (2061665995661557762, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 12:27:31.933928');
INSERT INTO "public"."sys_login_log" VALUES (2061667935443271681, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '用户名或密码错误', '2026-06-02 12:35:14.413481');
INSERT INTO "public"."sys_login_log" VALUES (2061668008176697346, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 12:35:31.757363');
INSERT INTO "public"."sys_login_log" VALUES (2061674622405361666, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 13:01:48.693294');
INSERT INTO "public"."sys_login_log" VALUES (2061682561488842754, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 13:33:21.517387');
INSERT INTO "public"."sys_login_log" VALUES (2061684428495187969, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 13:40:46.660689');
INSERT INTO "public"."sys_login_log" VALUES (2061727771681947650, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 16:33:00.461768');
INSERT INTO "public"."sys_login_log" VALUES (2061744929463926786, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 17:41:11.211919');
INSERT INTO "public"."sys_login_log" VALUES (2061750088600453122, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:01:41.247043');
INSERT INTO "public"."sys_login_log" VALUES (2061750108267544577, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:01:45.934493');
INSERT INTO "public"."sys_login_log" VALUES (2061750124516278273, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:01:49.815708');
INSERT INTO "public"."sys_login_log" VALUES (2061750140551102466, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:01:53.627752');
INSERT INTO "public"."sys_login_log" VALUES (2061750164055982082, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:01:59.238635');
INSERT INTO "public"."sys_login_log" VALUES (2061750180392796161, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:02:03.139773');
INSERT INTO "public"."sys_login_log" VALUES (2061750196389871617, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:02:06.955316');
INSERT INTO "public"."sys_login_log" VALUES (2061750227926843394, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:02:14.473271');
INSERT INTO "public"."sys_login_log" VALUES (2061750244049747970, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:02:18.31873');
INSERT INTO "public"."sys_login_log" VALUES (2061750260222984193, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:02:22.166097');
INSERT INTO "public"."sys_login_log" VALUES (2061750291848036353, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:02:29.704742');
INSERT INTO "public"."sys_login_log" VALUES (2061750307920609282, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:02:33.546019');
INSERT INTO "public"."sys_login_log" VALUES (2061750323976404993, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:02:37.367326');
INSERT INTO "public"."sys_login_log" VALUES (2061755321011470337, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:22:28.748585');
INSERT INTO "public"."sys_login_log" VALUES (2061757938320080897, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:32:52.769099');
INSERT INTO "public"."sys_login_log" VALUES (2061757962990977026, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:32:58.654121');
INSERT INTO "public"."sys_login_log" VALUES (2061761686622765057, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:47:46.431203');
INSERT INTO "public"."sys_login_log" VALUES (2061761749969338369, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:48:01.530968');
INSERT INTO "public"."sys_login_log" VALUES (2061763059196166145, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:53:13.680127');
INSERT INTO "public"."sys_login_log" VALUES (2061763084294881282, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:53:19.658988');
INSERT INTO "public"."sys_login_log" VALUES (2061764638804606977, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 18:59:30.285745');
INSERT INTO "public"."sys_login_log" VALUES (2061764877468893185, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:00:27.193573');
INSERT INTO "public"."sys_login_log" VALUES (2061765326255226882, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:02:14.191999');
INSERT INTO "public"."sys_login_log" VALUES (2061765571517153282, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:03:12.661223');
INSERT INTO "public"."sys_login_log" VALUES (2061769057440956418, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:17:03.780923');
INSERT INTO "public"."sys_login_log" VALUES (2061769199523004418, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:17:37.643257');
INSERT INTO "public"."sys_login_log" VALUES (2061769345019215873, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:18:12.340078');
INSERT INTO "public"."sys_login_log" VALUES (2061769627669168130, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:19:19.729364');
INSERT INTO "public"."sys_login_log" VALUES (2061769823962595330, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:20:06.527281');
INSERT INTO "public"."sys_login_log" VALUES (2061772466021793794, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:30:36.448274');
INSERT INTO "public"."sys_login_log" VALUES (2061772712177106945, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:31:35.122935');
INSERT INTO "public"."sys_login_log" VALUES (2061773096660566018, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:33:06.80053');
INSERT INTO "public"."sys_login_log" VALUES (2061773121818001409, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:33:12.804379');
INSERT INTO "public"."sys_login_log" VALUES (2061774409188311041, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:38:19.726349');
INSERT INTO "public"."sys_login_log" VALUES (2061774979831758850, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:40:35.778887');
INSERT INTO "public"."sys_login_log" VALUES (2061775005119217665, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:40:41.810766');
INSERT INTO "public"."sys_login_log" VALUES (2061776199275315201, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:45:26.520264');
INSERT INTO "public"."sys_login_log" VALUES (2061776600993169409, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:47:02.303219');
INSERT INTO "public"."sys_login_log" VALUES (2061776627853492225, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 19:47:08.694506');
INSERT INTO "public"."sys_login_log" VALUES (2061785488857563138, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 20:22:21.334659');
INSERT INTO "public"."sys_login_log" VALUES (2061786206465228801, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 20:25:12.426062');
INSERT INTO "public"."sys_login_log" VALUES (2061786232050483202, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 20:25:18.522948');
INSERT INTO "public"."sys_login_log" VALUES (2061787572973666306, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 20:30:38.222576');
INSERT INTO "public"."sys_login_log" VALUES (2061787847969013762, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 20:31:43.78896');
INSERT INTO "public"."sys_login_log" VALUES (2061787874237939713, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 20:31:50.047238');
INSERT INTO "public"."sys_login_log" VALUES (2061798260983005186, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-02 21:13:06.437971');
INSERT INTO "public"."sys_login_log" VALUES (2061996762442854401, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '用户已失效', '2026-06-03 10:21:52.86404');
INSERT INTO "public"."sys_login_log" VALUES (2061997782413680641, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '用户已失效', '2026-06-03 10:25:56.038359');
INSERT INTO "public"."sys_login_log" VALUES (2061999401649909761, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 10:32:22.097749');
INSERT INTO "public"."sys_login_log" VALUES (2062004839619522561, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 10:53:58.608282');
INSERT INTO "public"."sys_login_log" VALUES (2062006567957983234, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 11:00:50.696668');
INSERT INTO "public"."sys_login_log" VALUES (2062007380700868610, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 11:04:04.457379');
INSERT INTO "public"."sys_login_log" VALUES (2062009405165625345, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 11:12:07.125668');
INSERT INTO "public"."sys_login_log" VALUES (2062028862323720194, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 12:29:26.07201');
INSERT INTO "public"."sys_login_log" VALUES (2062030741090975746, 0, 'wangbin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 12:36:54.007351');
INSERT INTO "public"."sys_login_log" VALUES (2062031669726658561, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 12:40:35.416636');
INSERT INTO "public"."sys_login_log" VALUES (2062031885209026561, 0, 'wangbin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 12:41:26.801622');
INSERT INTO "public"."sys_login_log" VALUES (2062034047263686657, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 12:50:02.274453');
INSERT INTO "public"."sys_login_log" VALUES (2062034102284566529, 0, 'wangbin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 12:50:15.391902');
INSERT INTO "public"."sys_login_log" VALUES (2062038856460988418, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 13:09:08.856224');
INSERT INTO "public"."sys_login_log" VALUES (2062038911154712577, 0, 'wangbin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 13:09:21.917418');
INSERT INTO "public"."sys_login_log" VALUES (2062040341672423426, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 13:15:02.9698');
INSERT INTO "public"."sys_login_log" VALUES (2062042359166222337, 0, 'wangbin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 13:23:03.97054');
INSERT INTO "public"."sys_login_log" VALUES (2062044244870705153, 0, 'wangbin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 13:30:33.555883');
INSERT INTO "public"."sys_login_log" VALUES (2062046490597568513, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 13:39:28.980462');
INSERT INTO "public"."sys_login_log" VALUES (2062048434921713666, 0, 'wangbin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 13:47:12.550011');
INSERT INTO "public"."sys_login_log" VALUES (2062055743387418626, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 14:16:15.011946');
INSERT INTO "public"."sys_login_log" VALUES (2062058191023808514, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 14:25:58.578992');
INSERT INTO "public"."sys_login_log" VALUES (2062070088574021634, 0, 'wangbin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 15:13:15.178191');
INSERT INTO "public"."sys_login_log" VALUES (2062076712315367425, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 15:39:34.410451');
INSERT INTO "public"."sys_login_log" VALUES (2062098975311872001, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 17:08:02.312047');
INSERT INTO "public"."sys_login_log" VALUES (2062113135693217793, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', 'Bad credentials', '2026-06-03 18:04:18.419386');
INSERT INTO "public"."sys_login_log" VALUES (2062114751913738241, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:10:43.76093');
INSERT INTO "public"."sys_login_log" VALUES (2062114793105997826, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:10:53.583375');
INSERT INTO "public"."sys_login_log" VALUES (2062114819588833281, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:10:59.889336');
INSERT INTO "public"."sys_login_log" VALUES (2062114863188623362, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:11:10.28408');
INSERT INTO "public"."sys_login_log" VALUES (2062114881731641346, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:11:14.703916');
INSERT INTO "public"."sys_login_log" VALUES (2062114897841963009, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:11:18.54799');
INSERT INTO "public"."sys_login_log" VALUES (2062114913499299842, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:11:22.289438');
INSERT INTO "public"."sys_login_log" VALUES (2062114930385567746, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:11:26.30638');
INSERT INTO "public"."sys_login_log" VALUES (2062114944541343746, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:11:29.674524');
INSERT INTO "public"."sys_login_log" VALUES (2062115097633439745, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:12:06.186928');
INSERT INTO "public"."sys_login_log" VALUES (2062115139052191746, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:12:16.059595');
INSERT INTO "public"."sys_login_log" VALUES (2062115181590822913, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:12:26.205811');
INSERT INTO "public"."sys_login_log" VALUES (2062115223227678722, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:12:36.136061');
INSERT INTO "public"."sys_login_log" VALUES (2062115398696386562, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:13:17.95516');
INSERT INTO "public"."sys_login_log" VALUES (2062115408456531969, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:13:20.29051');
INSERT INTO "public"."sys_login_log" VALUES (2062115444561100802, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:13:28.898613');
INSERT INTO "public"."sys_login_log" VALUES (2062115469949222914, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:13:34.950397');
INSERT INTO "public"."sys_login_log" VALUES (2062115494506872834, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:13:40.809479');
INSERT INTO "public"."sys_login_log" VALUES (2062115519634948097, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:13:46.803115');
INSERT INTO "public"."sys_login_log" VALUES (2062115547346714626, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:13:53.412155');
INSERT INTO "public"."sys_login_log" VALUES (2062115569870127105, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-03 18:13:58.778518');
INSERT INTO "public"."sys_login_log" VALUES (2062212654057472001, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-04 00:39:45.45074');
INSERT INTO "public"."sys_login_log" VALUES (2062221014400032769, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-04 01:12:58.697355');
INSERT INTO "public"."sys_login_log" VALUES (2062343139878297602, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-04 09:18:15.677652');
INSERT INTO "public"."sys_login_log" VALUES (2062443107255377921, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-04 15:55:29.767966');
INSERT INTO "public"."sys_login_log" VALUES (2062444135140876290, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-04 15:59:34.837857');
INSERT INTO "public"."sys_login_log" VALUES (2062444267366309889, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-04 16:00:06.369893');
INSERT INTO "public"."sys_login_log" VALUES (2062453706781696001, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-04 16:37:36.886561');
INSERT INTO "public"."sys_login_log" VALUES (2062461733349974017, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-04 17:09:30.561105');
INSERT INTO "public"."sys_login_log" VALUES (2062478028162301953, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-04 18:14:15.552976');
INSERT INTO "public"."sys_login_log" VALUES (2062548202869563393, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-04 22:53:06.501085');
INSERT INTO "public"."sys_login_log" VALUES (2062564424562581505, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-04 23:57:34.06672');
INSERT INTO "public"."sys_login_log" VALUES (2062565482433159169, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-05 00:01:46.295102');
INSERT INTO "public"."sys_login_log" VALUES (2062790153619480577, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-05 14:54:32.052555');
INSERT INTO "public"."sys_login_log" VALUES (2062802101257977858, 0, 'wangbin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-05 15:42:00.599271');
INSERT INTO "public"."sys_login_log" VALUES (2062802381181632514, 0, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-05 15:43:07.353046');
INSERT INTO "public"."sys_login_log" VALUES (2062804653731037185, 0, 'wangbin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-05 15:52:09.138864');
INSERT INTO "public"."sys_login_log" VALUES (2062806699867717633, 0, 'zhangsan', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '登录成功', '2026-06-05 16:00:17.003556');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_menu";
CREATE TABLE "public"."sys_menu" (
  "id" int8 NOT NULL,
  "parent_id" int8 DEFAULT 0,
  "menu_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "menu_type" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "path" varchar(200) COLLATE "pg_catalog"."default",
  "component" varchar(255) COLLATE "pg_catalog"."default",
  "perms" varchar(200) COLLATE "pg_catalog"."default",
  "icon" varchar(100) COLLATE "pg_catalog"."default",
  "sort_order" int4 DEFAULT 0,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "visible" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "deleted" int2 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."sys_menu"."parent_id" IS '父菜单ID';
COMMENT ON COLUMN "public"."sys_menu"."menu_name" IS '菜单名称';
COMMENT ON COLUMN "public"."sys_menu"."menu_type" IS 'M目录 C菜单 F按钮';
COMMENT ON COLUMN "public"."sys_menu"."path" IS '路由地址';
COMMENT ON COLUMN "public"."sys_menu"."component" IS '组件路径';
COMMENT ON COLUMN "public"."sys_menu"."perms" IS '权限标识';
COMMENT ON COLUMN "public"."sys_menu"."icon" IS '菜单图标';
COMMENT ON COLUMN "public"."sys_menu"."sort_order" IS '排序';
COMMENT ON COLUMN "public"."sys_menu"."status" IS '0正常 1停用';
COMMENT ON COLUMN "public"."sys_menu"."visible" IS '0显示 1隐藏';
COMMENT ON COLUMN "public"."sys_menu"."deleted" IS '0未删除 1已删除';
COMMENT ON TABLE "public"."sys_menu" IS '菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO "public"."sys_menu" VALUES (1, 0, '系统管理', 'M', '/system', '', '', 'SettingOutlined', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (2, 1, '用户管理', 'C', 'user', 'system/user/index', 'system:user:list', 'UserOutlined', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (3, 2, '用户查询', 'F', '', '', 'system:user:query', '', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (4, 2, '用户新增', 'F', '', '', 'system:user:add', '', 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (5, 2, '用户修改', 'F', '', '', 'system:user:edit', '', 3, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (6, 2, '用户删除', 'F', '', '', 'system:user:remove', '', 4, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (7, 2, '用户导出', 'F', '', '', 'system:user:export', '', 5, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (8, 1, '角色管理', 'C', 'role', 'system/role/index', 'system:role:list', 'TeamOutlined', 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (9, 8, '角色查询', 'F', '', '', 'system:role:query', '', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (10, 8, '角色新增', 'F', '', '', 'system:role:add', '', 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (11, 8, '角色修改', 'F', '', '', 'system:role:edit', '', 3, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (12, 8, '角色删除', 'F', '', '', 'system:role:remove', '', 4, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (13, 1, '菜单管理', 'C', 'menu', 'system/menu/index', 'system:menu:list', 'MenuOutlined', 3, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (14, 13, '菜单查询', 'F', '', '', 'system:menu:query', '', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (15, 13, '菜单新增', 'F', '', '', 'system:menu:add', '', 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (16, 13, '菜单修改', 'F', '', '', 'system:menu:edit', '', 3, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (17, 13, '菜单删除', 'F', '', '', 'system:menu:remove', '', 4, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (18, 1, '组织管理', 'C', 'dept', 'system/dept/index', 'system:dept:list', 'ApartmentOutlined', 4, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (19, 18, '组织查询', 'F', '', '', 'system:dept:query', '', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (20, 18, '组织新增', 'F', '', '', 'system:dept:add', '', 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (21, 18, '组织修改', 'F', '', '', 'system:dept:edit', '', 3, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (22, 18, '组织删除', 'F', '', '', 'system:dept:remove', '', 4, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (23, 1, '字典管理', 'C', 'dict', 'system/dict/index', 'system:dict:list', 'BookOutlined', 5, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (24, 23, '字典查询', 'F', '', '', 'system:dict:query', '', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (25, 23, '字典新增', 'F', '', '', 'system:dict:add', '', 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (26, 23, '字典修改', 'F', '', '', 'system:dict:edit', '', 3, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (27, 23, '字典删除', 'F', '', '', 'system:dict:remove', '', 4, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (28, 1, '参数设置', 'C', 'config', 'system/config/index', 'system:config:list', 'ToolOutlined', 6, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (29, 28, '参数查询', 'F', '', '', 'system:config:query', '', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (30, 28, '参数新增', 'F', '', '', 'system:config:add', '', 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (31, 28, '参数修改', 'F', '', '', 'system:config:edit', '', 3, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (32, 28, '参数删除', 'F', '', '', 'system:config:remove', '', 4, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (33, 1, '通知公告', 'C', 'notice', 'system/notice/index', 'system:notice:list', 'NotificationOutlined', 7, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (34, 33, '公告查询', 'F', '', '', 'system:notice:query', '', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (35, 33, '公告新增', 'F', '', '', 'system:notice:add', '', 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (36, 33, '公告修改', 'F', '', '', 'system:notice:edit', '', 3, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (37, 33, '公告删除', 'F', '', '', 'system:notice:remove', '', 4, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (38, 1, '文件管理', 'C', 'file', 'tool/file/index', 'system:file:list', 'FileOutlined', 8, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (39, 38, '文件上传', 'F', '', '', 'system:file:upload', '', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (40, 38, '文件下载', 'F', '', '', 'system:file:download', '', 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (41, 38, '文件删除', 'F', '', '', 'system:file:remove', '', 3, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (42, 0, '系统监控', 'M', '/monitor', '', '', 'MonitorOutlined', 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (43, 42, '操作日志', 'C', 'operlog', 'monitor/operlog/index', 'system:log:oper:list', 'FileTextOutlined', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (44, 42, '登录日志', 'C', 'loginlog', 'monitor/loginlog/index', 'system:log:login:list', 'LoginOutlined', 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (45, 43, '操作日志删除', 'F', '', '', 'system:log:oper:remove', '', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (46, 44, '登录日志删除', 'F', '', '', 'system:log:login:remove', '', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (2000, 0, '开发工具', 'M', 'tool', NULL, NULL, 'AppstoreOutlined', 3, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (2001, 2000, '代码生成器', 'C', 'gen', 'tool/gen/index', 'tool:gen:list', 'CodeOutlined', 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (2002, 2001, '查询详情', 'F', NULL, NULL, 'tool:gen:query', NULL, 1, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (2003, 2001, '预览代码', 'F', NULL, NULL, 'tool:gen:preview', NULL, 2, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (2004, 2001, '生成代码', 'F', NULL, NULL, 'tool:gen:generate', NULL, 3, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (2005, 2001, '新增表', 'F', NULL, NULL, 'tool:gen:add', NULL, 4, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (2006, 2001, '修改表', 'F', NULL, NULL, 'tool:gen:edit', NULL, 5, '0', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO "public"."sys_menu" VALUES (2012, 2008, '应用详情', 'F', NULL, NULL, 'tool:application:query', NULL, 0, '0', '0', NULL, NULL, 'admin', '2026-06-04 23:45:08.32121', 1);
INSERT INTO "public"."sys_menu" VALUES (2010, 2008, '应用修改', 'F', NULL, NULL, 'tool:application:edit', NULL, 0, '0', '0', NULL, NULL, 'admin', '2026-06-04 23:45:11.446634', 1);
INSERT INTO "public"."sys_menu" VALUES (2011, 2008, '应用删除', 'F', NULL, NULL, 'tool:application:remove', NULL, 0, '0', '0', NULL, NULL, 'admin', '2026-06-04 23:45:14.281359', 1);
INSERT INTO "public"."sys_menu" VALUES (2009, 2008, '应用新增', 'F', NULL, NULL, 'tool:application:add', NULL, 0, '0', '0', NULL, NULL, 'admin', '2026-06-04 23:45:18.449204', 1);
INSERT INTO "public"."sys_menu" VALUES (2008, 2007, '应用查询', 'C', 'application', 'application/index', 'tool:application:list', 'SearchOutlined', 0, '0', '0', NULL, NULL, 'admin', '2026-06-04 23:45:22.694589', 1);
INSERT INTO "public"."sys_menu" VALUES (100, 2, '用户导入', 'F', '', '', 'system:user:import', '', 6, '0', '0', NULL, NULL, 'admin', '2026-06-05 00:01:14.753542', 0);

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_notice";
CREATE TABLE "public"."sys_notice" (
  "id" int8 NOT NULL,
  "notice_title" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "notice_type" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "notice_content" text COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "deleted" int2 DEFAULT 0
)
;
COMMENT ON TABLE "public"."sys_notice" IS '通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO "public"."sys_notice" VALUES (2061764206598356993, '测试公告E2E', '1', '测试内容E2E', '0', 'admin', '2026-06-02 18:57:47.24689', 'admin', '2026-06-02 18:57:47.24689', 0);
INSERT INTO "public"."sys_notice" VALUES (2061773995571216385, '测试公告E2E', '1', '测试内容E2E', '0', 'admin', '2026-06-02 19:36:41.113686', 'admin', '2026-06-02 19:36:41.113686', 0);
INSERT INTO "public"."sys_notice" VALUES (2061775818206019585, '测试公告E2E', '1', '测试内容E2E', '0', 'admin', '2026-06-02 19:43:55.66333', 'admin', '2026-06-02 19:43:55.66333', 0);
INSERT INTO "public"."sys_notice" VALUES (2061777460586414081, '测试公告E2E', '1', '测试内容E2E', '0', 'admin', '2026-06-02 19:50:27.246232', 'admin', '2026-06-02 19:50:27.247852', 0);
INSERT INTO "public"."sys_notice" VALUES (2061787175802437634, '测试公告E2E', '1', '测试内容E2E', '0', 'admin', '2026-06-02 20:29:03.521409', 'admin', '2026-06-02 20:29:03.521409', 0);
INSERT INTO "public"."sys_notice" VALUES (2061682667051085825, '风飞沙', '1', '色分色分色分', '0', 'admin', '2026-06-02 13:33:46.701126', 'admin', '2026-06-05 15:13:28.763946', 1);
INSERT INTO "public"."sys_notice" VALUES (2061788782950678530, '测试公告E2E', '1', '测试内容E2E凄凄切切', '0', 'admin', '2026-06-02 20:35:26', 'admin', '2026-06-02 20:35:26', 0);

-- ----------------------------
-- Table structure for t_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_log";
CREATE TABLE "public"."t_log" (
  "id" varchar(225) COLLATE "pg_catalog"."default" NOT NULL,
  "realname" varchar(60) COLLATE "pg_catalog"."default",
  "client_ip" varchar(20) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "account_number" varchar(60) COLLATE "pg_catalog"."default",
  "user_id" varchar(255) COLLATE "pg_catalog"."default",
  "log_type" int2,
  "log_content" text COLLATE "pg_catalog"."default",
  "is_error" int2,
  "department_id" varchar(60) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."t_log"."id" IS '唯一标识';
COMMENT ON COLUMN "public"."t_log"."realname" IS '用户真实姓名';
COMMENT ON COLUMN "public"."t_log"."client_ip" IS '登陆客户端ip';
COMMENT ON COLUMN "public"."t_log"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_log"."account_number" IS '登陆用户名';
COMMENT ON COLUMN "public"."t_log"."user_id" IS '用户id';
COMMENT ON COLUMN "public"."t_log"."log_type" IS '日志类型0登录 1查询 2插入 3删除 4修改 5登出';
COMMENT ON COLUMN "public"."t_log"."log_content" IS '日志内容';
COMMENT ON COLUMN "public"."t_log"."is_error" IS '是否为异常请求 0正常1 异常';
COMMENT ON COLUMN "public"."t_log"."department_id" IS '部门id';

-- ----------------------------
-- Records of t_log
-- ----------------------------
INSERT INTO "public"."t_log" VALUES ('c8f67d77da654f418095a63b524c1b2e', 'anonymousUser', '0:0:0:0:0:0:0:1', '2026-06-03 10:21:28.18992', 'anonymousUser', NULL, 4, '[认证管理] 获取用户信息 失败: Cannot invoke "com.management.entity.SysUser.getId()" because "user" is null', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('eb9a6692b3cb41f6acb2266b132cc973', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 10:32:22.286219', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9f0ef99d673d45fab7bb650382729167', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 10:53:58.782526', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1b8d20a77d1d48039f1547bd073fb00e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 10:53:58.923173', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1441440af57c4466b29160a07420cf9a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 10:53:59.404503', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f2b51c5d45c2410990fb5f6e807d59d3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 10:53:59.48573', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b465df27dffa40c79b5a7ba949598d55', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 10:55:11.986077', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0d925c2eb1b54ef29ec1a15167ed68e0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 10:55:12.126604', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bb0003f6e6cd40f1a8ac7fddc69ee443', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 10:55:12.480101', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('439ab5e0d0874573bcdf143a6d4cd53c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 10:55:12.561939', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ab1bcab5e1c54251a794b939cb085d00', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:00:38.797176', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5c803664334e4447a953a6c8e7368b66', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:00:38.938781', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6d6def3b92f54e06a4f846ac1650a494', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:00:39.197897', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7fd1e6f7b8134ea8aea2fe9679c8fba9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:00:39.253035', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dab43e00c45c447caa7d49cd7709ac94', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:00:50.799694', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2bff1ccbdad44c0c872c257f2873c58d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:00:51.009745', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dc9ac8c1a3e745cc9a6a00890166981c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:00:51.071408', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('25ba605ccdf6435d9b4a52f0efb3ed47', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:02:52.668614', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c1bf5de2dd9b434b8a0190db70fb5301', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:02:52.738665', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('66578c3c2af54f8f9094f7305923ef58', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:02:53.839832', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('02577737af5b426c91e1db9f7fd26685', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:02:53.889991', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b89a0b7bf0604b9983d77db9fda798dc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:03:08.320342', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b42da777d8fa4298b06ce702db118c7e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:03:08.404809', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1c45fa99b58a41279692b9fd89d476f0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:03:08.722009', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a85943e9c0fc4af3a8414b3fa9a9dc64', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:03:08.769879', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('63e8d1fdccc54a21b08bbcb45e034757', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:03:44.21361', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5f691950517d45b184997b5ef5d099ec', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:03:44.45943', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('564f2cd3de414cd58c3806ae839fa82b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:03:44.857408', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2736da2c383645228308873f7cfaaa78', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:03:44.943816', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f7f691fec7a049b8933b28d4cd3a1e26', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:04.508647', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8d6bd352a2794628b68ab0a8f4074085', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:04.652051', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5ae74f2eac8f48c2b1bff868b9ac2886', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:04.710873', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ad266acfa40a42f6980eb86e44b8e0f0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:06.690152', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b3cb1c71badc442c981bfc039433f1ff', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:11.282101', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cfc337954dda41c4b93920c2cd108974', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:11.330757', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1883ee1264234d7cab6b50088d5e7f4a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:12.79902', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('00bc458e142f4a4ab9fff4187252bd9f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:14.991771', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9413521f7b5945399513fb70ecab597e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:15.0409', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4b2a7f638dfe477790921398240e4b3a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:16.190501', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('922776e7a72c473f80a3d044205580c0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:37.354381', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('791cbd67a5814d5385f327a53d3e1b19', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:37.435486', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('302012d7c59a462b8679a6ccb4c2751a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:46.236241', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a36d045dd3cf4cac965ae38311bb6b5e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:46.315909', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9807a014a15d48378d915589d7bfaa88', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:53.917703', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ecae3f0c093d466382632cfc7dcf9ea6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:56.252707', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c265f7d5cafa40e1b09fc952c48ef05b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:04:56.296308', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0f432cb9e79641cea9c25f330858416e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:06:09.987362', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a5efb9061dba4e27a8529c429c6cb395', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:06:10.045663', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6fa7cfc4ede64bcf90522fae0518ac33', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:06:15.016388', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('399116398f104ce9aaf04bf8d9d996bc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:06:15.101516', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9ccf86b4cd804109b7f36b17c7cbe39b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:07:24.541552', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ea82b9f0592c4050a6e1458ffd91f807', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:07:24.556239', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ee3be35fe1a840469f61e13824c006b0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:07:24.632237', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ca90e2beeb8245108fcab97f704b822d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:07:53.596785', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b732f60ed8b8470d8b59dc609d9ce13c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:08:15.150921', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('141f111652ab4b1ca13dd54dcab81256', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:08:15.258464', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('47c4adcf800c4183aa554f8dabac2e3a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:07:53.510526', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f07f39a5f4f6465cbae766b6823be922', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:07:53.633272', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('10493024bac84fd0b8648a39de0fb578', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:08:15.241345', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('df3964a541634a4296df83c4e76d92ea', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:10:45.170459', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a224aad9d5a5408aaf8bc9f18c9decdc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:10:45.280346', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b71b79c725df4cff8b3ed4918401e2e5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:10:45.404555', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b8b63415b1d54e8383d86762c97b68a7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:10:46.832034', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6765ce10140247fa8be4ed4451cedd5d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:10:46.91633', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('49bcbc9cdc5646e6a3a7072757b384ea', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:10:46.933463', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f0df2142b80341c79aeab22ce89606c1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:11:55.028625', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('098d7260304d494c87fcd3ee5fe496f5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:11:55.068693', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e7229cf79a304f7883ff6eb4b32b5f8e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:11:55.094717', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('34708e3c2d244cdabf7d9fa48ffd137d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:12:07.268333', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b46833a12c414000baaeb4eb7d68ec6a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:12:07.403978', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f2c547e44b314dbda3097413906aa4a4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:12:07.406483', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('71b60f769ad848fe87610d042c7d0fb4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:12:13.564506', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8085808c44b24dfe89d3e1e3dc184006', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:12:14.5322', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fcc78e0a7b364a8bb5b4ba6486971fd6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:12:14.537317', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6648fd58eeef4d25866a7af69f97fa54', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:12:23.117576', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('54e8a758a3814df0bb006cf248c9b4c4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:12:23.790018', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fea8053a7d5944c9bd0275cc56d0261b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:12:23.942412', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f49786a56d8f42bcbc51472565758b46', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:13:20.956229', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c7a3406063204880929cd180986cf502', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:13:20.956229', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('47e538241fad45b3904d14ec91ff42d7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:13:21.250642', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b484083b35a94b2ab959fde0c1fc4ec2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:13:21.249604', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4d4a9c3566a74561909edfdb6fd75794', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:13:21.486431', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e94a3443c37d48bb855fd244870a876d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:13:30.932763', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ebc70271bdb54b18ae8c3d4e9645cd01', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:13:30.988937', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('390563c0809d4012ad170e1ab7065bd2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:13:39.195859', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('08f1dcee8bff489a973bb985c76c712b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:13:39.314718', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('61d1192391d64dbf8a451d0ba62389d3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:13:39.348798', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('773b89600bfb45a3b228fc89c574a801', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:15:46.440348', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a26775cea58f46738ad18a65b4cd5dc1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:15:46.440348', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d1bf78b70c0c419a98623051f811b13e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:15:46.694256', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7db452c0c5c74c7aae18d4f1eae791a5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:15:46.695765', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('489c251c9b8b4071a8f1b9ae8619ef7c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:15:46.837337', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fb8867af088d4794bb9a4ebb5bcc4d7d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:15:48.643315', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('18f17b5b5ad94a4ab002a87a3f46fe34', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:15:50.925801', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1f9f4f4476254b74b6dbdc6eb149c0b9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:16:04.261544', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2bc6b4b1eeca487cb92acf89f6fa44de', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:16:13.388157', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bc8088120f964bac8ba13b4b479bda6e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:16:46.950503', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f4c4e49fd2b74f4bb3b6397defeac148', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:16:59.190139', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8918bb1cdeaf46e89378e035bd06ae9e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:17:02.894097', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('026f5d59ae3e4d3d98dda252bc737520', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:17:24.562614', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('481a3efd6f8f4d25a6110fa28646585c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:17:28.035784', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('88a3c1c0e277445fa47c3efad519bfe9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:17:28.074196', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d09d847ba262432ea93d3ca70e49ddf1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:17:49.093524', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b2c327c20d074e7281687479cb1fe6cb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:17:49.227352', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('05a73e35eb284591bcf10140f5400af1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:18:39.559056', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5074c75d5464494f94d852f21a019ebb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:20:11.257282', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7bbbb82d858847e7a7eaaddf5856ec26', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:21:16.245862', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1f8c6a6f1c894a24aa60330dc749c829', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:22:49.67407', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3cb01ac6e34a4642877d9145ea9a4e4b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:22:51.024786', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e98d6845981f410cbc75b6ee9e52e5c4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:24:11.197899', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6072045c9c964a78ba9b1fa74f4f2ddc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:24:18.519388', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d8d8f7c772494d0aa459ed9d75cc3a53', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:26:49.086571', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c045fa4e1fe844ef960f0d391b4750f5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:26:52.426553', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('01c2e72e759945ada6ab13bdedd27549', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:27:13.378117', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b5f59e1ce5164925987075cf963791e0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:24:15.226107', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ad541eb53b0243d1ad0cd461bd83b9cb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:25:15.650519', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('53764ef6b42540eab6df4b650ed85a19', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:27:13.425097', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('700fbf0274d245b3baee33722f1823c1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:25:17.80131', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('acf9aa79db9a4fe3ad53ad9970ad0e0d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:28:02.780369', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8c01543ec2dc410dbbd2dcda1bd6ad64', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:28:02.824464', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6915f4285f7645b399bf89ac2bb1dca7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:28:11.565173', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('46eb87642e8e4e388975ea5abbf7fc2b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:33:21.072324', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6e126a7456c54688b03223b3c6e3f507', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:33:21.147096', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8b4dcb13264f4965ae09168035b2594f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:36:56.605673', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4a011044d32e446c84f7f66d48018871', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:36:56.636116', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('da76719a1ab245a1825ac1ccc48b9e76', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:36:56.778963', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('13c7e57889d84befa442b8714974b25e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:36:56.784013', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1bb82bec45c54c8b859af0ba7694fa20', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:37:04.360386', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f3076a13d1ea4623b30e8e5cbbecf755', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:37:04.375708', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('76b7aa0036484abeb0e932c80aeacadc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:37:04.594214', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6f8d968209d44823b7a9c740cdd9bcc8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:37:04.606592', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('16fd77fcde3c4c469bdfa6c0941069b3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:37:05.908676', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('00452a98e5f547778681961441da802c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:37:05.920825', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5c97b59122da490299ce3cb92645f520', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:37:05.996874', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5888f7fc3a6f41c89227fd7e7c2b7532', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:37:06.017613', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b10d8d7d326046f588bf5da7e0f501ee', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:38:07.176014', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('06e73ea75bd44461a17362f630a841a1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:38:07.238625', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1b75cba35c2b4a0287459f3281c609fa', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:46:05.929122', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f634f7081dab46608b65acaadd222738', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 11:46:06.068889', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5cc0b20ae4574217a1a30590f8875e39', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:28:47.713384', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f1048ca5b01e47efb9fa300f86ee607b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:28:47.910747', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5582bf59ca7b4188a16532ffe3c19bc9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:28:47.991761', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7a236d1bbb5f46389356b80c3a6e1143', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:28:48.03513', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('22b4c0e4638f4f0c8aa5c6dab43c0e4f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:28:54.717607', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('666188803cad42fc896e9eca062eea48', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:28:56.743409', 'admin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b4ae102ec0af4e9699ecf1bcf83002e0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:29:26.221497', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('82c1c7f688884a658d96be19c6f205ce', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:29:26.248052', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f768a385a525473dbb630e087ad9774d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:29:26.324261', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3dea8ca976b344739153a84195a400e9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:29:26.338788', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ef74024f7fa34f2dbb7fda6edd39857b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:29:28.683894', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e08c96d3a33c4b4f95204fdc521d6fa5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:29:30.47391', 'admin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4785bb7566ae4e4596d73f98dc5dff68', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:29:34.068545', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c1bd241274e04161b7947459bb0435b6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:29:36.208545', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9bd8964dc74f4cb29a4899d0f3f519b2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:29:36.260396', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('20b22e0900fc43758a1f75206083fe1a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:30:00.864712', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bea4287c3da14cfea97b3e6fc1d2f064', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:30:04.945897', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d732a9f0334849198cc0d1b8a546d7e5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:30:17.84476', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('40253b2f42f64788ad0ebb6fb3dc55f7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:30:21.556618', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('640017244b4f4fac91a1bfcd057af48e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:30:27.835469', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('136173e108a64fbdbfbaa2f9eaa1bbff', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:30:29.330973', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f15da726f5f4461e806106fcd0a0a3dc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:30:37.186382', 'admin', NULL, 1, '[文件管理] 上传文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9793afd5db574ea48abe88164ea598ba', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:30:37.259627', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('57f1f7848f9943a0b4037134d872fc6e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:30:56.328188', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7bf5c952590541afac568d6d3064764c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:31:32.093526', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6fd2f644cd264f16b354e726398f2fd5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:31:38.75089', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c05555b6148e4b98ad48811872f42118', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:32:16.323501', 'admin', NULL, 1, '[用户管理] 新增用户 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('608fdf53a41942beadf09bd8dbbbcb5e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:32:16.448538', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e8d82bc501dc43b38e40b1d9b42e38e0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:32:21.690466', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('135ae6f5a168471ab6abbb2da8fed62c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:32:41.952952', 'admin', NULL, 1, '[角色管理] 新增角色 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3325e27ef60c435fb8eeae36070d6f4a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:32:42.069554', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9595960f18194e07afff59eca01d98ce', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:32:45.100713', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cc950586a2dc47959139cfd1738119f5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:32:45.020487', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fca129af0ff848069c2cbef764be643b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:33:09.350577', 'admin', NULL, 2, '[角色管理] 修改菜单权限 失败: class java.lang.Integer cannot be cast to class java.lang.Long (java.lang.Integer and java.lang.Long are in module java.base of loader ''bootstrap'')', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('aafe3966ef3a4ed7ad50e65748e7be54', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:04.771756', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('60c14009d01a4e0892c87d8e45fd161b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:04.95758', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5dc3e1e42d02406187e3bd76974155e4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:05.050641', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b3af459959724553a0a99a15e4839556', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:07.365052', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dad150d48c874cb48d36a37f73f4a513', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:07.422496', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fcb3f4df0f854f17b34388024a617dee', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:07.475507', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('234c52fbe8744ce29a98c8497e5b96cb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:07.519574', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c102da6d2f844055990d770db3657378', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:10.982503', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9f29b525113b475b835aadee3bc2c43e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:11.001118', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ac7bf642977541fcb075a8e3fb6fdd55', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:26.105059', 'admin', NULL, 2, '[角色管理] 修改菜单权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e8e9825c8f8b40e19815cb66f3d131ff', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:26.260729', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5a943fbea9a54775ab41405a08febec9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:28.984167', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a6f158084c8349d2bf87a73647093f7b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:35.160691', 'admin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2aec43e5e78e4a16aafef3d4d25858fb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:39.57746', 'admin', NULL, 2, '[用户管理] 修改用户 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('06c8775786e0460eb381ec13a68f6c96', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:39.704434', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b85336bc2002405c9386a8fd9dcff8b2', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:54.151193', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('eb1e0aa6f98f4decbc88ff77ecd5b7ab', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:36:54.227327', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('156f3118d9784780af8e2ccff54d1ea4', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:37:43.048971', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('179164f3776d48bdbe5eddff1ef4c5e1', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:37:43.150131', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3c418ffb040441ee9c18506c80dbffc3', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:39:27.193106', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e489b9477ca04c63850830ebfc5a8454', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:39:27.352908', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9637b4a32c4f460db86236eb7224da86', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:40:24.676884', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b375d00003e6416caa0b3177e24c00d6', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:40:24.896319', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('aa2e4ce2c09c4b5b81da46994567609c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:40:35.569038', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dc507c9c3f1948c8be5ce5f6f9aa7f66', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:40:35.580566', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5950b8dc7e9a4ff58a27d76f5ba517bc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:40:35.674794', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7e6d780cc0ff4b639afb0552a8dc0a74', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:40:35.722366', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dd7441822d68412e8006bab2fefea0e0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:40:41.759595', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f155e42ea46e4c1b92d96ac43cd8c041', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:40:42.743458', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6b3d4220538849b4844a638560e108d2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:40:44.40701', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dfe03c92db4e46309617071bde707a81', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:40:44.435526', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1e5ff12cc0ee4b87a57036d0b3a0e8ae', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:41:12.82348', 'admin', NULL, 2, '[角色管理] 修改菜单权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fe73e9114bac46d5b8e171fd367a121d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:41:12.935108', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f511e1d1515b401fab30c3e58c5992d9', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:41:26.915645', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b9f27c3b854d437a9db36b02e1de0332', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:41:26.998783', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('15665a52471e49aca162d75871c93293', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:41:51.66163', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7702c60ef0404dab93c0bee30fa7d6cd', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:41:51.799613', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dc891de0f4444090b74365f68f821d45', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:44:21.706086', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e156e888563b4dfab77faf27839be402', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:44:21.891215', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5ddd973ee27f4e5eb349001c5ea7ef28', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:49:53.3112', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d04457a67483417b92937deedc232301', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:49:53.505937', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fa72bcac01914710a116c2cb8ad27e0d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:50:02.443683', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1784afc495624b93b2a506664ccd3ed8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:50:02.461754', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4b69a50b9da04b84b0872db017c7b296', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:50:02.514908', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('70c01728c9fc4e5f85f4ed41db058e6a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 12:50:02.517415', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dd5bcdadf8db43ecb3009ae19a9af898', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:50:15.550603', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3f48af5f803a47dd9b5d326f761eed2d', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 12:50:15.611266', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3133b8f666e64d7599e751ef55384914', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:07:36.753602', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('60b4c9a6ec18490fa730807bf7f66e67', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:07:36.955694', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5533ce0db2ff46468d0f6a58d795ba20', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:09:09.013578', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('33b5c851575a49c1915a58c4789ad7a9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:09:09.253572', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b93aea997f454d7ba6f2424899b05228', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:09:09.268607', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2b21d57a326142e8b81b2d256626e769', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:09:09.37138', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5648038e5c8d42fa9b355b718187914c', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:09:22.023678', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('53cce78c43b14d8394071955cb266e3e', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:09:22.119574', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ce73179d55804cbcaafb54ccdc6e70a5', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:09:41.721371', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('db9029bf9b3d4f7abab29dca1ee22e43', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:09:41.86942', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1774752b199d45a6940ffee8ccadb136', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:14:53.211776', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5b90adb68c2543f78c20462ac00a8197', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:14:53.392815', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1a80f1a6988c43f9b85bbb60c50173d5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:15:03.171722', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('73eb6e437a644e6c9b983c13f6bb86df', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:15:03.185778', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('50e7642db73942609483602dd5d300b3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:15:03.25005', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8e32951aacf24abb9cb7ef185affd404', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:15:03.245743', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1a25d97dc9eb46df99bd5b6e0d97069b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:15:05.916977', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c426df796cff483bb446657e727eb5d6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:15:07.171896', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f7d5029fd58f41798c2c86c2683c4dbc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:15:08.95214', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f65394b5feb84515a0b32e8c47ee732c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:15:08.958183', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e926126bf31b4e5facaa1048890b0e34', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:22:33.023086', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('54eb8194b20f45bdbb03e51e934bbac7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:22:33.217704', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9b91c32474084a17b92c1bed0dc405d2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:22:33.334977', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b11f5f2cb5e24654bef9e0f7a44135dd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:22:42.483435', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6a4114c65b6242d59e4b5b84b00b4a7e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:22:45.42934', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('80fb93b79bfa4a55b2ab819f0ac5bad9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:22:46.501084', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3f7138b8fe764c2cbbbaf02dd1596c51', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:22:47.574832', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('aab659f1a8094fe9a27d2614e9cd8d9e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:22:49.353401', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0bc0d3cc59db4bd88d8a92b5dcf582a8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:22:52.227017', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('896033f447364f3a968d132a11af887a', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:23:04.122657', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3b5e6ae1d6bf4b95a9c021ed4736f1c1', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:23:04.15242', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fd6cf0cf04f441fa9b2184281c149b46', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:23:04.241866', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('022281768d924d0082ff099974e268bf', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:24:24.582778', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f13db28a27d54fdd907d1962540c8f03', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:24:24.649513', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ad6acbe6699940bf9b28e0caff4ef59b', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:24:24.730776', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2a7f60fecad34e119038b2dcdd691a31', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:24:26.501035', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('88a04e65ea7140a79ca1cf051e6b005e', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:24:26.532796', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e5842e4905d74cd8bf7ff40a0241a2d2', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:24:26.640265', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('63b860a9683743f68cbf066c63067843', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:30:33.717351', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ecf17970eb2c4b76bd9bd724a00d9a7c', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:30:33.879785', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6227f6826b394a449921e8e8e512bd1e', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:30:33.903373', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e1c4bec15e1b48efba90214c4b41f375', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:32:03.229906', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('246c25fa778944f18fc7635ea9aad586', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:32:03.250764', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c8a9a84a196f49279ad9168799d4e5f9', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:32:03.453296', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('16df095efe984253853d6f80722a281f', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:32:08.779924', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4a41252156fe4787ab5bf582de395333', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:38:53.32416', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b49dbb20d2b64c1db3b8269d78849af0', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:38:53.560457', 'wangbin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3768b5720e334010b362e001525dcb4c', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:38:53.606878', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fbd0b739ffe0482d9ef7d2f8fa521cbe', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:38:58.975418', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8cdeadfe7499496199766e89d8bc6959', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:39:01.997749', 'wangbin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('98b6e7f422ae4b8ba7cda5c4e468ba5e', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:39:03.023374', 'wangbin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0d1134b006b243168cdeb0a1c1e3aa0b', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:39:05.068932', 'wangbin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d3a29ba1920d4b50b74edb449fc8359f', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:39:07.315488', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8315429cc47141cf93e5e792e3f1c5ee', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:39:29.142871', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e4c9c1edbfef4c93b59d7264e6075916', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:39:29.303481', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a0715955528e40398c887243c7135310', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:39:32.74012', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('412182aa3b0447a1a3eb7519723c7935', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:40:34.314403', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('271055ebfc224bceaacd8c233e03bcfd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:40:36.275588', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('24dc6001733b42ff9c94d22961330f7f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:40:37.37637', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('991e576dfd9e494ba2cd06e99aa97453', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:40:46.589942', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('88d25a5796b54a30aa1c3baec9a094b3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:40:53.155365', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7ed7ee0541d8477ebe68437d75d1e392', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:40:55.448751', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('912f64ca15584ee7bf21c7631f1a8858', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:42:17.685686', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9382d08cc6744f39838639e8d066cf75', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:42:21.889783', 'admin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('464a448b3d554fe38a5fe7d98dce8406', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:43:01.874999', 'admin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('83f6120430d941fd9ebba8df808f06d4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:46:31.191033', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('03712aca0cad47de9e45f6b2e41eea34', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:46:49.733249', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9e77ff61e3ab4198b6199209254379be', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:46:59.607865', 'admin', NULL, 2, '[角色管理] 修改菜单权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('35ea52ae424340fabcfeb8f3e8278452', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:47:12.733701', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d55c1769b0254e1da662dd390947427e', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:47:12.912708', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a9ce008701544b63ba437e9f8311e585', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:47:18.271864', 'wangbin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f7b874dd2dda448491e45097a00d130c', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:47:26.837783', 'wangbin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d7e3d24217d3434ba081f62541ae7223', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:47:29.149105', 'wangbin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5ee4bfdff844495094e3c5969c0f2793', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:39:29.126847', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bddc16b27ba0455fa42c1e351f0f55d9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:39:29.219314', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('391ed228bc3f4249b2ac2b2dfea148c3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:39:35.673278', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f12c0d6de0904283988ce261308ed281', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:40:37.392033', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e7c7d7a6f7e94ca8b3426424e5410b51', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:46:34.196833', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fa802b2343b849e39effd55662d87d04', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:46:47.673886', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2c724f539d1443fe80a6ce7fc4a5527e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:46:49.744327', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2e77bb0b5c3e41479db0a411f234168d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 13:46:59.707585', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('61735669f7064e208a60e12dab71326a', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:47:12.807288', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0bc800f76cbd4550b60dc74a71b42aeb', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:47:14.931937', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('01083d8753c84b06b1a6a5e15df5b422', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:47:29.983631', 'wangbin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5411194d57df4381b9eb756937b3d925', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 13:47:31.259921', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fd918087500c4631b8b20ddc8c9aeba8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:16:15.276721', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8d7b2a36d6204a67a2910083341036ec', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:16:15.461917', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('adc71c99081043f4a171aa777aaf8143', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:16:15.486918', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bd5e50ee52694d49b412d95ecf855620', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:16:15.571289', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('27ecab2347df44c4898f1e775b2ce012', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:16:18.015155', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c6120c1349944a86ba931e156a617aac', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:16:22.232661', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('600304f55e2146e78899e9752c1ca74e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:16:25.022508', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c5c92d73a0894c14bd9ed2b356a13fd2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:16:25.042836', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9c647d808ef14137981c528135cbcdd3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:16:52.421855', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e4f388c63d5f4f888a951f87b2ff69ca', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:17:20.488991', 'admin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('48ce5c5a4ff34c0d958607b9fc9ae26d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:22:04.325553', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('76fd2ae4d839460b9571b1edd8e4bcb7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:25:31.03431', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('04bee38ba3fa462ba6183b7ce823f67a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:25:31.386434', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f78500a133bf44f0b2a7b6f572c56ffc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:25:31.450783', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5931e27fb10e42bc930ad91a8be7bb27', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:25:34.495089', 'admin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2b04d94d37c94e20a238ed501bca0691', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:25:58.723706', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ad2284b5a76e4d8794f3ee5ded47acff', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:25:58.741249', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('20af92373e7e4d65b40deb76cf35a8bf', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:25:58.831435', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('00c2cb9604ba4775af4b313c58822621', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:25:58.859501', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('462b1b0e49a048abaf796de351efef11', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:26:03.345006', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('023287a5371d480b829c0ea83345c265', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:26:08.24679', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9a1d6d447e2643ffaa4fb07310b038af', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:26:14.757956', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('919da032f7b64fe1bb2dac464902a424', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:26:14.816636', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f2681a4dd24f46a9b33c9b18b59ba0ab', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:28:08.628358', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3822c66b51024dac99840dab01c76a19', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:28:20.519035', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('707829ddc688442d8f7e5d23d6efc9ed', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:28:20.563376', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ddadf5c4e13f45bfbc4ea016e25beb51', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:28:20.688147', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5085400e5e624f72a97ec6758b82abe0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:28:22.492254', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d2b39cd382a643a29f0b37742dc2130a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:37:21.160692', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('00dbfc1c7d754f36b11b89c36e166bb4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:37:21.735976', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('69f8f2874fe04104849320d98affa5d9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:37:22.280007', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a0b2eb8817344fe3bd600274d8d7369f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:37:22.546638', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('65f3d70947884bc98dd4a2d264c5c4b7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:49:11.813944', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('931e5a4363e141e6bc4826850a369745', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:49:12.295898', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('19f51014b42b42cc96e3205e8b003690', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:49:13.326547', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cb4dd5efbdef402b8837971086a0010a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 14:49:13.837449', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8f9d203b5a774678ba79c1fac16e334e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:09:20.760568', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cae8a7561e654ee8a86e4805f2610398', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:09:20.808893', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1a43138fc2fa4de4bd5d57d8ee20916c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:09:20.918062', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3925c57175c7409c83a7c879c69ac7d7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:09:20.952914', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e269df14c571492d90390652890dcbdb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:09:22.678022', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8c0ada09d6824f1a91f06f721ac6d712', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:09:24.9369', 'admin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('90c15f34f6aa44a6bc77aa3afa5170c0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:09:32.210035', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('89c01820eacc4c349e649fa021ca5924', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:09:37.360763', 'admin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('de8e8e8f93744572bc30abe30f925e44', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:09:41.464829', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ee9ae8076a9a4054a21d0528eb0b9280', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:01.921292', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3334fdca5c58497993ce0c03c7a8e241', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:15.330471', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e21bb220d7f447fe912f0f74601e03d3', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:15.612049', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2f96f6a1abcb4e768406b7459d29138e', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:20.111365', 'wangbin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ff157ed5eddc4bc18d1731303ca66921', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:28.716616', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f0067888f3f34ab7810fe3cc51adeb4a', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:55.152548', 'wangbin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('68fe8550a3cb41ed810d282bf4c9bd95', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:09:32.011343', 'admin', NULL, 2, '[用户管理] 修改用户 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2ebf4b6a100b401f94389c1f4105aeb7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:01.885342', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9d3b435ab7ac43d6b862984b8b3df658', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:02.024668', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f9b830eb66b745ffa01b471bebe5d345', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:15.502637', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bdad91341d5649f29c81aaa4d469e9db', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:18.105494', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('119a58888b6a44f199d763aa6eca9355', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:31.267497', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('711ca0affc9f4ef0a27a6b5beaf7086d', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:13:33.614268', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1c356563135545b881b3afa2fe2e67d5', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:07.19123', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('db736db02171489ba9050c5480375a8a', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:09.212971', 'wangbin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('eb836d018750497cb48f8cc5cc7d0e31', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:10.032036', 'wangbin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('45c845de3ba64174bbefb4f19955b88c', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:19.973842', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('19b0bd82815d41fe89c78dbee45ebf54', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:34.549802', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d90602347a084048aedd30a0a93e08f4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:34.58843', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5c622be22a294d579ac8376636646eda', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:34.670171', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('713f144b671045a09bde9b7ed9fb4f3c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:34.710954', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1b87fafda9c94f78b42f5ac8d7570b4e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:38.207318', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('00713848f3c04965af028d8747ebb0a0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:40.167535', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9a97aedb783b42d4b5351f67c482d87e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:41.680636', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d35edd2bbfbf4085b4a47c0472e2ac47', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:51.43124', 'admin', NULL, 1, '[字典管理] 新增字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ec0932c25dee42b2b6a92f64b7d5a25d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:51.57836', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('44deadc8acc741d5930355c09ebb14aa', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:59.141277', 'admin', NULL, 1, '[字典管理] 新增字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7d41948e91ae4150abb2310f890e7b26', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:39:59.316189', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c70ab44504fd435e8179a82962b4d607', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:40:01.787471', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4559116bc53b4cd8b6b4b42e013f864e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:40:03.989294', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d141a5b5b29f4666b50857f7d4931382', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:40:37.156887', 'admin', NULL, 3, '[字典管理] 删除字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7f6bd31e62194a7caf0ccc6534dab589', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:40:37.255572', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9d51b97c0fb2462891c5fc8973a42cf3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:40:44.645936', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ee59cd54312e4639a4e7c8a62b93475c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:40:48.582023', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ad91562b3698416e802536629f9d1668', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:40:49.847946', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fbbb343baba1457ca65cad55f9c5a6ac', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:40:56.861847', 'admin', NULL, 3, '[字典管理] 删除字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d96395712c0a4ebd833d612fb371e282', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:40:56.993617', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ce2b47802c2b490aa20ab94baf5d742c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:03.408484', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f5ce2e0dab5c41e6ae369d9f8e5ddd68', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:10.114891', 'admin', NULL, 1, '[角色管理] 新增角色 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bbac7c75a0314e4dae255831876f4b53', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:10.214214', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3375a72a9595422c905520e7cb0a5be4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:14.031496', 'admin', NULL, 3, '[角色管理] 删除角色 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4d628d0b78f1400d94e66f988b1a2fda', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:14.150097', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f417b8c3330b4c21940c6094282576d3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:17.148275', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f25b019c9bca430ca5f062bfea9ee26e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:18.550203', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a78fd7ba0e1d4b1ab7f6c50989543017', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:31.639776', 'admin', NULL, 1, '[组织管理] 新增组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('918171e75c884f8cab0bfb48a0c4fb0a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:31.724317', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e17cde5c8cff45548ee7dbe9b7ff7a3d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:37.964973', 'admin', NULL, 3, '[组织管理] 删除组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4008615158564ee0b236b3ae6ae8479b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:38.095299', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d5b117a1acaf4f56b59d607901b9f8cd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:40.284934', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('798e498b0e614341ba0f13d1a0417ce5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:42.774286', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('42bbc8068ba54ea6b4ecc69f528d13f8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:45.188533', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7c621f153d03402289cd6837227840c7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:48.545669', 'admin', NULL, 3, '[字典管理] 删除字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7ca0504f8aea44b7bfc07e7b0f8456dc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:41:48.670118', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('de1769380b8442aea2424b15e67a40f8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:52:59.393776', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a4fa7f6620184d958be0c00c0b8150ae', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:52:59.622613', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f65b2480615a45e387aaee0bb2871356', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:53:00.192792', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5c1ac19129e44ef38caddb864fb3b083', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:53:03.655245', 'admin', NULL, 3, '[字典管理] 删除字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4b24a764c83b4eea983bb3f8b2127e0e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:53:03.87693', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('914f4188cd1f4d6c97e957ff5c91581a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:53:08.194511', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('38bb6073533645759203d6cb2ff20dc4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:53:09.571146', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9430e323df31407f92c362ab2647af8c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:53:10.705402', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('240523d9124949118c0102faa160f6ca', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:53:14.781424', 'admin', NULL, 3, '[字典管理] 删除字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ae1fc6ebfe81438684ac3adfeb0bd1a3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:53:15.035935', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('22af1595233d4a16acf9c3943b5b8ea6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:18.370629', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bfd45ddb8d5c428589e41503bd4b1653', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:18.650544', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2ba7423762a34cfca37b807db234fd7a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:18.869176', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6cadafe5f0dc4fe88f7d49495d4743a3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:24.067138', 'admin', NULL, 3, '[字典管理] 删除字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f44e23f55f9a49d0b13da91bbaa62141', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:24.288605', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('08af6eea556f41d99aa6782581e328e2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:29.189581', 'admin', NULL, 3, '[字典管理] 删除字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('344fab2e99fe4389893f3b7de43c6a05', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:29.462699', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('792a42ce0bad454e9a499b258dc9d55a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:30.845431', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b955e03e093f4d45ac9c5cac7fb90a31', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:41.728907', 'admin', NULL, 1, '[参数设置] 新增参数 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b0f44fbcde9c48d68dc2f1942a48eca7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:41.919257', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cb5fcc0f1733402bb2229a652f8af944', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:44.326261', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('187f23f246a148359bf2c2aebaa0c4fe', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:46.204694', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2aa33c24b49840b18f6de1536b766702', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 15:58:52.526319', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('af2065cac5704c5fab181c11d020fc5e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 17:07:46.312085', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1bfac94e26b24240872815fa293195d3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 17:07:46.701636', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ad1cbbd5688646d3949a3592a5461fd0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 17:07:46.796028', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d43b8e34c0f04ebf886366cc270f2673', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 17:08:02.559516', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a49d857b9f3340edbd6a1cb94d428872', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 17:08:02.802263', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('36d7050cf0b8400d965c37d47d0fe284', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 17:08:02.996775', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d3e5f3e6339244fbac544ae89fbb7717', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 17:08:03.047351', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ac2f1492b8b04fd48eeb936ea13b061b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 17:08:11.093621', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7599d733bce04e3b96f0034bd4767bac', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 17:08:16.594847', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('795cad3b30fb485f9f1af22458112eb3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:12:16.743485', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d0c86a296f4d4195beb88f502f831a4f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:12:16.798063', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('71cc5a0801e746399410b724570d97a3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:12:16.92128', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f38c73e43d3443beb8d04e03ebb602d5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:12:16.92128', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7a2cdfe5c7554d6199e24b1226746ccc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:12:26.905387', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6cc9f7d01c83466bbd96be6063e5a316', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:12:26.969354', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ec57dafeaf57469bae646dd58fccc52e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:12:27.083246', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bd01fdd9bc964bf8942c6bf9f68ed995', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:12:27.08807', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('810f155192d84da9b0031c1535bdc954', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:12:37.211946', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('59b47c31b4d34fabb0e11605fc3c853b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:12:37.317859', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bf8d5d67903f457ab1123252043ab5c2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:12:37.395343', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('647cd0dd304c49499f9c642c09a3e609', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:21.194488', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5437c8b654334dba9aeb17c65fa652aa', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:21.270491', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f5cb9746d37846dc9467812669786ed1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:21.371353', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('620b06d9ae4f429eaf5f1317a5940373', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:21.392673', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('23cbec4ad8434ec0ac3b1609d030ebb3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:29.480095', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8c202aba401a48a5918f19d20936afd2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:29.554465', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e088feebaa214d07aa0df88b0992a07e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:29.63753', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('49be568290d14e6b93f0138a9914cbad', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:29.654311', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cc9af785182942d188ba523924bae7b8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:35.853617', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a75a983c8844470dae1bc1851bb7f227', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:35.932131', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('60c58114098f4500bbced98b76797852', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:36.027283', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e66864dbb283414ca2e81c41de113a68', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:36.027283', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2dd42550ecb54b95847862424b992acf', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:41.462672', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('29752bc4cb0c486f8d00179978a7be28', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:41.536609', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ef594dc93481463f8fa15e10d5e870b0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:47.329019', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5c9bcae13bfa43ea8f42f2cfcb2d062a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:41.615539', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('30da3e5fde7d4fd284c1f2a84d55be5e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:47.269835', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('29a19b486a364f61b08c4125ec8b64ac', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:47.335108', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('310a298d122e4ca8a96ffbd16f6ce9af', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:55.002751', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('54c38f04ed76435fa3ed5777b08ad33d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:59.658951', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3c68f63bd3b443219c460166e2020e9d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:59.827602', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1be4c50dc8594c7fb13932d11d323175', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:41.632033', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9e0e69cfc217410e83f4733207554472', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:47.235844', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('74b7e011303b4769b7a153826c7177ce', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:54.793197', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d4cd043349f240b4a0639761711f78b2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:54.949456', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e0d38d6cb9fd4ba1a63a38b27330053f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-03 18:13:59.578788', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f9a11efdfc114d03ac77e792b3396ec5', 'anonymousUser', '0:0:0:0:0:0:0:1', '2026-06-03 21:07:53.319861', 'anonymousUser', NULL, 4, '[认证管理] 获取用户信息 失败: Cannot invoke "com.management.entity.SysUser.getId()" because "user" is null', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('41bd27dd434b47a2a676bd3fbfbd4bab', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:39:45.711566', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('452dbfdeada94847b7959d7063e695da', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:39:45.768443', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8c2b65793b364fd390782f123db17bc2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:39:45.905225', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('565ab39a5f494e928960b2dac7952c49', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:39:46.032034', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('45d80c7256b542df9c07c0f0abb9e1a4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:39:54.474204', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('da511a6ea569412e9695f42370e025da', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:39:58.531282', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('54d01f77ed63479e9204827c4bd9cdc7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:40:07.184595', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b86d93648962447ebb34afb103c04f01', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:40:07.197311', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b575c442ca874cfdac18230d12182f59', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:40:12.446195', 'admin', NULL, 2, '[角色管理] 修改菜单权限 失败: class java.lang.String cannot be cast to class java.lang.Number (java.lang.String and java.lang.Number are in module java.base of loader ''bootstrap'')', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('361fb05dd5844493ac5d07e179f4ed41', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:11.810485', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bd21985a7af14c77b4b6fa3efc5e3d0c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:12.352787', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6b07adadf3b64d4085a992e83b9c7031', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:12.931794', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('549d649f6d524e0aad6d2a940df16440', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:16.318848', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('499df2a927db47faaa5189997c8d1adb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:17.985268', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0b44bc9b476440d9b2661b661a458954', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:18.175349', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f5c665b0b0b542f9bd7177b4c1c9a0ea', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:21.677405', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a0d5b22d68d641aaab6ad0e9d9a2317f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:25.169177', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7b96c3d658d64063bd9f7d7d53a48cef', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:25.215557', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('adf8d436cfed40d39180eba31709e2a1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:30.980342', 'admin', NULL, 2, '[角色管理] 修改菜单权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8e2fdd9f970342d9b4cf17cfeeb09a3f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:31.399551', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cb17d14283b046b6994e2e4ad0f565fd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:33.669194', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b0e66ee363f84814b835f0ff7e120a51', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:33.67926', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9ccf029eb3f140ca9c7dc185d33ac9af', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:40.746768', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6663aee67bcb4a9689d991911be98ee0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:40.911052', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c5d158f218514d20a8bb8cf879114cc2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:41.268132', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b65b112ca2a14cc784fe4fe239d29b20', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:48.069004', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('571531ba17e24b91bc03ec595b644eb8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:45:48.075536', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('15170f1c4f394f5f94f106578e5fc1a4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:46:04.519027', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6cc782b536fe491e995572ddeb70e2dc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:46:04.558848', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0afa0fa5fe534131b29860d0da27635e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:46:04.762974', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8c1006d05b1443a99b37a45d8d24ccd6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:50:48.056787', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e11dae80c224418d8185f2755feb090e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:50:48.270085', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('775cd61b03d149149482e7b32a1bce66', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:50:48.929223', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('647f267f7df74a9791830a8f9c51c55c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:50:50.264359', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('00cb056e51904a7ebc0bb307b166f395', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:50:50.411219', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('eff2db9fc41d4d07b6982e47f921a645', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:50:51.097255', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3325b1637a91445f8fa18e8eccdba443', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:50:53.962792', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('155be5125c2a47238d62db3de29b9e57', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:51:11.596144', 'admin', NULL, 9, '[代码生成] 预览代码 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fd1d59c2fc2343aeaf4581c645dc50e3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:51:39.495049', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('713f40fcee7547d58d67edf7f73eaffd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:51:39.73004', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('10363fe641d84893aaae2096a00f0a27', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:51:39.827581', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1990cd9a181f4e04ad188876fa549516', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:51:42.822206', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f08386427d7e4327be70a3765ba8afe3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:52:17.703749', 'admin', NULL, 9, '[代码生成] 预览代码 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fb15a6e49573434abfc3c6e307d394dc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:52:38.607145', 'admin', NULL, 9, '[代码生成] 预览代码 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e194eab14c5a4a07a54eaf5a22a22160', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:57:58.681696', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('400396c6dc924dba88e13e0b1fa2bf85', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:58:03.507487', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d5a846faf3e9410a82d42499649026f1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:06.649761', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('89bb381980354cb7a896e24d8b84c243', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:06.745559', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8b25d4adfc8248bfb7c314271ad12d27', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:19.748711', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('aa6931d36e884c99ba53aa1dcfe89ea2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:28.272276', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fff07e1418454f519d1cf5245976d318', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:41.093058', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('988a99d230814a618a6012aa7a2ee616', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:41.221465', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b07dacf5cdba4e2293c20091ebdea95d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:57:59.105045', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d48c7d51b4f84548ae89384252e6f383', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:58:04.389196', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('782e427afa6b43dea89343a2b2aafb35', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 00:58:17.156679', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8fa70f1042ea49459a4313935973be0c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:06.715403', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('16fb5a3513dd47d385438f2f45773c2c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:19.834905', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1a0b0327f9c6448ca28474a280ae1f09', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:19.876185', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2f598f90c6524ee5a91d42a21e445f13', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:27.889322', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d3404aaf150d40e382af84b96bf5a2a6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:28.08719', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5a51d36c04a148aa8f9891ecc1e73113', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:36.264804', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ab28eed1b88b41239dfb1c3a36a56484', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:36.348862', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f936857ac3cc43348c8239ae9cbf86e5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:36.377586', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5e6246a0fe784b41b3530a282d73f4cb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:01:41.190584', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9d182f68bae84562acc9d401a9403302', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:13.703317', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('80e8219b4f4940e7b119539090961df0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:16.169016', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9bb4b1819cb74e04a2a69412e1a283bd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:17.044162', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d4f54f341b17408094491954cfce7b98', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:25.007795', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cc70a0447a194d7cbfd644eb6513818d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:28.248477', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f698e9ce462e44e0a6106603ed355859', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:31.286224', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('15832cbce78b47dfb3b57876b39216a5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:31.369907', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('af9e8c120d9a41cab8ce3cfd05224bf4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:49.430302', 'admin', NULL, 2, '[角色管理] 修改菜单权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('04797f13317e49d08793eb418474934f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:50.230847', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7169a82854b4482397d0d8cacab5d798', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:54.121698', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('df9ee21356f74993ab3e2d2bd86d4b5c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:54.173796', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('80b4cbe8e34b4dcc985a064221f0dc54', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:11:54.752217', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8ead20c6bb664eeb8c142e3ca5948dc4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:12:03.412484', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c4b6f9e3b4774ed28014a9bbf7cd0f61', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:12:03.465944', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a0b4b4df63f34882ae868ddb93d9a8f6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:12:27.410815', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5d1b4a5ad93c4560bed89ec3c582cded', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:12:27.516408', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('04f7b36c5c274ff1881db070c442a907', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:12:27.91094', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a68bfddbf87b46eeaa491e8cf599eedc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:12:40.370248', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c5db3e0c789d4ca78fa8f9a346869be3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:12:40.386667', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b5b2d816822543709a60cb80723dcd20', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:12:59.030383', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('11db2c3d8f6345b88062e941b22e7350', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:12:59.488281', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a2af97e6d458429f88c14cbcb05fc80d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:12:59.848559', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('06668892fb9e4340ae186119a50730e1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:12:59.846031', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('741c6bfc56bc4c998f179e85f29272a1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:13:09.438113', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('45c291b1bf08417f80e7bfaa9aceb2ae', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:13:21.500487', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d58194b8af834db1b763eaf793c36acf', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:13:25.574129', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('92af2d5948d942daa37e1e0fe01a36a9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:18:19.292024', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c85ccbd8047343969c872b6d10c69571', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:18:19.328354', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5b57df71668e4633afb8be9ac83ef9f6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:18:19.859962', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9eccf3229e13478cb2d49fa1932ea6fe', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:18:25.378208', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a26383c4bd364cebbd70833738f20eb6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:18:34.916578', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e1b68525494a4be4bf8078c667a52b4c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:19:31.201415', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('038b93b3c9fe4119a86b367e8ba1e81e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:19:31.477264', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('971f7a0880294a57a61be83f46ac4b60', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:19:31.736181', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c117a7c0f9cb4571abe251400b4fc43a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:19:49.423563', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dfc6e610b13647f49137de8ed1c39831', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:19:49.615905', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bb373d498d194caa96d59f4d807641cc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 01:19:50.011605', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bb5b8004eb6d4920a13e2adcbae71cc1', 'anonymousUser', '0:0:0:0:0:0:0:1', '2026-06-04 09:18:08.772161', 'anonymousUser', NULL, 4, '[认证管理] 获取用户信息 失败: Cannot invoke "com.management.entity.SysUser.getId()" because "user" is null', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('523b84723e0249a595ce78f14dc2d2d1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 09:18:15.850764', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cef7a96fc19d4ac698d03d6b389cb1e7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 09:18:16.035459', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fed34bdb9ff445f0ad016191344207df', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 09:18:16.178635', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4e830b9fd3bf40b4be3934ff303eddcd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 09:18:16.195499', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e15da77bc880416bb76d390804644cb2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 09:18:21.078327', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e46267d125ee4725834173eb794726e2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 09:18:38.996963', 'admin', NULL, 4, '[定时任务] 查询任务列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('60a513281597450ea0d2a5268379897b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 09:22:22.78797', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9c745b1b7df54ba0aa15800d056ada0d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 09:22:28.859501', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bb0b844df78b4857baf22c4ee1fc2bd3', 'anonymousUser', '0:0:0:0:0:0:0:1', '2026-06-04 15:55:09.299506', 'anonymousUser', NULL, 4, '[认证管理] 获取用户信息 失败: Cannot invoke "com.management.entity.SysUser.getId()" because "user" is null', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('34be7552d3464b0e940921f960898615', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 15:55:29.972293', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9b556e7b98f44f849d5e2e33d378482b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 15:55:30.101603', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('11f80216cfd24b3bb751e28ff2ba3592', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 15:55:30.130907', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5b3e0729efb248f9a8aa90c228eb29fe', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 15:55:30.219703', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('485e456c51494a619d11e4bc128bfc8c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 15:55:44.511835', 'admin', NULL, 4, '[定时任务] 查询任务列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c356c205bdb04bad9b3d78a007bfa997', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 15:57:32.887604', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('67e8f6fa4e364aeeb620fe9b2016dd9e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 15:59:35.003244', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('241d533856434d9d9222ffaceeedbbe3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 15:59:35.15431', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0393a276bf174eb181ce429457d7656e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 15:59:35.221029', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d738c87e43db412c89841f7125f4a2ea', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 15:59:35.245147', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5161dcc9dc594a0ba9ce1e40e4064467', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:00:06.504151', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a85b99c08d0d491b8edbbbfae6b084f9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:00:06.610637', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3e96ee2c141f4e7c9a47126cdd389a99', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:00:07.401568', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f5043a7c0d7c45a685e4c4ccd3316f2f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:00:07.478032', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1f4733f2b60547ffa41b1ff5f6b7caf8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:12:07.005063', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('df5cbfc73cac455e8ddd0d6ed4b95713', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:12:07.058639', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('50b85bbbd3084f0eb867d43d8629d373', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:12:07.133896', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f44664fbdfaa44bc823c41d87d553696', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:12:07.17567', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fc3529f5f2064799bdb0b42d038bd6e9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:13:03.310685', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('751fcb0d35444e589e6091dc5b5130ae', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:13:04.325819', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ffcf9c8c462d4695859be62120d4e25e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:13:05.237311', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('65f64deb098046adb1ab7fbaeabc9a98', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:13:06.25149', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0ad8f695657a4094a536bebc289b8d63', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:13:23.228468', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bcc57c44d19a421d8ef0d549f13075a3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:13:24.277897', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c71d5c2e26184dae81f89352e90d58b9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:13:24.640326', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c0992b918d1c410b97353d38ee52e36b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:13:24.895497', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('639a3d62b19d400295d658909a24c301', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:14:13.40808', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b5c1507648f1447a94ef53b099fc11c9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:14:14.649126', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e057b93716984eed8046b43e0f3dd19d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:14:22.694277', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3b5879bb2a0c4b67a0f1db7ade0c893f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:14:22.787925', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0a428ebed0ec48aaa1a86b299d051298', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:43.509922', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8b784b5b7bad4b50ac787b88ab94931f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:43.684731', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9cddf5493baa44eaaef33173ee690935', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:43.749471', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('aa45d1dc93544d37bfc8335e21475f65', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:43.771636', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d9cc67677a9848149e938576f0066e5a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:45.519868', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('689d65803cf74fc3965fe920f3715d99', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:46.160638', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3c2fe3f105c540abbc358fa8ebe0f7c3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:49.474152', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f6071562f4ed4f47b7310e0645d5469e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:49.587074', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dc464aefef1f4d1e84e14da2fe15c1ae', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:54.88563', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('961b93acf1644258a8bc7691e4a79fd2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:54.966866', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2991bb1f674e4c068a36fe2445f94b6f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:56.364186', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c0d77d2bad1346e18f1f008761a8d58f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:59.207843', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b57c758b573841b0ba1b729734d70713', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:59.311786', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('71bdfadefa484ba2badfd570fa7e8a91', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:17:59.432315', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7f6bcfbcccf94dd09ee4930019ca71a2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:18:02.269775', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2b90672c65b34683a663c9f6f536ead5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:18:04.708914', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9efd656297cf4503accca29db5c387bb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:18:05.007161', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a7c8ce265f86424c846dd3d678686dea', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:18:11.582415', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ec3ee8072bf546218ffd9a23821cd72c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:18:04.845056', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e0cb925042c54a508f0a28a963267e78', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:18:12.54176', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4f2711ecb4a14556a1270afcc4749345', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:18:24.448295', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0db24cc21ab34a26bf9f5ed97c1fc045', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:18:24.513626', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('35805e52ae1e4e26bbf838073d7363bb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:20:29.979139', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8c10c97495de4c7b8d1191816c1bd4ae', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:20:30.064518', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bb946754f404465fa556d107adc0960b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:20:32.828628', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a1ebb67139d24c559a60593d776e0747', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:20:34.968189', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('82fba470551e42fa90242e3f061ccde0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:20:35.061593', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('91bd5ecbfbcd404a8851770e7ca38777', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:20:35.140803', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('eb30e712473143418c2938993943b361', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:02.8909', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('722a6f6c435545cd810d04edb0984135', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:03.120572', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2dbb516abb7449419ff53b208ad23893', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:03.255208', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('60d1e0cc94df4a8b9c3ec7be8ca74498', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:03.285779', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2ca6c970a07d42e9b9622faafa5e701a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:08.250506', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e608f09b024a4f4b9b05cbfc0659afde', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:10.108024', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b53b8aeaa8ae44bfb181d1fcbede0445', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:12.94405', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('806acff5a64043f19ba46e80a40bca5c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:16.597311', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('77762db077844d00825b9539d2ea8d11', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:19.023052', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('99532363ba2e4da686df7e887fb39b99', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:26.683402', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8cb094c75203472a8e858c1fbb49ba8f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:26.727781', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6a2d5d37f19343a2ad62fea59cb337ec', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:48.581107', 'admin', NULL, 4, '[定时任务] 查询任务列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8ad8c6a707c0410f8e0441abb0091cec', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:23:54.459219', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9fb80aa006ad49b796aa4bb4cc7381c6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:24:19.253029', 'admin', NULL, 9, '[代码生成] 预览代码 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d0f5e13e83524fb692d3b65c7d7164c8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:27:01.768311', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e027d40c46b047c9abceb64478a52953', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:27:42.600209', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9ddb134a6b7f45059fbef3c29488aff4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:28:55.858849', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('22320c42e7164549ae5f59ef6d49c56d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:28:58.436544', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5eda0437c1fc4100856fb5385f16d9d3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:28:59.155441', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8f636d99423e4df0a7144e9888b22d74', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:00.45172', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('991a610bbb934aff8a83f63656f7388e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:01.958734', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1943ea1ab771421d98405f02a22d69e9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:01.978392', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7dce2b952f35454692047d1074d26b48', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:12.04446', 'admin', NULL, 2, '[角色管理] 修改菜单权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('251fe3af78274ce4a2ab2ecf634a0839', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:12.2316', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8cf57bc5a1c743ad8b4d8365827f5f77', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:16.080278', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('640ace31d37042a4aa61116734b0e08c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:32.027879', 'admin', NULL, 9, '[代码生成] 预览代码 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5f5a0d68156e49e292ffd54d40dc17a3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:36.938116', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('39780f9d6a7a4da58b8479ad05e448a8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:36.9479', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('178f8a67dacf43fd8c43996a76e0ac43', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:37.150067', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9c899aaaf690428bb2a1f17dd3fa088a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:40.883277', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c4d07b7afa2c4f41bcd9407fba154897', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:40.884298', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ab0f733eb11840ca9bd4f6f25c043fdd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:41.028792', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9528139327664a018b50f48bc59e840f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:41.612545', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3431a95151ad4338a0fee57a9bbdbd08', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:41.626183', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fddc876baed7499daf06fd674748f485', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:41.798663', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('faf1cc6a7e5a46adb6a4727c1fba51e4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:43.373273', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('85bbc55438da4a9c85489037cbe3f951', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:43.373273', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('966c9a993aee47158225827e52b89558', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:29:43.505911', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('adeae571c27c4f4296d5974e52a62343', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:31:32.049095', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8f6d0eb389ef420a8d57d59690c5b711', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:31:32.119052', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a06bf8f1272d4a6ab9dc2f500cecf209', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:31:32.783381', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('318a681f820b4df6929131b5b97c298b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:31:39.013941', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4d666a0fedb04fcd98222f6e338b7545', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:31:38.970693', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6f843c49611d43bfb71ee097a73123f4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:31:39.532717', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('21a938d2fa8540d78ad29066f8e307df', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:31:45.698838', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6b3644b0f69841b7b2a37aa07e88503c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:32:10.087285', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('97fe674294c54ac48da143adde18ce6b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:32:36.331674', 'admin', NULL, 4, '[定时任务] 查询任务列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bee851c7f69541e2a4903f3bb652a505', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:32:44.240035', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6a54f80f46e641359bea4d5da565169c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:32:52.631161', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b3c90df2d2b34d40b6a20a24b85c0b7f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:37:37.140079', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('928777e0eff242faaa6ec0ae9765b8fb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:37:37.46337', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9a35ce526dd74122b3d85c636578719c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:37:54.995137', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fe329a384656448ea67159d9cd8bc970', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:37:59.381352', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('47dacf11fa454f7db2d7c42d245cffc4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:38:11.480698', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('23d3198cabaa4f45a53decf2f6df152d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:39:07.062944', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('65545651f3a846f39953be73865e1c80', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:39:11.325507', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f4befa8a6d594cf0843f2bab5606cac5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:43:46.560481', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8a35207ba99c40b59b466b1206be1a89', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:45:30.960217', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('07446cc3fac14892b6076dbaecf0734b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:40.14385', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2998536160e640ec9026ead4ade30bc0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:46.034994', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('522aa06320044cebac7c508ef1bbddf9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:46.379021', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d3e543328af24339b9632c5a1f185dfe', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:47.895586', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('72ab3d31ae0c4883bced107e4383eda8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:48.842627', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0bdbb060b4de4e75b02a914e9dc84215', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:49.124021', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9cf58ffebc224b258f45f63eb389b96b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:53.817768', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e8edec943aee491791831bb5c45b04fe', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:32:11.424845', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('df9b76bbf48f4be3917f40c9ed7b45b9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:37:37.26032', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ce9447ddb0a84b298d9d36964f08be51', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:37:37.389101', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('614ab188a8f54533a96a61c3cf48cfb1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:37:46.666726', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('87b1b58a19f9465e94796b75ec124bd8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:37:52.552721', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('57b2efdf5d9d41c985134acf0954c6e1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:37:55.892202', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('699099fec7cf451b983f8c53ab6ae889', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:37:59.40777', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ffe8ed02b8fd4c6c9ed9e2f48427cf01', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:38:10.786282', 'admin', NULL, 2, '[角色管理] 修改菜单权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fd23e1e8c5e4472d80c9fa7f7c336f7a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:39:07.02361', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('43d0be4e518643dda5f4f69f3c9056b5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:39:07.469917', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('51172373c9b942c6bb73978dc895b92f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:39:10.555075', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('998fb4bc22f1415088c83bc8b25e138e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:39:11.414874', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cd053ab0d5da4f0095aed0bc36e15919', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:39:13.934753', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('70feb681b787414d8690634eed7a4410', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:45:04.245316', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('680b44ee26c549a091890a8596b7a796', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:45:21.495815', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('711e4264a6894687ac99d88fc4d768ab', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:08.09461', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('136ecae607a842d19c08af6267a3df0e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:40.130552', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9f546d76b20c4b788f1c50b0a1b53222', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:40.415121', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('64accc4e400f456094509e0b62f8685b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:46.06378', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('68dff2073e6a4eaf930fcb403cb8ea9d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:47.564266', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('86f7232e8edb4d9f90450830c82c9722', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:47.616131', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('070c5785851b417da743e83453860abd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:48.87192', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cce6cdd896dd41598c26dba357ea959f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:48:50.781821', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('83a37f4c99f244b48bb14f0c1b5cba90', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 16:49:01.938721', 'admin', NULL, 9, '[代码生成] 预览代码 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('da3d8257014b4632a0cf43d34f18e82c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 17:09:30.845344', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e2c6db69a04047b98c42d23485e079d8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 17:09:31.26212', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cdeaefd324414cceb566a9ad8e0845be', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 17:09:31.263139', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a764ccc2566146199759956e0d702b3d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 17:09:31.423611', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('19a2887214484782a6d546f25b9fb261', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 17:09:34.98756', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1c119fda5b084d95961dfb12ee551ac7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:06:54.080089', 'admin', NULL, 1, '[代码生成] 新增表定义 失败: StatementCallback; bad SQL grammar [CREATE TABLE "application" (
  id bigint NOT NULL PRIMARY KEY,
  "id" varchar(32) NOT NULL,
  "name" varchar(255),
  "logo_url" text,
  "link_url" varchar(500),
  "create_time" timestamp,
  create_by varchar(64),
  create_time timestamp,
  update_by varchar(64),
  update_time timestamp,
  deleted smallint DEFAULT 0
)]', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('a8118aaeb53d413bb7741e5eba1a8067', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:08:49.009262', 'admin', NULL, 1, '[代码生成] 新增表定义 失败: StatementCallback; bad SQL grammar [CREATE TABLE "application" (
  id bigint NOT NULL PRIMARY KEY,
  "id" varchar(32) NOT NULL,
  "name" varchar(255),
  "logo_url" text,
  "link_url" varchar(500),
  "create_time" timestamp,
  create_by varchar(64),
  create_time timestamp,
  update_by varchar(64),
  update_time timestamp,
  deleted smallint DEFAULT 0
)]', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('cf9cd2f7358d4a518c875c5f8772c0d4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:13:22.681309', 'admin', NULL, 1, '[代码生成] 新增表定义 失败: StatementCallback; bad SQL grammar [CREATE TABLE "application" (
  id bigint NOT NULL PRIMARY KEY,
  "id" varchar(32) NOT NULL,
  "name" varchar(255),
  "logo_url" text,
  "link_url" varchar(500),
  "create_time" timestamp,
  create_by varchar(64),
  create_time timestamp,
  update_by varchar(64),
  update_time timestamp,
  deleted smallint DEFAULT 0
)]', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('7281191616624d56b6891fa4546eab71', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:13:44.787048', 'admin', NULL, 1, '[代码生成] 新增表定义 失败: StatementCallback; bad SQL grammar [CREATE TABLE "application" (
  id bigint NOT NULL PRIMARY KEY,
  "id" varchar(32) NOT NULL,
  "name" varchar(255),
  "logo_url" text,
  "link_url" varchar(500),
  "create_time" timestamp,
  create_by varchar(64),
  create_time timestamp,
  update_by varchar(64),
  update_time timestamp,
  deleted smallint DEFAULT 0
)]', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('23af9f9fc9ba4d1a94083b573857018a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:13:54.844236', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ecd9b3c6636b4009a9a347570f15fa2d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:13:54.866772', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('44b7631e8c9d40c7a6c229bf849aa6b6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:13:55.357478', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('61f90971ce1845e8b0f2090f46c6338c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:14:15.831917', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e3def0bcf8304d30a973dc7986ecbd88', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:14:16.109721', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0705c50c8de54f9cb66e26441529fe4d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:14:16.14029', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e651d0a7a8284e4aadb34378938ac496', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:14:16.256353', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('554e8875c7514d4a9c7517343c5a7213', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:14:18.599426', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('13273d112c3f4722a64bfc6b19fbc876', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:35:38.386295', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d48caf378abd400fb69e84ba27b8d7e7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:17:49.633519', 'admin', NULL, 1, '[代码生成] 新增表定义 失败: StatementCallback; bad SQL grammar [CREATE TABLE "application" (
  id bigint NOT NULL PRIMARY KEY,
  "id" varchar(32) NOT NULL,
  "name" varchar(255),
  create_by varchar(64),
  create_time timestamp,
  update_by varchar(64),
  update_time timestamp,
  deleted smallint DEFAULT 0
)]', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('101d461e2ad84488a366de0c58b062f3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:27:19.475446', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('10a8f7152f2f4f37966d016078a0b078', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:27:35.757929', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2fb4849f32a74b2593768c60c9622561', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:36:02.329292', 'admin', NULL, 1, '[代码生成] 新增表定义 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('856c61eeaa7049689d1dadcf6d6a8983', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:36:02.636957', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8eafef8c3c004145bd2283de10a8fb32', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:36:32.05817', 'admin', NULL, 4, '[定时任务] 查询任务列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7b91a23721dd4b5384888d52af175c3f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:40:20.173026', 'admin', NULL, 4, '[定时任务] 查询任务列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9f2016aa3a4f40c58fd0ecdea7e5bacd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:40:29.47685', 'admin', NULL, 4, '[定时任务] 查询任务列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8957aa544d4a4e55b71ce944ad4bd770', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:40:35.398746', 'admin', NULL, 4, '[定时任务] 查询任务列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4feb90e054a14951a69dd8f2b1486c95', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 18:40:39.009118', 'admin', NULL, 4, '[定时任务] 查询任务列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9c481b3c78e0453383ab6742a0c84c70', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 20:00:53.532492', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('97e1316628e84ff1aa029dc4a263b494', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 20:00:54.320748', 'admin', NULL, 4, '[定时任务] 查询任务列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f80d0dd55d36427ea02250e1a494dfb3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 20:00:54.852419', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3281dba81b44440fbe01f0fe708274e2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 20:01:01.428088', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('775ff388212b4aa78d4595ecfd3b2eaa', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 20:01:03.984164', 'admin', NULL, 4, '[定时任务] 查询任务列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bda36a31e98e4c14bdb266e72d3ad5ef', 'anonymousUser', '0:0:0:0:0:0:0:1', '2026-06-04 22:50:26.533192', 'anonymousUser', NULL, 4, '[认证管理] 获取用户信息 失败: Cannot invoke "com.management.entity.SysUser.getId()" because "user" is null', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('808477d2d93b4ee6bce7183a0afe5855', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 22:53:06.948412', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cd8bca48692649d1b9368d74b90764c7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 22:53:08.783821', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bd539da44b7243bea313416d96ab4ce6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 22:53:09.400569', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6958788608e14728a32c0ec0afd68721', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 22:53:09.529454', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('734a667c12064348a52ce75d05b40a72', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 22:53:14.931187', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c217c9c13f834db89e83b20c229831fe', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 22:53:15.989244', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('195f4b0012434d37beee5e431ea409e1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 22:53:16.661368', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('46fcc97be9cd4320ab08bee7b8c33bc4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 22:53:17.160834', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cde96b9a4cae4876b0268876f09a4a31', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 22:53:46.922093', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('86909fda99d645b1ac09847230b613e5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:08:26.27479', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d1df3138bbf3404293cc43196ea63ed8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:08:26.288321', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2c6d093626db463bad07186f874fb0a2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:08:26.662461', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('70359e53db4042f1a5784d1a6da1ad0a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:08:34.606879', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c40dbde5cf3442f8a1f05d7734890488', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:08:34.698682', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('47dbae5e1396478baa690685afdd4d6f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:08:36.957462', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('37f429ef0f60494e9a9dd5d175128294', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:08:37.201736', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('377d4fb068d24990a277b0f7f8fe4eef', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:08:37.433815', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('90d4dcbe7454483f922ae1888b436a0d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:08:37.457731', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('04a7282ef25f47bd984fe5871e735328', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:08:39.567028', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('93e6fc518c1d4e73a4b1774482a35f50', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:14:41.989855', 'admin', NULL, 2, '[代码生成] 修改表定义 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d9d6cdecdea64824ad6a7ba3b9d7906a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:14:42.228734', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('20df562ed75248ad93794a386f828ab3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:14:50.356892', 'admin', NULL, 9, '[代码生成] 预览代码 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e41970f40cf64112be1ed71ba7c7fd08', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:16:10.323582', 'admin', NULL, 2, '[代码生成] 修改表定义 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fc55b86e6a10428c93c37c8c103d9f6f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:16:10.526707', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4c609db0a1d94ef098eb791510afedb6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:16:56.547814', 'admin', NULL, 2, '[代码生成] 修改表定义 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('aa5428cc0a434d02a4be2b2d7098631a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:16:56.679219', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('54646ada1ac84bfc99e29a61d193a908', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:17:07.488686', 'admin', NULL, 9, '[代码生成] 生成代码 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8c250364419041c8b5a0dd76f3afa109', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:18:11.20772', 'admin', NULL, 9, '[代码生成] 预览代码 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1f2bb1bcbcd445edabcae089a9d8203e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:18:25.603796', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('60689791778241fabba77b943b50f51c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:18:29.163977', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('54bff6d73030455892c238e511af2e9c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:18:32.899082', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('53648b3141054aeb81fae37f8e3bfecf', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:18:37.200516', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8d71238a074b4eb2a5c6345d6f75b529', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:35:32.935987', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b6db83c114c14de3852946582facac66', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:35:38.483578', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a9963f451e5540dca9e2c79f4be6c76c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:37:57.58095', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9c7d5f7b8beb4c8e9a89f08e94b91267', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:38:04.954122', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('045b7b8f8c9c4a9197334ea0a95bc3de', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:39:10.830848', 'admin', NULL, 2, '[组织管理] 修改组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ae881085ff414e21a1cceac2e0d7010f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:39:11.018114', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('58fcef0bb11b48f9974618b639d70fc5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:41:19.251861', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ae58232833694817abec66bfaf5580d9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:42:57.1356', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a39dcacc682c42d1a71b3df1f0564fb5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:42:57.170027', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b429a2f51a11486d80f83dbec1cb575c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:42:57.276333', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a45b6eda120e4bd397c9f2c3fcc63bcb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:43:15.305327', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('08a01f1d0e3e4f07beedac4027a31cb9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:43:15.609534', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3cdec83b17bb40ef805b52fc563fc41a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:43:16.283304', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a593d53b02b4464095d00802de818ccc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:44:38.594559', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('65bebf759435446bb2529006dcc7aad7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:01.014207', 'admin', NULL, 3, '[菜单管理] 删除菜单 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('39328093fd9c40e58079d390952aac7c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:08.414731', 'admin', NULL, 3, '[菜单管理] 删除菜单 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c4b2b562daa94d2b820c8862191e5526', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:08.644529', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2d888e75679148ceaa674694c6440120', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:11.463324', 'admin', NULL, 3, '[菜单管理] 删除菜单 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('43de4624433d4aebbcce7432eabaf29b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:11.5948', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e49225d9e47e4ee5a7b112c6cb15e1a8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:14.293003', 'admin', NULL, 3, '[菜单管理] 删除菜单 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('97195e3ecdfd4c3ca63233820faf873c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:14.646204', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e2486f07cf02459eab968092087151fd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:18.460283', 'admin', NULL, 3, '[菜单管理] 删除菜单 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d554cec4666d425c8d6f1363286ae9fa', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:18.877749', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9d711f643b504287a01f189b86223a4e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:22.711861', 'admin', NULL, 3, '[菜单管理] 删除菜单 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cf5af3233b574eaaad34c909d6cb1c6d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:22.85361', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('defd45f30af44411afe78e93da60d012', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:45:27.030744', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('79d82f93b4724a04956c907832509d68', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:46:00.135026', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('03a385a3e6bb4dbbab798880e606e139', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:46:08.286494', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e5d0ff5f16304b7da5d58821b195183e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:46:11.104644', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9b7ff04150074bc1861dd0a5e4f43ad2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:46:15.395945', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fee888cae3f54f0b9ff795b89f2804fa', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:46:15.421218', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('89c89b5c4dfe4d029c0417cc332d3661', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:46:49.577759', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('070ac9c6fa1d4f318adea03098c0d403', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:47:09.672374', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('537f87d5feab47e29092fee75d69846c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:47:21.348251', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bfa9eb5c0fed408c832f8e57347de6f4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:47:21.861062', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5588eb030e2643f3b6059069802da0c7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:47:22.175121', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('640d6813bfd047399ad7d5c6303e13aa', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:47:26.45489', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d8220c30aaec468f8899148aba1e34ea', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:47:28.622331', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('39e3c85cd86a42b6acaf7b397b8ca464', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:48:24.413704', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0b6b4db19b024713acbdb26198b224a3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:51:41.606577', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('85027563f4b4407c96a49b1cc915bde0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:56:28.17269', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('45f507c8142e4539b90f6a061f560a95', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:56:28.19707', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4ae6c697a70f46fca8128ebbba2d0ab3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:56:28.327262', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0416e4103534416eaf24852e16599eb0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:56:33.345982', 'admin', NULL, 4, '[代码生成] 查询数据库表列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1b7aa27bb4214944942d716650fbc31a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:56:38.31259', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8d69e70ffc90446b89c94a12d5905d2f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:56:40.894798', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5759562a20a441ef83a417a829615367', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:56:43.113376', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dc1733c96361474e8e4d77a718d5af09', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:01.464196', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0426efecd3194d44bdcc6bf95f344065', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:03.701344', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ec4b8f5c85c840d8a5f20e6682b761e4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:05.698612', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2d61cfa5905f4959802f2aeade09a6b9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:05.815409', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('59264ad18fe24474929c0f746f33b803', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:16.967984', 'admin', NULL, 2, '[角色管理] 修改菜单权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7f75f3894d6148ba87f1599c8486330a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:17.234336', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7e1af093f1fb43b6881cf4203773f773', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:19.912519', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7a8a07403f6e4eb2a15b6ff28e07ce07', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:34.627632', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2cc3efc3681a4620946530711934f5a5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:34.785481', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('89d6f3926a604a49a09a5b91cd56c8a5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:36.314136', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9786cdde6aea48108f51c8f7c5cbfcfc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:40.816394', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0532886d7a38488c8a469b9543a8aa44', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:58:07.663215', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('addcc9f6188a447ea53e4903f2f0457f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:58:17.700966', 'admin', NULL, 2, '[角色管理] 修改菜单权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b92565cc301149509ef8962edcaed553', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:59:43.824692', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b9e77a89be2d458d9b77be27abe4ce81', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:59:45.781286', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('972a4dbbc6814884a5f1cdb02704750d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:59:47.125718', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c348ca1dcef447b3b4c3162ebebc3657', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:00:36.741449', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('993352c296be4b85b7e9178eb42de838', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:00:40.176225', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1a0516bccb0a43e29119c67c2294f92f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:23.17009', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d5a9ed4263f24cce85b44124f03e4280', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:34.281189', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f9a087aad524421d984061fa52f2f942', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:58:05.234415', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d7b5575c6bac4fab943aeec356304403', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:58:23.40696', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3e10b71138df430586cdb213295e6154', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:59:49.100555', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('62f3de17426549d5aac8bcc8588e5790', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:59:49.857871', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3d48a65ac2f1442bba15573d10a80d90', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:14.761992', 'admin', NULL, 2, '[菜单管理] 修改菜单 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5d82c9d39475456bb8854e3b28c932ac', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:14.880492', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('05673cd254bf49ae9575ea2629a43632', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:57:34.779684', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('89c704e6801d40bfaefa94933e1efda2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:58:07.650466', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('69fb4d0b11ad48a3bef4031c4c176daf', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:58:17.975638', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2df1709ab3e2499195ce4022dc2eafe3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:59:43.589266', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5cfa1534ff484ac4b6ae473e944c2fe7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:59:43.799426', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a73e58f81f33448a970c105870105ba2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:59:51.511928', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('af7091cb52a8442fb68583e3850df1ff', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:59:51.577275', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b9dc9f9d06cb46f69f83365e1d624066', 'admin', '0:0:0:0:0:0:0:1', '2026-06-04 23:59:56.744783', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7fd9a88be46f466fb01809879b8f741f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:00:38.837564', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5212fa336bb9493ebc42f715f409a1b9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:21.687663', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fa3c46e47fb4477bbb417022306bc094', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:23.141752', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('194304e39b0e42f198f9a2849c71066e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:29.732945', 'admin', NULL, 2, '[角色管理] 修改菜单权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f0d86d8a5da6434fb38fabb4f4cbfe89', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:30.180459', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cfe7f7abda6e4734b985f5167dc9fce0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:33.639841', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('932a9bee7d304cef90237cb504e0ab27', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:46.453782', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('26f9ab2a906b4d74830110f51f4d7ad3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:46.572324', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0ec18924a01e4992a049734eff1fe478', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:46.714759', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('70c6ef82dc234d0c8dfbca596f5a0bb2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:47.353531', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dfa3af66e980434b9b7399b1b7a2377b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:51.016409', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b1ea3285129e4a058186f7dcd05df7ae', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:01:58.861122', 'admin', NULL, 4, '[用户管理] 下载用户导入模板 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('338dbcaa86e24b2991cfb9e5fc28749b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:03:00.861398', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('82908216d3134e8bb91e9f6d079c6379', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:03:03.83925', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('abe13b78e07740c69245f97b71ca89bc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:03:09.427723', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('662005f4384e4eba8a9d34d80cc6c503', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:03:15.513029', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('caa28be99f5b418aa2daf18dd7d9d20c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:03:15.594272', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d1511adb1ffd44bea163660cf89c24cf', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:03:38.148827', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('828d97f32a084c9cb45b8b0d31898236', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 00:03:40.277787', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ac9ad857c86a447884e99746c907d0f9', 'anonymousUser', '0:0:0:0:0:0:0:1', '2026-06-05 14:54:22.910597', 'anonymousUser', NULL, 4, '[认证管理] 获取用户信息 失败: Cannot invoke "com.management.entity.SysUser.getId()" because "user" is null', 1, NULL);
INSERT INTO "public"."t_log" VALUES ('2c6ce38b32c0493587bfb4583e3b6f22', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 14:54:32.364294', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4716762cc3744824acd7c7a5c8b7cc78', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 14:54:32.721315', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('168aa1a35cfa4a27b66f16bec6c5816d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 14:54:32.894079', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ece0d42d9aca41b1988f7cbe97505431', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 14:54:32.944896', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7ab8136df7da495481a91b13e060a4a0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:04:49.247049', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6141859dfecf42668896c3f6ff4de7eb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:04:50.801079', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3a457d1a01f24b09b326462d3fd19a66', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:04:53.048957', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9927ecabce5341fab2603238132c30bf', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:12.227241', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5aba88eb1cf24d479a6e08a99d13275f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:19.410988', 'admin', NULL, 3, '[组织管理] 删除组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9e7dea70ca76485f99d77db0959be8d9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:19.677917', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1593e2fe3fa8464db20b8fbe952656ec', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:22.600716', 'admin', NULL, 3, '[组织管理] 删除组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('20371416322c45d789a2da74e4f4c4a7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:22.738054', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('68a1b8ed03cc497fb261e1a7d061b672', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:24.699674', 'admin', NULL, 3, '[组织管理] 删除组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e9381b54d26f42eb8a793a74ef0d23c4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:24.878042', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ebad7e39e4f94d7c95601ee6c524cce0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:27.049009', 'admin', NULL, 3, '[组织管理] 删除组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('31a4d0275ef64248ad3c631e7aeda068', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:27.204736', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4b4983d9e0e848409fb0b0aed8818946', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:50.758187', 'admin', NULL, 3, '[组织管理] 删除组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f308eb9effe24ec68ab3d063269ce453', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:50.944247', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9f7502c7c0bb4b9f9b26cedb6a7cba82', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:53.001169', 'admin', NULL, 3, '[组织管理] 删除组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6267cef992794bb2837aa03db7071aaf', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:53.132207', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4dc3d632b7d645a29052bcf207bae6b8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:55.093839', 'admin', NULL, 3, '[组织管理] 删除组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('71a4010c05d947bea042b6f57412e3e4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:05:55.255063', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a4f97eb1cde4467396c1326a194f6a64', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:06:29.339097', 'admin', NULL, 2, '[组织管理] 修改组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8826e763cfa34459aabaeadf643ca146', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:06:29.569669', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('be20c311b04f4629a6819e0df1dfcb17', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:06:49.899467', 'admin', NULL, 2, '[组织管理] 修改组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2c5c8a713e954021a62695cd54e60cc5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:06:50.042104', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('da97bbc7323842be83ad1a5d8f05ba19', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:07:07.149934', 'admin', NULL, 1, '[组织管理] 新增组织 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d012af36e4cb4e9b9f246981250c75c8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:07:33.036674', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('414332facad34090ac3436a790952016', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:08:29.208371', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('32dcfb0098bd4051baef53a52987295c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:08:43.36983', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('77293b616a644bdbb2e73222289143b1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:08:51.639366', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('60702a1190c44a16a7fbbfd6d997a129', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:09:13.011034', 'admin', NULL, 1, '[字典管理] 新增字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('48141ad3f18c48dbb17149a8842390fc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:09:13.166074', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('61dce265000741ab82b3eeb2f272073f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:09:27.362289', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7bffa0f585c74bc2b6b8f1f7c4e7116b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:09:29.502271', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bb5559e078cf436d8fab77f1c0132d25', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:10:36.681698', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('38546e1376f047c4a39791926d6e5b79', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:11:07.296434', 'admin', NULL, 2, '[字典管理] 修改字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('af32c4418ce34ad7aaebd0b39f252e49', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:11:17.088794', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('353ef060a8074f70a708bf9fcb55e1c1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:11:22.044105', 'admin', NULL, 3, '[参数设置] 删除参数 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('67d211dc6bc44522bc462b5fabb931a3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:11:22.158324', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a6568f03633e4e23be807b13060edb86', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:04.052961', 'admin', NULL, 3, '[参数设置] 删除参数 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0dd0afef338340ebb6095386c7eb22ab', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:04.231725', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e5e9b882609449378ccef1945199ddd3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:06.337179', 'admin', NULL, 3, '[参数设置] 删除参数 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ff96104149e040e0ad3420e846a9def8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:10.135415', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2afec44c45cf423b9892d20dde1f2e13', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:12.239757', 'admin', NULL, 3, '[参数设置] 删除参数 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5cc3b730ce984c4ea671ef05d55b9e28', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:12.387862', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f39a5bd8dc1944ad96838946546d3e9e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:22.520547', 'admin', NULL, 2, '[参数设置] 修改参数 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7fb1775206624d94ad64537815f01d36', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:22.733102', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('860ac212288e400a9e832ba3f5dacdd9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:43.395956', 'admin', NULL, 2, '[参数设置] 修改参数 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('180f05214aa741f7ba6369b5f57caa50', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:13:15.245183', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e897aeeea83348359ba5bc374d2f33bb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:13:21.721209', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9d4d5f53d42542d6b63764c2e69dad92', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:13:28.777587', 'admin', NULL, 3, '[通知公告] 删除公告 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8f66d9f9b524451f97b3c47bb65f84ca', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:13:47.308556', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dd8783d22a9045b490a138f8e753fee6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:13:50.126998', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3c4a6cef995f4e5eadc8e1d5cb02568b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:13:53.05252', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f0706d2d3bda4e17be37a1afc95d00a0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:14:03.6498', 'admin', NULL, 3, '[文件管理] 删除文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('874a7824360147a78356d056aba41f94', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:14:03.744687', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('db51488d8bdb4528982f10e6e352c72a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:14:14.612563', 'admin', NULL, 1, '[文件管理] 上传文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f43eabeb4e67404483022c00af85117f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:14:28.825919', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7cc20b13bb0647648b15dcd48b02e7b9', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:14:29.918421', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b8274f55d48b4f0c9a97ac45301a3131', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:14:33.959738', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('24d0b87c67ad4bf9ad1c5e2500415dea', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:16:17.548281', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('785a92608e784dee86cdff57a79e9b6c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:17:10.739639', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('61d9b1d38bce4a39a7ee3e5d1ff4b3a8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:17:11.095069', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b1750bc0f5944fd29c437169a783b1a0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:17:12.212955', 'admin', NULL, 4, '[文件管理] 下载文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a5da8a4be3ca4ad5ad7c3fa181edb655', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:18:05.477686', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a4192e82977e4cf492514d375532ed01', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:18:10.819654', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('044649de2ef3497cbb5c1fc3ddc4ad40', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:18:12.412822', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b80f9b8f939e4e319944c94c33c40c6d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:18:22.783357', 'admin', NULL, 4, '[文件管理] 下载文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2cfdb3636e3744078ec11d6ed66f1105', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:07:07.284871', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('219caabcea334db99ce2530a42e7ba94', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:07:28.180537', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5ea80dcbaec84c9e885334bc809f9215', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:08:44.813703', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a2c2f7c4949b45b997fef2bc8d0e0506', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:09:25.345334', 'admin', NULL, 1, '[字典管理] 新增字典类型 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fd17cfae5660412c8d1abe2a325b9c50', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:09:25.572275', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('81e3c0b4bdcb45d492eb3c0daea58a65', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:11:07.491569', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('065db1ed897c45e0a7f894a63782249e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:11:30.135327', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('58a429dadbf34c02838f145c21deaf59', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:11:40.332896', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c1fd31c7d0bc483ba667d5240ebba6a2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:06.641417', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('db7b381d46ce4e7eb47832c34079f94c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:15.190383', 'admin', NULL, 3, '[参数设置] 删除参数 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d5ef7a46a8b0446c8dc967cfc33800ab', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:15.329192', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a34c94ab2eab4118b20ebaaa2a9582e4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:43.577841', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8fe9a81597a74cb2ae7195a3ae55f316', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:13:28.952283', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f41a3dc0986b4137ab9e78ed72799f6a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:13:46.125357', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3e27b847506344799ead56b6eeab7085', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:13:54.241029', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d7df30e0598a42cb9ee0bd1da9a6db99', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:14:14.681234', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('558c26c56bfe4755beb60d706f23cabc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:14:37.178354', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5a18ce58ef7b44f8895fbe9b368cc2f6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:16:26.063002', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('972085cea99b4037a4a7c82417d21eae', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:17:10.702534', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8c98473b3d6d42119b6c72da499d098a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:18:05.233964', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0beb3f41a68748dabd190d00a6fe6b34', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:18:16.7293', 'admin', NULL, 1, '[文件管理] 上传文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a995fd4e54344e60b01d84d41b9179f2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:18:16.888122', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('942cf8b2fb5c4000b3157160ab0798f0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:08:50.440334', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('415162e53e3c4931af3f7f5e8fa42383', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:11:13.764746', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('33427a4eb9fe4b9b9b6da35a26986e98', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:12:09.908995', 'admin', NULL, 3, '[参数设置] 删除参数 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2997189a75044788816b3395c097ba32', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:13:15.058961', 'admin', NULL, 1, '[参数设置] 新增参数 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('55cbd8ca6aed497b92787855a914105a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:13:59.699316', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ddf78b8ea6464f9aa6c9d4a4983846ce', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:14:38.364553', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7248cf78db144f4aa0af73ca7768528d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:18:05.356126', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3fbec7f0de544b4c9b0dee14fae7e59f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:24:59.974184', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d0554195ed534d658fe5c3f624701b26', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:25:34.03856', 'admin', NULL, 3, '[文件管理] 删除文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c93e9f5408f147d0be16594c8a5ff2a7', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:25:34.153698', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('90e444400a97457d84094c18bf0b4798', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:25:36.310244', 'admin', NULL, 3, '[文件管理] 删除文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('81d4c47accac4c2f88e1bd4e192dff7f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:25:36.390268', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c3660eb86f2b49c3bf685e71ce7640fa', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:25:48.087658', 'admin', NULL, 1, '[文件管理] 上传文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dcc9ad176bf0444089d27d8da5702099', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:25:48.174299', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('590a389c6c394471a9a8ebb9c6ce2511', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:25:51.734595', 'admin', NULL, 4, '[文件管理] 下载文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4cdc6d236b374a7998c8e9f6fb12d6cf', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:26:22.997199', 'admin', NULL, 3, '[文件管理] 删除文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('707de09828b14a2bbf38de66c6f749ca', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:26:23.111516', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('78b595e3b9794f35aedb2238f35f4a79', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:26:53.23026', 'admin', NULL, 1, '[文件管理] 上传文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3e6244096e9242a4a04156103801f878', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:26:53.286036', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('06b81f354072445790fab91a329398ab', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:28:24.639651', 'admin', NULL, 1, '[文件管理] 上传文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('85093c50d7b14c8d8e72811ef8a396af', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:28:24.734776', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('9c34ee90cfc84b41b22c05d0aa5f22a0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:28:28.168812', 'admin', NULL, 4, '[文件管理] 下载文件 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('78119835349f481d981f3363fba0d72e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:28:53.833336', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d02aebd78e4f4940ae153677fb8e0fa2', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:28:54.796563', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7ddc94df47a94b99be53bf38470d9469', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:29:02.645562', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f3735e72bc6941debc89050016087a5f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:29:03.880382', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d67f77268aae4ad18316fb9c52ea3d9d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:29:07.565998', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d13b465ae791447c89e956589672e4d4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:29:17.304273', 'admin', NULL, 2, '[通知公告] 修改公告 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('85868d628c5243069af429709c1c7180', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:29:17.862433', 'admin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('778cd4acb37345e4a9a524d4bdb22447', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:29:22.016529', 'admin', NULL, 4, '[文件管理] 查询文件列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4eeb269ccd284ce388e47af8f2aa50cb', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:29:22.800106', 'admin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e7e144a8f1884b0396fad7b7c8cc287c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:29:23.677543', 'admin', NULL, 4, '[字典管理] 查询字典类型列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('38cfc1ba82ae42a6aea0145db13ee5da', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:29:24.416997', 'admin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0d6977eed83e4c49bb121b4b8f11fd49', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:29:25.700106', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6e9f5bd3730c444288ec76b32fd8396e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:08.602853', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4e6897d2f12944ef9bd65fc9dfa779a6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:11.099131', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3ebf8077f7b2469f948aea9738f97436', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:15.714991', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dee3937e444644418c84e17d92ad9da8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:16.42366', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7078062bd82c444e83e03a8a3c5c9a32', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:16.734113', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('27b20e85561d410db499312c6cf3df99', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:17.002127', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('44b242cc244a4db6b8efa4520ba8dbd1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:21.622083', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7b5494253061462ca7f35c7bc5b4cb80', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:22.430747', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('87696bea44864aaabc4c91a5dca4d157', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:22.697131', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('448468ff6fd4446d9875d36a02a20af3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:22.916757', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3d41fd6708944945830fbe90d2235659', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:23.292153', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8963c0f48bf94012a0bfe75f7f78a34a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:23.549024', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('6e8181bc2352419994691b08ab2d2f7f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:23.941984', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('606a31b3644c463e9882d993c292c057', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:24.090797', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('04cc92eb2f144e1c8a8fa4905c1938f1', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:30:27.033107', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4424864cf20b4de3984122435b127429', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:35:06.240266', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c767dcad64cd44eea2bb105f72edd1db', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:35:07.650279', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a041ac9b25d54195a5455643b55b6a46', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:35:08.468492', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0f0dc7214aee49ee9f8f6318a146cdd8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:37:19.830298', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ded2b52fd987489bafa74e958b9af39e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:37:24.908554', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a8d2e6a70e1f495bb2d5aef310f480c3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:37:29.10731', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('592a44129995428d9b45e5e2b414103b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:37:30.325736', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('457ab95df5434640bee841f666ddab40', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:37:36.780745', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('45e3ec6bae6b488e98e8c9114a2dbc0d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:38:07.586926', 'admin', NULL, 2, '[角色管理] 修改角色 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('72c40cf1d7a04c2abeec741ae9697b93', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:38:07.763448', 'admin', NULL, 2, '[角色管理] 修改数据权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('80d78bf612f64e9fa3cf5d6433017e69', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:38:11.056151', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bc0d4af294bb4e06a88c509dd5d4a99e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:38:24.296025', 'admin', NULL, 2, '[角色管理] 修改角色 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1fcc193d38aa4d1c9b7d60567035fb91', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:38:24.417456', 'admin', NULL, 2, '[角色管理] 修改数据权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1fc7de1fd3c044fbbcb602625ed6b866', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:38:24.664913', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f8a91fc516dd499988b9b359b3390f4b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:15.217287', 'admin', NULL, 2, '[角色管理] 修改角色 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('91be0913a2144a7499dcfd93b582073d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:15.321601', 'admin', NULL, 2, '[角色管理] 修改数据权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('d689ea4c9f024cd4b520debdb6145481', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:15.697538', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2bfe61a731404805b85de59513d5a9b0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:21.091442', 'admin', NULL, 2, '[角色管理] 修改角色 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ea5775456ae147cfb860bbd69fe7507e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:36.020748', 'admin', NULL, 1, '[角色管理] 新增角色 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b0dc84fb3b864205a4c7ac443b33d553', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:36.321185', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a40c1f18f3134890ad40f5cda1aa47c0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:36.44866', 'admin', NULL, 2, '[角色管理] 修改数据权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ef43a78f5ca8431fb0a79fb638bd69ae', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:36.617705', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c731ac3c86e643189522b002bef6b1a3', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:43.658367', 'admin', NULL, 3, '[角色管理] 删除角色 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a61b9d11d2d84556b2ebcb5967ec16af', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:43.863121', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('39df0bfd187f4cbcaf3f63251d57818d', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:47.617759', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c207040e6b454929a5bc6546cb9983c6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:40:48.665627', 'admin', NULL, 1, '[用户管理] 新增用户 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0f0d6fd7cf0e471390741a39df4116bd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:40:49.050559', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bab02c4dd688450eb3c8a94f48b35bad', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:40:56.170634', 'admin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0fe0da4a969e4165a99b20de48a731d0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:41:04.656708', 'admin', NULL, 2, '[用户管理] 修改用户 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a24bcd83cc584025a2f00e3f8cc627ee', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:41:04.974145', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dd2f10a79edf4f2ba6520d1263a058e8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:41:16.45173', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('72ffbe556da24e399549cbcf9a26f43f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:41:37.788298', 'admin', NULL, 2, '[角色管理] 修改菜单权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f5d063fe88ba4683bbad020c0d72ca2f', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:41:40.035315', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('62a9cda328274e2d856790175b6644b7', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:42:01.645707', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2c2b268ee52e48e7b74012bb06eef493', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:42:08.850748', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a5dbc240cb7e451e8f1f88095033444b', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:42:21.642671', 'wangbin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a9a880fc75e942869347387d9e874068', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:42:22.871642', 'wangbin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('3b93f4a2b06f417ead27b6617d47e2b6', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:42:25.602991', 'wangbin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('af248bd1b29c44a691d74f38a0671e25', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:42:44.290049', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('339281ec98134fd58d2251a84a3137a5', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:43:07.55526', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4a0efe8609a746beb8862f1777942804', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:43:08.028342', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4a7351fbf61c492d93f2d2d976b842ca', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:43:08.065584', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('17b6905d4e32419ebfa809f4cd9f0197', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:43:11.57594', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('869fd65284cf42cbb1b92a245a3b28c0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:43:59.155716', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bd4729c7bf7942398518cdd9ebe3173e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:46:31.768558', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('eefdf0d435d34cbfa43bc5e197921210', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:46:51.618446', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4a390d6e37ea4ddaa0a87a52e73455da', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:46:51.889458', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('60d3ed8ce37745d1b1e7386086ab0bef', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:47:20.553701', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('4570033278f144a8912b3a84cd098b42', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:47:51.788696', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('fe2b9c82de3d4c9fa670739228f2e760', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:47:57.891721', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('014cb15d2de44e528e04f94791177223', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:48:12.733189', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('894ff7a0c6864e89978d2d6d6de0a1f0', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:48:22.505806', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e7cde52b57b546b5971d500fb1db0ca4', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:48:23.572095', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('e506a85e6297430f9b08dc546fdbed1a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:48:23.991778', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('0761d2da25b142c09338b5cbc06eda51', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:38:08.441312', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c304b7f5296c48148ecad436e5a9629b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:38:11.005578', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a9e098eda1aa4e6995bbbc04d9f17070', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:21.184311', 'admin', NULL, 2, '[角色管理] 修改数据权限 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b815e167a520452584b5f0ef2808e02b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:21.427287', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f6d75b7a0a794e9a8711b69008573ff6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:39:56.224302', 'admin', NULL, 4, '[用户管理] 查询用户详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('100c1d3916d143cc93c03e8cdd15968c', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:41:18.044372', 'admin', NULL, 4, '[角色管理] 查询角色详情 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('95ad177e86d5421aa3c6502aa03422cd', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:41:18.081043', 'admin', NULL, 4, '[菜单管理] 查询菜单列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('96c8529afd604cdda249a6da0df3492b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:41:37.962986', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('18c8fbd91dfb443b8abd21b2685d6918', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:42:00.824483', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('25bdd250da1244ce9e302aea9f1dc329', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:42:01.484129', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7a830c8a5846428481dcb5e7b9125e34', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:42:10.855322', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('bccfc9c77cb14240bc1e8c4597cf0fb9', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:42:13.788064', 'wangbin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('490f6c5fc6904e50930ac14993bb5a32', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:42:18.536722', 'wangbin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('a4453c3c28fa49d291da3fede406348a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:43:07.830839', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b01e3c7e9c11483786aa5c581e8fb6fc', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:43:59.069612', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('835f409eb890435bb073d9628a5b7709', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:46:31.832838', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f2665342fbe84323b0d9e9f788d95a19', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:46:51.53155', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('39ffa54adf49414d9681229da66f29d6', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:46:52.026356', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('382f3defd6304de5a079508ff189fa37', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:47:20.683489', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('48ea1cee3afa4b29aafe1f4bd62cf565', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:47:22.08259', 'admin', NULL, 4, '[角色管理] 查询角色列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8f5eb32ca631493db9bd4a3ba41f3c25', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:47:22.139202', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f91c70f6eacf4199b2ef6b705768e67a', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:47:53.919111', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8796b7b65bbc44f39628d84bdbc7a308', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:47:56.747784', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('dffa936f41494a34a928f1e2d59ac64e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:48:08.370644', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c9607db399e442d98b39a073ae634a0e', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:48:09.987573', 'admin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('308a8575fdc647829941d3b3ad3094b8', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:48:12.226211', 'admin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b9df6edec21d431491590c515811c21b', 'admin', '0:0:0:0:0:0:0:1', '2026-06-05 15:48:21.168187', 'admin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('b7433b7b41a543c0b09907dfb50a3c37', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:52:09.611407', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('2c400dd55cd741bdb8dccd19663cbdc0', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:52:12.23001', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('c9932a5273314002aab453988306522e', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:52:12.382571', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('297ec3760f07406a813a554e609f044d', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:58:13.674088', 'wangbin', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('77d291ee9c70492fa227cc589a2aaea4', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:58:13.864359', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('ff52d745538a4b11b55fef7044d4e26b', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:58:13.951104', 'wangbin', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('8382e456f48a41bb8702b221d2b1ef32', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:58:22.637885', 'wangbin', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('beb162a371304a8f81f02c173f733b05', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:58:24.081537', 'wangbin', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7b47de8a30db44919086429dd1bef91e', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:58:28.551844', 'wangbin', NULL, 4, '[参数设置] 查询参数列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('1ec18649c60d4732958f7b0efab9f5a0', 'wangbin', '0:0:0:0:0:0:0:1', '2026-06-05 15:58:31.989604', 'wangbin', NULL, 4, '[通知公告] 查询公告列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('7e3a3fbbdd2e4caf81d30eedb4c2b342', 'zhangsan', '0:0:0:0:0:0:0:1', '2026-06-05 16:00:17.26872', 'zhangsan', NULL, 4, '[认证管理] 获取用户信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('5ac92d41b66d4a31b74ff901bd30a4db', 'zhangsan', '0:0:0:0:0:0:0:1', '2026-06-05 16:00:17.431949', 'zhangsan', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('f0f9f71336d649c0a74d123ecf485474', 'zhangsan', '0:0:0:0:0:0:0:1', '2026-06-05 16:00:17.505397', 'zhangsan', NULL, 4, '[认证管理] 获取路由信息 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('cab865499bbd487abcb9f958b2079a49', 'zhangsan', '0:0:0:0:0:0:0:1', '2026-06-05 16:00:19.921877', 'zhangsan', NULL, 4, '[用户管理] 查询用户列表 成功', 0, NULL);
INSERT INTO "public"."t_log" VALUES ('265015787b1046f090e22eb78d664ed1', 'zhangsan', '0:0:0:0:0:0:0:1', '2026-06-05 16:00:22.39756', 'zhangsan', NULL, 4, '[组织管理] 查询组织列表 成功', 0, NULL);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_user";
CREATE TABLE "public"."t_user" (
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "account_number" varchar(32) COLLATE "pg_catalog"."default",
  "nick_name" varchar(255) COLLATE "pg_catalog"."default",
  "real_name" varchar(255) COLLATE "pg_catalog"."default",
  "email" varchar(255) COLLATE "pg_catalog"."default",
  "department_id" varchar(32) COLLATE "pg_catalog"."default",
  "add_time" timestamp(6),
  "login_time" timestamp(6),
  "activate_status" varchar(16) COLLATE "pg_catalog"."default",
  "password" varchar(256) COLLATE "pg_catalog"."default",
  "unit_id" varchar(32) COLLATE "pg_catalog"."default",
  "phone_number" varchar(255) COLLATE "pg_catalog"."default",
  "duty" varchar(255) COLLATE "pg_catalog"."default",
  "salt" varchar(255) COLLATE "pg_catalog"."default",
  "password_level" int2,
  "sfzhm" varchar(60) COLLATE "pg_catalog"."default",
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "deleted" int4 DEFAULT 0,
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."t_user"."id" IS '唯一标识';
COMMENT ON COLUMN "public"."t_user"."account_number" IS '账号';
COMMENT ON COLUMN "public"."t_user"."nick_name" IS '用户昵称';
COMMENT ON COLUMN "public"."t_user"."real_name" IS '真实姓名';
COMMENT ON COLUMN "public"."t_user"."email" IS '邮箱';
COMMENT ON COLUMN "public"."t_user"."department_id" IS '部门';
COMMENT ON COLUMN "public"."t_user"."add_time" IS '添加时间';
COMMENT ON COLUMN "public"."t_user"."login_time" IS '最后登录时间';
COMMENT ON COLUMN "public"."t_user"."activate_status" IS '激活状态，0禁用，1正常';
COMMENT ON COLUMN "public"."t_user"."password" IS '密码';
COMMENT ON COLUMN "public"."t_user"."unit_id" IS '单位编号';
COMMENT ON COLUMN "public"."t_user"."phone_number" IS '手机号';
COMMENT ON COLUMN "public"."t_user"."duty" IS '职务';
COMMENT ON COLUMN "public"."t_user"."salt" IS '密码盐值';
COMMENT ON COLUMN "public"."t_user"."password_level" IS '密码级别';
COMMENT ON COLUMN "public"."t_user"."sfzhm" IS '身份证号码';
COMMENT ON TABLE "public"."t_user" IS '用户表';

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO "public"."t_user" VALUES ('4e88cf6b95ad496192aff19ce943dafc', 'wangbin', 'wangbin', NULL, '', '4fc7da548c4b4b61b22b90cbe1fabecd', NULL, NULL, '1', '$2a$10$i.O.bznXxcwf1iHgz27eiefi5SB2pd.oySsIspDEH.qc9S218.XY6', NULL, '18322678900', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO "public"."t_user" VALUES ('7c077c41f8f14799bf893b109cfd1c3c', 'zhangsan', 'zhangsan', '管理员', '', '4fc7da548c4b4b61b22b90cbe1fabecd', '2026-06-05 15:40:48.637196', NULL, '1', '$2a$10$hUDQbfLa593YyLTVciAMl.15Wrz7nl2gDticzC9zSlZWAUSRK2KxW', NULL, '18322695060', '部门管理员', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO "public"."t_user" VALUES ('7acc64c6e6e54eae9eb883adc5f887b5', 'admin', '管理员', '管理员', '222781830012@qq.com', 'd8de3dbfe6604088a32f954e8573acdf', '2020-05-31 09:11:12.982', '2026-06-02 09:29:35.57', '1', '$2a$10$hdhZQJMWebflSWIMRPjR1.VSWul/8MUh8E9MkZ9YRUJIsj5Q6FEVW', NULL, '18322456789', '部门管理员', NULL, 4, NULL, NULL, NULL, NULL, 0, NULL);

-- ----------------------------
-- Indexes structure for table organization
-- ----------------------------
CREATE UNIQUE INDEX "idindex" ON "public"."organization" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "org_nameindex" ON "public"."organization" USING btree (
  "org_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "remark" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table organization
-- ----------------------------
ALTER TABLE "public"."organization" ADD CONSTRAINT "organization_copy1_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table role
-- ----------------------------
CREATE INDEX "idx_role_deleted" ON "public"."role" USING btree (
  "deleted" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_role_role_code" ON "public"."role" USING btree (
  "role_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table role
-- ----------------------------
ALTER TABLE "public"."role" ADD CONSTRAINT "role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table role_menu
-- ----------------------------
ALTER TABLE "public"."role_menu" ADD CONSTRAINT "role_menu_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table role_user
-- ----------------------------
ALTER TABLE "public"."role_user" ADD CONSTRAINT "role_user_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table sys_config
-- ----------------------------
ALTER TABLE "public"."sys_config" ADD CONSTRAINT "sys_config_config_key_key" UNIQUE ("config_key");

-- ----------------------------
-- Primary Key structure for table sys_config
-- ----------------------------
ALTER TABLE "public"."sys_config" ADD CONSTRAINT "sys_config_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_dict_data
-- ----------------------------
CREATE INDEX "idx_sys_dict_data_dict_type" ON "public"."sys_dict_data" USING btree (
  "dict_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_dict_data
-- ----------------------------
ALTER TABLE "public"."sys_dict_data" ADD CONSTRAINT "sys_dict_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table sys_dict_type
-- ----------------------------
ALTER TABLE "public"."sys_dict_type" ADD CONSTRAINT "sys_dict_type_dict_type_key" UNIQUE ("dict_type");

-- ----------------------------
-- Primary Key structure for table sys_dict_type
-- ----------------------------
ALTER TABLE "public"."sys_dict_type" ADD CONSTRAINT "sys_dict_type_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_file
-- ----------------------------
CREATE INDEX "idx_sys_file_md5" ON "public"."sys_file" USING btree (
  "md5" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_file
-- ----------------------------
ALTER TABLE "public"."sys_file" ADD CONSTRAINT "sys_file_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_login_log
-- ----------------------------
CREATE INDEX "idx_sys_login_log_account_number" ON "public"."sys_login_log" USING btree (
  "account_number" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_login_log_login_time" ON "public"."sys_login_log" USING btree (
  "login_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_login_log_status" ON "public"."sys_login_log" USING btree (
  "login_status" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_login_log_user_id" ON "public"."sys_login_log" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_login_log
-- ----------------------------
ALTER TABLE "public"."sys_login_log" ADD CONSTRAINT "sys_login_log_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_menu
-- ----------------------------
CREATE INDEX "idx_sys_menu_parent_id" ON "public"."sys_menu" USING btree (
  "parent_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_menu_perms" ON "public"."sys_menu" USING btree (
  "perms" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_menu_status" ON "public"."sys_menu" USING btree (
  "status" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_menu
-- ----------------------------
ALTER TABLE "public"."sys_menu" ADD CONSTRAINT "sys_menu_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_notice
-- ----------------------------
CREATE INDEX "idx_sys_notice_create_time" ON "public"."sys_notice" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_notice_status" ON "public"."sys_notice" USING btree (
  "status" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_notice
-- ----------------------------
ALTER TABLE "public"."sys_notice" ADD CONSTRAINT "sys_notice_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_log
-- ----------------------------
CREATE INDEX "idx_t_log_account_number" ON "public"."t_log" USING btree (
  "account_number" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_t_log_is_error" ON "public"."t_log" USING btree (
  "is_error" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_log
-- ----------------------------
ALTER TABLE "public"."t_log" ADD CONSTRAINT "loginlog_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_user
-- ----------------------------
CREATE INDEX "idx_t_user_activate_status" ON "public"."t_user" USING btree (
  "activate_status" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_t_user_deleted" ON "public"."t_user" USING btree (
  "deleted" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_user
-- ----------------------------
ALTER TABLE "public"."t_user" ADD CONSTRAINT "t_user_pkey" PRIMARY KEY ("id");
