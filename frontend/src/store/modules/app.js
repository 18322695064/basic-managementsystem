import { defineStore } from 'pinia'

export const useAppStore = defineStore('app', {
  state: () => ({
    darkMode: localStorage.getItem('darkMode') === 'true',
    openedTabs: JSON.parse(localStorage.getItem('openedTabs') || '[]'),
    activeTab: localStorage.getItem('activeTab') || ''
  }),

  actions: {
    toggleDark() {
      this.darkMode = !this.darkMode
      localStorage.setItem('darkMode', this.darkMode)
    },

    addTab(route) {
      if (!route.path || route.path === '/login') return
      const exist = this.openedTabs.find(t => t.path === route.path)
      if (!exist) {
        this.openedTabs.push({
          path: route.path,
          title: route.meta?.title || route.name || route.path,
          query: route.query
        })
      }
      this.activeTab = route.path
      localStorage.setItem('openedTabs', JSON.stringify(this.openedTabs))
      localStorage.setItem('activeTab', this.activeTab)
    },

    removeTab(path) {
      const idx = this.openedTabs.findIndex(t => t.path === path)
      if (idx === -1) return
      this.openedTabs.splice(idx, 1)
      if (this.activeTab === path) {
        const next = this.openedTabs[idx] || this.openedTabs[idx - 1]
        this.activeTab = next ? next.path : ''
      }
      localStorage.setItem('openedTabs', JSON.stringify(this.openedTabs))
      localStorage.setItem('activeTab', this.activeTab)
    },

    closeOthers(path) {
      this.openedTabs = this.openedTabs.filter(t => t.path === path)
      this.activeTab = path
      localStorage.setItem('openedTabs', JSON.stringify(this.openedTabs))
      localStorage.setItem('activeTab', this.activeTab)
    },

    closeAll() {
      this.openedTabs = []
      this.activeTab = ''
      localStorage.setItem('openedTabs', '[]')
      localStorage.setItem('activeTab', '')
    }
  }
})
