import { defineStore } from 'pinia'
import { getRouters } from '@/api/auth'

const modules = import.meta.glob('@/views/**/*.vue')

function resolveComponent(componentPath) {
  if (!componentPath) return null
  if (componentPath === 'Layout') {
    return () => import('@/layout/index.vue')
  }
  const key = `/src/views/${componentPath}.vue`
  return modules[key] || null
}

function resolveFullPath(routes, parentPath = '') {
  for (const route of routes) {
    const fullPath = (parentPath + '/' + route.path).replace(/\/+/g, '/')
    route.path = fullPath
    if (route.children && route.children.length > 0) {
      resolveFullPath(route.children, fullPath)
    }
  }
  return routes
}

function convertRouters(backendRoutes, parentPath = '') {
  const routes = []
  for (const route of backendRoutes) {
    const fullPath = (parentPath + '/' + route.path).replace(/\/+/g, '/')

    const routeConfig = {
      path: route.path.indexOf('/') === 0 ? route.path : fullPath,
      name: fullPath.replace(/[-\/]/g, '_').replace(/^_/, ''),
      component: resolveComponent(route.component),
      meta: route.meta || {},
      hidden: route.hidden || false
    }

    if (route.children && route.children.length > 0) {
      routeConfig.redirect = fullPath + '/' + (route.children[0].path || '')
      routeConfig.children = convertRouters(route.children, fullPath)
    }

    routes.push(routeConfig)
  }
  return routes
}

export const usePermissionStore = defineStore('permission', {
  state: () => ({
    routes: [],
    addRoutes: [],
    loaded: false
  }),

  actions: {
    async generateRoutes() {
      if (this.loaded) return this.routes
      const res = await getRouters()
      const rawRoutes = res.data || []
      this.routes = resolveFullPath(JSON.parse(JSON.stringify(rawRoutes)))
      this.addRoutes = convertRouters(rawRoutes)
      this.loaded = true
      return this.routes
    }
  }
})
