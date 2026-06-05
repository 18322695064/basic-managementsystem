package com.management.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.management.common.PageResult;
import com.management.dto.user.*;
import com.management.mapper.OrganizationMapper;
import com.management.service.ISysUserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@DisplayName("SysUserController MockMvc 测试")
class SysUserControllerMockTest {

    private MockMvc mockMvc;
    private final ObjectMapper objectMapper;

    private ISysUserService userService;
    private OrganizationMapper organizationMapper;
    private PasswordEncoder passwordEncoder;

    private UserVO testUserVO;

    {
        objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
    }

    @BeforeEach
    void setUp() {
        userService = mock(ISysUserService.class);
        organizationMapper = mock(OrganizationMapper.class);
        passwordEncoder = mock(PasswordEncoder.class);

        SysUserController controller = new SysUserController(userService, organizationMapper, passwordEncoder);
        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        testUserVO = new UserVO();
        testUserVO.setId("u-001");
        testUserVO.setAccountNumber("testuser");
        testUserVO.setNickName("测试用户");
        testUserVO.setEmail("test@example.com");
        testUserVO.setPhoneNumber("13800138000");
        testUserVO.setActivateStatus("1");
        testUserVO.setAddTime(LocalDateTime.of(2025, 1, 1, 10, 0));
    }

    @Nested
    @DisplayName("查询用户")
    class QueryTests {

        @Test
        @DisplayName("GET /list - 分页查询用户列表")
        void list_ShouldReturnPagedUsers() throws Exception {
            PageResult<UserVO> pageResult = new PageResult<>(1L, List.of(testUserVO));
            when(userService.pageUsers(any(UserQueryDTO.class))).thenReturn(pageResult);

            mockMvc.perform(get("/system/user/list")
                            .param("pageNum", "1")
                            .param("pageSize", "10"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(200))
                    .andExpect(jsonPath("$.data.total").value(1))
                    .andExpect(jsonPath("$.data.rows[0].id").value("u-001"))
                    .andExpect(jsonPath("$.data.rows[0].accountNumber").value("testuser"));
        }

        @Test
        @DisplayName("GET /{userId} - 查询用户详情")
        void getInfo_ShouldReturnUserDetail() throws Exception {
            when(userService.getUserById("u-001")).thenReturn(testUserVO);

            mockMvc.perform(get("/system/user/u-001"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(200))
                    .andExpect(jsonPath("$.data.id").value("u-001"))
                    .andExpect(jsonPath("$.data.nickName").value("测试用户"));
        }

        @Test
        @DisplayName("GET /{userId} - 用户不存在返回错误")
        void getInfo_ShouldReturnError_WhenUserNotFound() throws Exception {
            when(userService.getUserById("nonexistent")).thenReturn(null);

            mockMvc.perform(get("/system/user/nonexistent"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(500))
                    .andExpect(jsonPath("$.msg").value("用户不存在"));
        }
    }

    @Nested
    @DisplayName("新增用户")
    class CreateTests {

        @Test
        @DisplayName("POST / - 创建用户成功")
        void add_ShouldCreateUser() throws Exception {
            doNothing().when(userService).createUser(any(UserCreateDTO.class));

            String body = objectMapper.writeValueAsString(Map.of(
                    "accountNumber", "newuser",
                    "nickName", "新用户",
                    "password", "pass123",
                    "roleIds", List.of("r-1")
            ));

            mockMvc.perform(post("/system/user")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(200));

            verify(userService).createUser(any(UserCreateDTO.class));
        }

        @Test
        @DisplayName("POST / - 创建用户失败 - 用户名已存在")
        void add_ShouldReturnError_WhenAccountExists() throws Exception {
            doThrow(new RuntimeException("用户名已存在"))
                    .when(userService).createUser(any(UserCreateDTO.class));

            String body = objectMapper.writeValueAsString(Map.of(
                    "accountNumber", "existing",
                    "nickName", "新用户",
                    "password", "pass123"
            ));

            mockMvc.perform(post("/system/user")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(500))
                    .andExpect(jsonPath("$.msg").value("用户名已存在"));
        }
    }

    @Nested
    @DisplayName("修改用户")
    class UpdateTests {

        @Test
        @DisplayName("PUT / - 修改用户成功")
        void edit_ShouldUpdateUser() throws Exception {
            doNothing().when(userService).updateUser(any(UserUpdateDTO.class));

            String body = objectMapper.writeValueAsString(Map.of(
                    "id", "u-001",
                    "nickName", "更新昵称"
            ));

            mockMvc.perform(put("/system/user")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(200));

            verify(userService).updateUser(any(UserUpdateDTO.class));
        }
    }

    @Nested
    @DisplayName("删除用户")
    class DeleteTests {

        @Test
        @DisplayName("DELETE /{userIds} - 删除用户成功")
        void remove_ShouldDeleteUsers() throws Exception {
            doNothing().when(userService).deleteUsers(anyList());

            mockMvc.perform(delete("/system/user/u-001,u-002"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(200));

            verify(userService).deleteUsers(eq(List.of("u-001", "u-002")));
        }

        @Test
        @DisplayName("DELETE /{userIds} - 删除超级管理员失败")
        void remove_ShouldReturnError_ForSuperAdmin() throws Exception {
            doThrow(new RuntimeException("不允许删除超级管理员"))
                    .when(userService).deleteUsers(anyList());

            mockMvc.perform(delete("/system/user/7acc64c6e6e54eae9eb883adc5f887b5"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.msg").value("不允许删除超级管理员"));
        }
    }

    @Nested
    @DisplayName("重置密码")
    class ResetPwdTests {

        @Test
        @DisplayName("PUT /resetPwd - 重置密码成功")
        void resetPwd_ShouldResetPassword() throws Exception {
            doNothing().when(userService).resetPassword(eq("u-001"), eq("newpass"));

            String body = objectMapper.writeValueAsString(Map.of(
                    "userId", "u-001",
                    "password", "newpass"
            ));

            mockMvc.perform(put("/system/user/resetPwd")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(200));
        }

        @Test
        @DisplayName("PUT /resetPwd - 新密码为空返回错误")
        void resetPwd_ShouldReturnError_WhenPasswordEmpty() throws Exception {
            String body = objectMapper.writeValueAsString(Map.of(
                    "userId", "u-001",
                    "password", ""
            ));

            mockMvc.perform(put("/system/user/resetPwd")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(500))
                    .andExpect(jsonPath("$.msg").value("新密码不能为空"));
        }
    }

    @Nested
    @DisplayName("修改状态")
    class ChangeStatusTests {

        @Test
        @DisplayName("PUT /changeStatus - 修改状态成功")
        void changeStatus_ShouldUpdateStatus() throws Exception {
            doNothing().when(userService).changeStatus(eq("u-001"), eq("0"));

            String body = objectMapper.writeValueAsString(Map.of(
                    "userId", "u-001",
                    "status", "0"
            ));

            mockMvc.perform(put("/system/user/changeStatus")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(200));
        }
    }

    @Nested
    @DisplayName("导出CSV")
    class ExportTests {

        @Test
        @DisplayName("GET /export - 导出用户 CSV")
        void export_ShouldReturnCsvFile() throws Exception {
            PageResult<UserVO> pageResult = new PageResult<>(1L, List.of(testUserVO));
            when(userService.pageUsers(any(UserQueryDTO.class))).thenReturn(pageResult);

            mockMvc.perform(get("/system/user/export"))
                    .andExpect(status().isOk())
                    .andExpect(header().string("Content-Disposition", "attachment; filename=users.csv"))
                    .andExpect(content().contentType("text/csv; charset=UTF-8"));
        }
    }
}
