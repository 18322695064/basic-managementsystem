package com.management.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.management.entity.SysMenu;
import com.management.mapper.SysMenuMapper;
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

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("SysMenuServiceImpl 单元测试")
class SysMenuServiceImplTest {

    @Mock
    private SysMenuMapper sysMenuMapper;

    @Spy
    @InjectMocks
    private SysMenuServiceImpl menuService;

    private SysMenu menuM;
    private SysMenu menuC;
    private SysMenu menuF;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(menuService, "baseMapper", sysMenuMapper);

        menuM = createMenu(1L, 0L, "系统管理", "M", "/system", null, "system:menu:list");
        menuC = createMenu(2L, 1L, "用户管理", "C", "user", "system/user/index", "system:user:list");
        menuF = createMenu(3L, 1L, "用户新增", "F", null, null, "system:user:add");
    }

    private SysMenu createMenu(Long id, Long parentId, String name, String type,
                                String path, String component, String perms) {
        SysMenu menu = new SysMenu();
        menu.setId(id);
        menu.setParentId(parentId);
        menu.setMenuName(name);
        menu.setMenuType(type);
        menu.setPath(path);
        menu.setComponent(component);
        menu.setPerms(perms);
        menu.setSortOrder(id.intValue());
        menu.setVisible("0");
        return menu;
    }

    @Nested
    @DisplayName("菜单列表查询")
    class MenuListTests {

        @Test
        @DisplayName("查询全部菜单列表")
        void selectMenuList_ShouldReturnAllMenus() {
            List<SysMenu> allMenus = List.of(menuM, menuC, menuF);
            when(sysMenuMapper.selectList(any(LambdaQueryWrapper.class))).thenReturn(allMenus);

            List<SysMenu> result = menuService.selectMenuList(null);

            assertThat(result).hasSize(3);
        }
    }

    @Nested
    @DisplayName("权限筛选菜单")
    class MenuByPermissionsTests {

        @Test
        @DisplayName("空权限列表返回空列表")
        void selectMenusByPermissions_ShouldReturnEmpty_WhenEmptyPermissions() {
            List<SysMenu> result = menuService.selectMenusByPermissions(List.of());

            assertThat(result).isEmpty();
        }

        @Test
        @DisplayName("按权限筛选匹配菜单")
        void selectMenusByPermissions_ShouldReturnMatchedMenus() {
            List<SysMenu> allMenus = List.of(menuM, menuC, menuF);
            when(sysMenuMapper.selectList(any(LambdaQueryWrapper.class))).thenReturn(allMenus);

            List<String> permissions = List.of("system:user:list");

            List<SysMenu> result = menuService.selectMenusByPermissions(permissions);

            assertThat(result).isNotEmpty();
            assertThat(result).hasSize(2);
        }

        @Test
        @DisplayName("目录型 M 菜单即使无权限也应包含")
        void selectMenusByPermissions_ShouldIncludeMDirectories() {
            SysMenu mNoPerm = createMenu(10L, 0L, "目录", "M", "/test", null, null);
            List<SysMenu> allMenus = List.of(mNoPerm, menuC);
            when(sysMenuMapper.selectList(any(LambdaQueryWrapper.class))).thenReturn(allMenus);

            List<String> permissions = List.of("system:user:list");

            List<SysMenu> result = menuService.selectMenusByPermissions(permissions);

            assertThat(result).isNotEmpty();
            assertThat(result.stream().anyMatch(m -> "目录".equals(m.getMenuName()))).isTrue();
        }

        @Test
        @DisplayName("匹配祖先菜单")
        void selectMenusByPermissions_ShouldIncludeAncestors() {
            List<SysMenu> allMenus = List.of(menuM, menuC, menuF);
            when(sysMenuMapper.selectList(any(LambdaQueryWrapper.class))).thenReturn(allMenus);

            List<String> permissions = List.of("system:user:add");

            List<SysMenu> result = menuService.selectMenusByPermissions(permissions);

            assertThat(result).isNotEmpty();
        }
    }

    @Nested
    @DisplayName("删除菜单")
    class RemoveMenuTests {

        @Test
        @DisplayName("无子菜单可删除")
        void removeMenu_ShouldReturnTrue_WhenNoChildren() {
            when(sysMenuMapper.selectCount(any(LambdaQueryWrapper.class))).thenReturn(0L);
            doReturn(true).when(menuService).removeById(2L);

            boolean result = menuService.removeMenu(2L);

            assertThat(result).isTrue();
        }

        @Test
        @DisplayName("有子菜单不可删除")
        void removeMenu_ShouldReturnFalse_WhenHasChildren() {
            when(sysMenuMapper.selectCount(any(LambdaQueryWrapper.class))).thenReturn(2L);

            boolean result = menuService.removeMenu(1L);

            assertThat(result).isFalse();
            verify(menuService, never()).removeById(any());
        }
    }
}
