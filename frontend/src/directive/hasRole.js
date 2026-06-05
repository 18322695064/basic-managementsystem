import { useUserStore } from '../store/modules/user'

export default {
  mounted(el, binding) {
    const { value } = binding
    const userStore = useUserStore()
    const roles = userStore.roles || []

    if (value && value instanceof Array && value.length > 0) {
      const hasRole = roles.some(role => {
        return roles.includes('admin') || value.includes(role)
      })

      if (!hasRole) {
        el.parentNode && el.parentNode.removeChild(el)
      }
    } else {
      throw new Error('需要指定角色标识，如 v-hasRole="[\'admin\']"')
    }
  }
}
