package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.management.common.PageResult;
import com.management.dto.user.*;
import com.management.entity.Organization;
import com.management.entity.SysUser;
import com.management.mapper.OrganizationMapper;
import com.management.mapper.SysUserMapper;
import com.management.security.DataScopeHelper;
import com.management.service.IRoleUserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.util.ReflectionTestUtils;

import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("SysUserServiceImpl 单元测试")
class SysUserServiceImplTest {

    @Mock
    private SysUserMapper sysUserMapper;

    @Mock
    private PasswordEncoder passwordEncoder;

    @Mock
    private IRoleUserService roleUserService;

    @Mock
    private OrganizationMapper organizationMapper;

    @Mock
    private DataScopeHelper dataScopeHelper;

    @Spy
    @InjectMocks
    private SysUserServiceImpl userService;

    private SysUser testUser;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(userService, "baseMapper", sysUserMapper);

        when(passwordEncoder.encode(anyString())).thenReturn("encoded-pass");
        when(dataScopeHelper.getEffectiveDataScope()).thenReturn("1");

        testUser = new SysUser();
        testUser.setId("u-001");
        testUser.setAccountNumber("testuser");
        testUser.setNickName("测试用户");
        testUser.setEmail("test@example.com");
        testUser.setPhoneNumber("13800138000");
        testUser.setPassword("encoded-pass");
        testUser.setActivateStatus("1");
        testUser.setDepartmentId("dept-001");
        testUser.setAddTime(LocalDateTime.now());
    }

    @Nested
    @DisplayName("查询测试")
    class QueryTests {

        @Test
        @DisplayName("根据账号查询用户 - 返回用户")
        void selectUserByAccountNumber_ShouldReturnUser() {
            when(sysUserMapper.selectOne(any(LambdaQueryWrapper.class), anyBoolean())).thenReturn(testUser);

            SysUser result = userService.selectUserByAccountNumber("testuser");

            assertThat(result).isNotNull();
            assertThat(result.getAccountNumber()).isEqualTo("testuser");
        }

        @Test
        @DisplayName("根据账号查询用户 - 不存在返回 null")
        void selectUserByAccountNumber_ShouldReturnNull_WhenNotFound() {
            when(sysUserMapper.selectOne(any(LambdaQueryWrapper.class), anyBoolean())).thenReturn(null);

            SysUser result = userService.selectUserByAccountNumber("nonexistent");

            assertThat(result).isNull();
        }

        @Test
        @DisplayName("分页查询用户列表")
        void pageUsers_ShouldReturnPagedResults() {
            Page<SysUser> resultPage = new Page<>(1, 10);
            resultPage.setRecords(List.of(testUser));
            resultPage.setTotal(1L);
            when(sysUserMapper.selectPage(any(Page.class), any(LambdaQueryWrapper.class)))
                    .thenReturn(resultPage);
            when(roleUserService.getRoleIdsByUserId("u-001")).thenReturn(List.of("role-1"));
            Organization org = new Organization();
            org.setOrgName("测试部门");
            when(organizationMapper.selectById("dept-001")).thenReturn(org);

            UserQueryDTO query = new UserQueryDTO();
            PageResult<UserVO> result = userService.pageUsers(query);

            assertThat(result).isNotNull();
            assertThat(result.getTotal()).isEqualTo(1L);
            assertThat(result.getRows()).hasSize(1);
            UserVO vo = result.getRows().get(0);
            assertThat(vo.getAccountNumber()).isEqualTo("testuser");
            assertThat(vo.getDeptName()).isEqualTo("测试部门");
            assertThat(vo.getRoleIds()).containsExactly("role-1");
        }

        @Test
        @DisplayName("根据ID查询用户 - 返回 UserVO")
        void getUserById_ShouldReturnUserVO() {
            when(sysUserMapper.selectById("u-001")).thenReturn(testUser);
            when(roleUserService.getRoleIdsByUserId("u-001")).thenReturn(List.of("role-1"));

            UserVO result = userService.getUserById("u-001");

            assertThat(result).isNotNull();
            assertThat(result.getId()).isEqualTo("u-001");
            assertThat(result.getRoleIds()).containsExactly("role-1");
        }

        @Test
        @DisplayName("根据ID查询用户 - 不存在返回 null")
        void getUserById_ShouldReturnNull_WhenNotFound() {
            when(sysUserMapper.selectById("nonexistent")).thenReturn(null);

            UserVO result = userService.getUserById("nonexistent");

            assertThat(result).isNull();
        }
    }

    @Nested
    @DisplayName("创建测试")
    class CreateTests {

        @Test
        @DisplayName("创建用户成功")
        void createUser_ShouldSaveSuccessfully() {
            when(sysUserMapper.selectOne(any(LambdaQueryWrapper.class), anyBoolean())).thenReturn(null);
            when(sysUserMapper.insert(any(SysUser.class))).thenReturn(1);

            UserCreateDTO dto = new UserCreateDTO();
            dto.setAccountNumber("newuser");
            dto.setNickName("新用户");
            dto.setPassword("123456");
            dto.setRoleIds(List.of("role-1", "role-2"));

            userService.createUser(dto);

            ArgumentCaptor<SysUser> userCaptor = ArgumentCaptor.forClass(SysUser.class);
            verify(sysUserMapper).insert(userCaptor.capture());
            SysUser savedUser = userCaptor.getValue();
            assertThat(savedUser.getAccountNumber()).isEqualTo("newuser");
            assertThat(savedUser.getNickName()).isEqualTo("新用户");
            assertThat(savedUser.getPassword()).isEqualTo("encoded-pass");
            assertThat(savedUser.getActivateStatus()).isEqualTo("1");
            assertThat(savedUser.getId()).isNotNull().isNotEmpty();
            assertThat(savedUser.getAddTime()).isNotNull();
            verify(passwordEncoder).encode("123456");
            verify(roleUserService).updateUserRoles(anyString(), eq(List.of("role-1", "role-2")));
        }

        @Test
        @DisplayName("创建用户 - 账号已存在抛异常")
        void createUser_ShouldThrowException_WhenAccountExists() {
            when(sysUserMapper.selectOne(any(LambdaQueryWrapper.class), anyBoolean())).thenReturn(testUser);

            UserCreateDTO dto = new UserCreateDTO();
            dto.setAccountNumber("testuser");
            dto.setNickName("新用户");
            dto.setPassword("123456");

            assertThatThrownBy(() -> userService.createUser(dto))
                    .isInstanceOf(RuntimeException.class)
                    .hasMessage("用户名已存在");
            verify(sysUserMapper, never()).insert(any());
        }

        @Test
        @DisplayName("创建用户 - 无角色 IDs")
        void createUser_WithoutRoleIds_ShouldNotUpdateRoles() {
            when(sysUserMapper.selectOne(any(LambdaQueryWrapper.class), anyBoolean())).thenReturn(null);
            when(sysUserMapper.insert(any(SysUser.class))).thenReturn(1);

            UserCreateDTO dto = new UserCreateDTO();
            dto.setAccountNumber("newuser");
            dto.setNickName("新用户");
            dto.setPassword("123456");

            userService.createUser(dto);

            verify(sysUserMapper).insert(any());
            verify(roleUserService, never()).updateUserRoles(anyString(), any());
        }
    }

    @Nested
    @DisplayName("更新测试")
    class UpdateTests {

        @Test
        @DisplayName("更新用户成功")
        void updateUser_ShouldUpdateSuccessfully() {
            when(sysUserMapper.selectById("u-001")).thenReturn(testUser);
            when(sysUserMapper.updateById(any(SysUser.class))).thenReturn(1);

            UserUpdateDTO dto = new UserUpdateDTO();
            dto.setId("u-001");
            dto.setNickName("更新昵称");
            dto.setEmail("updated@example.com");
            dto.setRoleIds(List.of("role-1"));

            userService.updateUser(dto);

            verify(sysUserMapper).updateById(any(SysUser.class));
            verify(roleUserService).updateUserRoles("u-001", List.of("role-1"));
        }

        @Test
        @DisplayName("更新用户 - 不存在抛异常")
        void updateUser_ShouldThrowException_WhenUserNotFound() {
            when(sysUserMapper.selectById("nonexistent")).thenReturn(null);

            UserUpdateDTO dto = new UserUpdateDTO();
            dto.setId("nonexistent");
            dto.setNickName("更新昵称");

            assertThatThrownBy(() -> userService.updateUser(dto))
                    .isInstanceOf(RuntimeException.class)
                    .hasMessage("用户不存在");
            verify(sysUserMapper, never()).updateById(any());
        }
    }

    @Nested
    @DisplayName("删除测试")
    class DeleteTests {

        @Test
        @DisplayName("删除用户成功")
        void deleteUsers_ShouldDeleteSuccessfully() {
            doReturn(true).when(userService).removeById("u-001");
            doReturn(true).when(userService).removeById("u-002");

            userService.deleteUsers(List.of("u-001", "u-002"));

            verify(roleUserService).deleteByUserId("u-001");
            verify(roleUserService).deleteByUserId("u-002");
        }

        @Test
        @DisplayName("不允许删除超级管理员")
        void deleteUsers_ShouldThrowException_ForSuperAdmin() {
            assertThatThrownBy(() -> userService.deleteUsers(
                    List.of("7acc64c6e6e54eae9eb883adc5f887b5")))
                    .isInstanceOf(RuntimeException.class)
                    .hasMessage("不允许删除超级管理员");
            verify(userService, never()).removeById(anyString());
        }
    }

    @Nested
    @DisplayName("其他操作测试")
    class OtherTests {

        @Test
        @DisplayName("重置密码 - 应编码并更新")
        void resetPassword_ShouldEncodeAndUpdate() {
            when(sysUserMapper.updateById(any(SysUser.class))).thenReturn(1);

            userService.resetPassword("u-001", "newpass123");

            ArgumentCaptor<SysUser> captor = ArgumentCaptor.forClass(SysUser.class);
            verify(sysUserMapper).updateById(captor.capture());
            SysUser updated = captor.getValue();
            assertThat(updated.getId()).isEqualTo("u-001");
            assertThat(updated.getPassword()).isEqualTo("encoded-pass");
            verify(passwordEncoder).encode("newpass123");
        }

        @Test
        @DisplayName("修改状态")
        void changeStatus_ShouldUpdateStatus() {
            when(sysUserMapper.updateById(any(SysUser.class))).thenReturn(1);

            userService.changeStatus("u-001", "0");

            ArgumentCaptor<SysUser> captor = ArgumentCaptor.forClass(SysUser.class);
            verify(sysUserMapper).updateById(captor.capture());
            SysUser updated = captor.getValue();
            assertThat(updated.getId()).isEqualTo("u-001");
            assertThat(updated.getActivateStatus()).isEqualTo("0");
        }
    }
}
