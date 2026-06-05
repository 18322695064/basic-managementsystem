package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.management.common.PageResult;
import com.management.dto.role.*;
import com.management.entity.Role;
import com.management.entity.RoleUser;
import com.management.mapper.RoleMapper;
import com.management.mapper.RoleUserMapper;
import com.management.security.UserDetailsServiceImpl;
import com.management.service.IRoleMenuService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.test.util.ReflectionTestUtils;

import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("RoleServiceImpl 单元测试")
class RoleServiceImplTest {

    @Mock
    private RoleMapper roleMapper;

    @Mock
    private RoleUserMapper roleUserMapper;

    @Mock
    private IRoleMenuService roleMenuService;

    @Mock
    private UserDetailsServiceImpl userDetailsService;

    @Spy
    @InjectMocks
    private RoleServiceImpl roleService;

    private Role testRole;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(roleService, "baseMapper", roleMapper);

        testRole = new Role();
        testRole.setId("r-001");
        testRole.setRoleName("管理员");
        testRole.setRoleCode("admin");
        testRole.setRoleType("1");
        testRole.setRoleSystem("1");
        testRole.setDataScope("1");
        testRole.setRemarks("系统管理员");
        testRole.setCreateTime(LocalDateTime.now());
    }

    @Nested
    @DisplayName("分页查询")
    class PageTests {

        @Test
        @DisplayName("分页查询角色列表")
        void pageRoles_ShouldReturnPagedResults() {
            Page<Role> resultPage = new Page<>(1, 10);
            resultPage.setRecords(List.of(testRole));
            resultPage.setTotal(1L);
            when(roleMapper.selectPage(any(Page.class), any(LambdaQueryWrapper.class)))
                    .thenReturn(resultPage);

            RoleQueryDTO query = new RoleQueryDTO();
            PageResult<RoleVO> result = roleService.pageRoles(query);

            assertThat(result).isNotNull();
            assertThat(result.getTotal()).isEqualTo(1L);
            assertThat(result.getRows()).hasSize(1);
            RoleVO vo = result.getRows().get(0);
            assertThat(vo.getRoleName()).isEqualTo("管理员");
            assertThat(vo.getRoleCode()).isEqualTo("admin");
        }
    }

    @Nested
    @DisplayName("查询详情")
    class GetByIdTests {

        @Test
        @DisplayName("根据ID查询角色 - 返回 RoleVO")
        void getRoleById_ShouldReturnRoleVO() {
            when(roleMapper.selectById("r-001")).thenReturn(testRole);
            when(roleMenuService.getMenuIdsByRoleId("r-001")).thenReturn(List.of(1L, 2L));

            RoleVO result = roleService.getRoleById("r-001");

            assertThat(result).isNotNull();
            assertThat(result.getId()).isEqualTo("r-001");
            assertThat(result.getMenuIds()).containsExactly(1L, 2L);
        }

        @Test
        @DisplayName("根据ID查询角色 - 不存在返回 null")
        void getRoleById_ShouldReturnNull_WhenNotFound() {
            when(roleMapper.selectById("nonexistent")).thenReturn(null);

            RoleVO result = roleService.getRoleById("nonexistent");

            assertThat(result).isNull();
        }
    }

    @Nested
    @DisplayName("新增角色")
    class CreateTests {

        @Test
        @DisplayName("新增角色成功")
        void addRole_ShouldSaveSuccessfully() {
            when(roleMapper.insert(any(Role.class))).thenReturn(1);

            RoleCreateDTO dto = new RoleCreateDTO();
            dto.setRoleName("测试角色");
            dto.setRoleCode("test_role");
            dto.setMenuIds(List.of(1L, 2L));

            roleService.addRole(dto);

            verify(roleMapper).insert(any(Role.class));
            verify(roleMenuService).saveRoleMenus(anyString(), eq(List.of(1L, 2L)));
        }

        @Test
        @DisplayName("新增角色 - 无菜单 IDs")
        void addRole_WithoutMenuIds_ShouldNotSaveMenus() {
            when(roleMapper.insert(any(Role.class))).thenReturn(1);

            RoleCreateDTO dto = new RoleCreateDTO();
            dto.setRoleName("测试角色");
            dto.setRoleCode("test_role");

            roleService.addRole(dto);

            verify(roleMapper).insert(any(Role.class));
            verify(roleMenuService, never()).saveRoleMenus(anyString(), any());
        }
    }

    @Nested
    @DisplayName("更新角色")
    class UpdateTests {

        @Test
        @DisplayName("更新角色成功")
        void updateRole_ShouldUpdateSuccessfully() {
            when(roleMapper.selectById("r-001")).thenReturn(testRole);
            when(roleMapper.updateById(any(Role.class))).thenReturn(1);
            RoleUser ru = new RoleUser();
            ru.setUserId("user-1");
            ru.setRoleId("r-001");
            when(roleUserMapper.selectList(any(LambdaQueryWrapper.class))).thenReturn(List.of(ru));

            RoleUpdateDTO dto = new RoleUpdateDTO();
            dto.setId("r-001");
            dto.setRoleName("更新角色");
            dto.setRoleCode("updated_role");
            dto.setMenuIds(List.of(1L));

            roleService.updateRole(dto);

            verify(roleMapper).updateById(any(Role.class));
            verify(roleMenuService).updateRoleMenus("r-001", List.of(1L));
            verify(userDetailsService).clearUserCache("user-1");
        }

        @Test
        @DisplayName("更新角色 - 不存在抛异常")
        void updateRole_ShouldThrowException_WhenNotFound() {
            when(roleMapper.selectById("nonexistent")).thenReturn(null);

            RoleUpdateDTO dto = new RoleUpdateDTO();
            dto.setId("nonexistent");
            dto.setRoleName("更新角色");
            dto.setRoleCode("updated_role");

            assertThatThrownBy(() -> roleService.updateRole(dto))
                    .isInstanceOf(RuntimeException.class)
                    .hasMessage("角色不存在");
        }
    }

    @Nested
    @DisplayName("删除角色")
    class DeleteTests {

        @Test
        @DisplayName("删除角色成功")
        void deleteRoles_ShouldDeleteSuccessfully() {
            when(roleUserMapper.selectCount(any(LambdaQueryWrapper.class))).thenReturn(0L);
            doReturn(true).when(roleService).removeById("r-001");
            doReturn(true).when(roleService).removeById("r-002");

            roleService.deleteRoles(List.of("r-001", "r-002"));

            verify(roleMenuService).deleteByRoleId("r-001");
            verify(roleMenuService).deleteByRoleId("r-002");
        }

        @Test
        @DisplayName("删除已分配角色抛异常")
        void deleteRoles_ShouldThrowException_WhenRoleAssigned() {
            when(roleUserMapper.selectCount(any(LambdaQueryWrapper.class))).thenReturn(1L);
            when(roleMapper.selectById("r-001")).thenReturn(testRole);

            assertThatThrownBy(() -> roleService.deleteRoles(List.of("r-001")))
                    .isInstanceOf(RuntimeException.class)
                    .hasMessageContaining("已分配给用户");
        }
    }

    @Nested
    @DisplayName("数据权限与菜单权限")
    class PermsTests {

        @Test
        @DisplayName("更新数据权限")
        void updateDataScope_ShouldUpdateScope() {
            when(roleMapper.selectById("r-001")).thenReturn(testRole);
            when(roleMapper.updateById(any(Role.class))).thenReturn(1);

            Role updateRole = new Role();
            updateRole.setId("r-001");
            updateRole.setDataScope("2");
            roleService.updateDataScope(updateRole);

            verify(roleMapper).updateById(any(Role.class));
        }

        @Test
        @DisplayName("更新菜单权限 - 应清除用户缓存")
        void updateMenuPerms_ShouldClearUserCache() {
            RoleUser ru = new RoleUser();
            ru.setUserId("user-1");
            when(roleUserMapper.selectList(any(LambdaQueryWrapper.class))).thenReturn(List.of(ru));

            roleService.updateMenuPerms("r-001", List.of(1L, 2L));

            verify(roleMenuService).updateRoleMenus("r-001", List.of(1L, 2L));
            verify(userDetailsService).clearUserCache("user-1");
        }
    }

    @Nested
    @DisplayName("角色下拉选项")
    class OptionsTests {

        @Test
        @DisplayName("获取角色下拉选项列表")
        void getRoleOptionSelect_ShouldReturnRoleList() {
            doReturn(List.of(testRole)).when(roleService).getRoleOptionSelect();

            List<Role> result = roleService.getRoleOptionSelect();

            assertThat(result).hasSize(1);
            assertThat(result.get(0).getRoleName()).isEqualTo("管理员");
        }
    }
}
