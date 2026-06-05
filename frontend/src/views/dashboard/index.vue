<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/store'
import request from '@/utils/request'
import {
  UserOutlined,
  TeamOutlined,
  FileTextOutlined,
  LoginOutlined,
  SettingOutlined,
  MenuOutlined,
  BookOutlined
} from '@ant-design/icons-vue'

const router = useRouter()
const userStore = useUserStore()

const statistics = ref({
  userCount: 0,
  roleCount: 0,
  todayLogin: 0,
  operLogCount: 0
})

const loading = ref(false)

const getStatistics = async () => {
  loading.value = true
  const silent = { silent: true }
  try {
    const userRes = await request({ url: '/system/user/list', method: 'get', params: { pageNum: 1, pageSize: 1 }, ...silent })
    statistics.value.userCount = userRes.data?.total || 0
  } catch (e) {}
  try {
    const roleRes = await request({ url: '/system/role/list', method: 'get', params: { pageNum: 1, pageSize: 1 }, ...silent })
    statistics.value.roleCount = roleRes.data?.total || 0
  } catch (e) {}
  try {
    const loginRes = await request({ url: '/system/log/login/list', method: 'get', params: { pageNum: 1, pageSize: 1 }, ...silent })
    statistics.value.todayLogin = loginRes.data?.total || 0
  } catch (e) {}
  try {
    const operRes = await request({ url: '/system/log/oper/list', method: 'get', params: { pageNum: 1, pageSize: 1 }, ...silent })
    statistics.value.operLogCount = operRes.data?.total || 0
  } catch (e) {}
  loading.value = false
}

const allQuickMenus = [
  { title: '用户管理', icon: UserOutlined, path: '/system/user', color: '#1890ff', perms: ['system:user:list', 'system:user:query'] },
  { title: '角色管理', icon: TeamOutlined, path: '/system/role', color: '#52c41a', perms: ['system:role:list', 'system:role:query'] },
  { title: '菜单管理', icon: MenuOutlined, path: '/system/menu', color: '#faad14', perms: ['system:menu:list', 'system:menu:query'] },
  { title: '字典管理', icon: BookOutlined, path: '/system/dict', color: '#722ed1', perms: ['system:dict:list', 'system:dict:query'] },
  { title: '参数设置', icon: SettingOutlined, path: '/system/config', color: '#13c2c2', perms: ['system:config:list', 'system:config:query'] },
  { title: '操作日志', icon: FileTextOutlined, path: '/monitor/operlog', color: '#f5222d', perms: ['system:log:list', 'monitor:operlog:list'] }
]

const quickMenus = computed(() => {
  const perms = userStore.permissions || []
  if (perms.length === 0) return []
  if (perms.includes('*:*:*')) return allQuickMenus
  return allQuickMenus.filter(menu => menu.perms.some(p => perms.includes(p)))
})

onMounted(() => {
  getStatistics()
})
</script>

<template>
  <div>
    <a-row :gutter="16" style="margin-bottom: 16px">
      <a-col :span="6">
        <a-card :loading="loading">
          <a-statistic title="用户总数" :value="statistics.userCount">
            <template #prefix>
              <UserOutlined style="color: #1890ff" />
            </template>
          </a-statistic>
        </a-card>
      </a-col>
      <a-col :span="6">
        <a-card :loading="loading">
          <a-statistic title="角色总数" :value="statistics.roleCount">
            <template #prefix>
              <TeamOutlined style="color: #52c41a" />
            </template>
          </a-statistic>
        </a-card>
      </a-col>
      <a-col :span="6">
        <a-card :loading="loading">
          <a-statistic title="登录次数" :value="statistics.todayLogin">
            <template #prefix>
              <LoginOutlined style="color: #faad14" />
            </template>
          </a-statistic>
        </a-card>
      </a-col>
      <a-col :span="6">
        <a-card :loading="loading">
          <a-statistic title="操作日志" :value="statistics.operLogCount">
            <template #prefix>
              <FileTextOutlined style="color: #f5222d" />
            </template>
          </a-statistic>
        </a-card>
      </a-col>
    </a-row>

    <a-row :gutter="16">
      <a-col :span="16">
        <a-card title="快捷操作">
          <a-row :gutter="[16, 16]">
            <a-col :span="8" v-for="menu in quickMenus" :key="menu.path">
              <a-button block @click="router.push(menu.path)" style="height: 60px">
                <component :is="menu.icon" :style="{ fontSize: '24px', color: menu.color }" />
                <div style="margin-top: 8px">{{ menu.title }}</div>
              </a-button>
            </a-col>
          </a-row>
        </a-card>
      </a-col>
      <a-col :span="8">
        <a-card title="个人信息">
          <a-descriptions :column="1">
            <a-descriptions-item label="用户名">{{ userStore.username }}</a-descriptions-item>
            <a-descriptions-item label="昵称">{{ userStore.nickname || '-' }}</a-descriptions-item>
            <a-descriptions-item label="角色">
              <a-tag v-for="role in userStore.roles" :key="role" color="blue">{{ role }}</a-tag>
            </a-descriptions-item>
          </a-descriptions>
        </a-card>
      </a-col>
    </a-row>
  </div>
</template>
