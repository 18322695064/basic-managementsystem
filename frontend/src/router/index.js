import { createRouter, createWebHistory } from 'vue-router'
import { getToken } from '@/utils/auth'

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/login/index.vue')
  },
  {
    path: '/404',
    name: '404',
    component: () => import('@/views/404.vue')
  },
  {
    path: '/',
    name: 'Layout',
    component: () => import('@/layout/index.vue'),
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('@/views/dashboard/index.vue'),
        meta: { title: '首页', icon: 'DashboardOutlined' }
      },
      {
        path: 'system/user',
        name: 'User',
        component: () => import('@/views/system/user/index.vue'),
        meta: { title: '用户管理', icon: 'UserOutlined' }
      },
      {
        path: 'system/role',
        name: 'Role',
        component: () => import('@/views/system/role/index.vue'),
        meta: { title: '角色管理', icon: 'TeamOutlined' }
      },
      {
        path: 'system/menu',
        name: 'Menu',
        component: () => import('@/views/system/menu/index.vue'),
        meta: { title: '菜单管理', icon: 'MenuOutlined' }
      },
      {
        path: 'system/dept',
        name: 'Dept',
        component: () => import('@/views/system/dept/index.vue'),
        meta: { title: '组织管理', icon: 'ApartmentOutlined' }
      },
      {
        path: 'system/dict',
        name: 'Dict',
        component: () => import('@/views/system/dict/index.vue'),
        meta: { title: '字典管理', icon: 'BookOutlined' }
      },
      {
        path: 'system/config',
        name: 'Config',
        component: () => import('@/views/system/config/index.vue'),
        meta: { title: '参数设置', icon: 'ToolOutlined' }
      },
      {
        path: 'system/notice',
        name: 'Notice',
        component: () => import('@/views/system/notice/index.vue'),
        meta: { title: '通知公告', icon: 'NotificationOutlined' }
      },
      {
        path: 'monitor/operlog',
        name: 'OperLog',
        component: () => import('@/views/monitor/operlog/index.vue'),
        meta: { title: '操作日志', icon: 'FileTextOutlined' }
      },
      {
        path: 'monitor/loginlog',
        name: 'LoginLog',
        component: () => import('@/views/monitor/loginlog/index.vue'),
        meta: { title: '登录日志', icon: 'LoginOutlined' }
      },
      {
        path: 'system/file',
        name: 'File',
        component: () => import('@/views/tool/file/index.vue'),
        meta: { title: '文件管理', icon: 'FileOutlined' }
      },
      {
        path: 'tool/gen',
        name: 'CodeGen',
        component: () => import('@/views/tool/gen/index.vue'),
        meta: { title: '代码生成器', icon: 'CodeOutlined' }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior: () => ({ top: 0 })
})

const whiteList = ['/login']

router.beforeEach((to, from, next) => {
  const token = getToken()
  if (token) {
    if (to.path === '/login') {
      next({ path: '/' })
    } else {
      next()
    }
  } else {
    if (whiteList.includes(to.path)) {
      next()
    } else {
      next(`/login?redirect=${to.path}`)
    }
  }
})

export default router
