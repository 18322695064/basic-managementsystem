<script setup>
import { ref, watch, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { useUserStore, useAppStore } from '@/store'
import { getRouters } from '@/api/auth'
import {
  MenuFoldOutlined, MenuUnfoldOutlined, LogoutOutlined, UserOutlined,
  DashboardOutlined, BulbOutlined, BulbFilled, ReloadOutlined, CloseOutlined
} from '@ant-design/icons-vue'
import * as Icons from '@ant-design/icons-vue'

const { t } = useI18n()
const router = useRouter()
const route = useRoute()
const userStore = useUserStore()
const appStore = useAppStore()

const collapsed = ref(false)
const selectedKeys = ref([route.path])
const openKeys = ref([])
const menuList = ref([])
const refreshKey = ref(0)

const tabContextMenus = ref({ visible: false, x: 0, y: 0, path: '' })

const headerStyle = computed(() => ({
  background: appStore.darkMode ? '#141414' : '#fff',
  padding: '0 24px',
  display: 'flex',
  justifyContent: 'space-between',
  alignItems: 'center',
  borderBottom: appStore.darkMode ? '1px solid #303030' : '1px solid #f0f0f0'
}))

const tabsBarStyle = computed(() => ({
  background: appStore.darkMode ? '#141414' : '#fff',
  padding: '8px 12px 0',
  borderBottom: appStore.darkMode ? '1px solid #303030' : '1px solid #f0f0f0',
  display: 'flex',
  alignItems: 'center'
}))

const getIcon = (name) => {
  if (!name) return null
  return Icons[name] || null
}

const loadMenus = async () => {
  try {
    await userStore.getInfo()
    const res = await getRouters()
    menuList.value = res.data || []
    const first = menuList.value.find(m => m.children?.length > 0)
    if (first) openKeys.value = [first.path]
  } catch (e) {
    console.error('load menu failed', e)
  }
}
loadMenus()

const handleMenuClick = ({ key }) => {
  router.push(key.startsWith('/') ? key : '/' + key)
}

watch(() => route.path, (path) => {
  selectedKeys.value = [path]
  appStore.addTab(route)
}, { immediate: true })

const handleLogout = async () => {
  await userStore.logout()
  appStore.closeAll()
  router.push('/login')
}

const handleTabClick = (path) => {
  router.push(path)
}

const handleTabClose = (path) => {
  appStore.removeTab(path)
  if (appStore.activeTab) {
    router.push(appStore.activeTab)
  } else {
    router.push('/dashboard')
  }
}

const handleTabContextMenu = (e, path) => {
  e.preventDefault()
  tabContextMenus.value = { visible: true, x: e.clientX, y: e.clientY, path }
}

const closeContextMenu = () => {
  tabContextMenus.value.visible = false
}

const handleRefresh = () => {
  refreshKey.value++
}
</script>

<template>
  <a-layout style="min-height: 100vh">
    <a-layout-sider v-model:collapsed="collapsed" collapsible>
      <div style="height: 32px; margin: 16px; background: rgba(255, 255, 255, 0.2); text-align: center; line-height: 32px; color: white; font-weight: bold">
        {{ collapsed ? 'MS' : t('common.appName') }}
      </div>
      <a-menu
        v-model:selectedKeys="selectedKeys"
        v-model:openKeys="openKeys"
        theme="dark"
        mode="inline"
        @click="handleMenuClick"
      >
        <a-menu-item key="/dashboard">
          <template #icon><DashboardOutlined /></template>
          <span>{{ t('common.home') }}</span>
        </a-menu-item>
        <template v-for="menu in menuList" :key="menu.path">
          <a-sub-menu v-if="menu.children && menu.children.length > 0" :key="menu.path">
            <template #icon>
              <component :is="getIcon(menu.meta?.icon)" v-if="menu.meta?.icon && getIcon(menu.meta?.icon)" />
            </template>
            <template #title>{{ menu.meta?.title || menu.name }}</template>
            <a-menu-item v-for="child in menu.children" :key="child.path">
              <template #icon>
                <component :is="getIcon(child.meta?.icon)" v-if="child.meta?.icon && getIcon(child.meta?.icon)" />
              </template>
              <span>{{ child.meta?.title || child.name }}</span>
            </a-menu-item>
          </a-sub-menu>
        </template>
      </a-menu>
    </a-layout-sider>
    <a-layout>
      <a-layout-header :style="headerStyle">
        <div>
          <MenuFoldOutlined v-if="!collapsed" @click="collapsed = true" style="font-size: 18px; cursor: pointer" />
          <MenuUnfoldOutlined v-else @click="collapsed = false" style="font-size: 18px; cursor: pointer" />
        </div>
        <a-space>
          <a-tooltip :title="appStore.darkMode ? t('common.darkMode') : t('common.darkMode')">
            <a-button shape="circle" size="small" @click="appStore.toggleDark()">
              <template #icon>
                <BulbFilled v-if="!appStore.darkMode" />
                <BulbOutlined v-else />
              </template>
            </a-button>
          </a-tooltip>
          <a-dropdown>
            <a-space style="cursor: pointer">
              <a-avatar :size="24"><template #icon><UserOutlined /></template></a-avatar>
              <span>{{ userStore.nickname || userStore.username }}</span>
            </a-space>
            <template #overlay>
              <a-menu>
                <a-menu-item key="logout" @click="handleLogout">
                  <LogoutOutlined /> {{ t('common.logout') }}
                </a-menu-item>
              </a-menu>
            </template>
          </a-dropdown>
        </a-space>
      </a-layout-header>

      <div v-if="appStore.openedTabs.length > 0" :style="tabsBarStyle">
        <a-tabs
          v-model:activeKey="appStore.activeTab"
          type="editable-card"
          size="small"
          style="flex: 1"
          :hide-add="true"
          @tabClick="handleTabClick"
          @edit="handleTabClose"
          @contextmenu.native.prevent
        >
          <a-tab-pane
            v-for="tab in appStore.openedTabs"
            :key="tab.path"
            :tab="tab.title"
            :closable="appStore.openedTabs.length > 1"
            @contextmenu.native="(e) => handleTabContextMenu(e, tab.path)"
          />
        </a-tabs>
        <a-dropdown :trigger="['click']">
          <a-button type="text" size="small"><CloseOutlined /></a-button>
          <template #overlay>
            <a-menu @click="({ key }) => {
              if (key === 'others') {
                appStore.closeOthers(appStore.activeTab)
              } else if (key === 'all') {
                appStore.closeAll()
                router.push('/dashboard')
              } else if (key === 'refresh') {
                handleRefresh()
              }
            }">
              <a-menu-item key="refresh"><ReloadOutlined /> 刷新当前</a-menu-item>
              <a-menu-item key="others">关闭其他</a-menu-item>
              <a-menu-item key="all">关闭全部</a-menu-item>
            </a-menu>
          </template>
        </a-dropdown>
      </div>

      <a-layout-content style="margin: 16px">
        <router-view :key="refreshKey" />
      </a-layout-content>
    </a-layout>
  </a-layout>
</template>
