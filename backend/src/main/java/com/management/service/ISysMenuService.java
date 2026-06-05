package com.management.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.management.entity.SysMenu;

import java.util.List;

public interface ISysMenuService extends IService<SysMenu> {

    List<SysMenu> selectMenuList(Long userId);

    List<SysMenu> selectMenusByPermissions(List<String> permissions);

    boolean removeMenu(Long menuId);
}
