import { useUserStore } from '../store/modules/user'

export default {
  mounted(el, binding) {
    const { value } = binding
    const userStore = useUserStore()
    const permissions = userStore.permissions || []

    if (value && value instanceof Array && value.length > 0) {
      const hasPermission = permissions.some(permission => {
        return permissions.includes('*:*:*') || value.includes(permission)
      })

      if (!hasPermission) {
        el.parentNode && el.parentNode.removeChild(el)
      }
    } else {
      throw new Error('需要指定权限标识，如 v-hasPermi="[\'system:user:add\']"')
    }
  }
}
