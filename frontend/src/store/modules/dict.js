import { defineStore } from 'pinia'
import { getDictDataByType } from '@/api/dict'

export const useDictStore = defineStore('dict', {
  state: () => ({
    dictCache: {}
  }),

  actions: {
    async getDictData(dictType) {
      if (this.dictCache[dictType]) {
        return this.dictCache[dictType]
      }
      const res = await getDictDataByType(dictType)
      this.dictCache[dictType] = res.data || []
      return this.dictCache[dictType]
    },

    removeDict(dictType) {
      delete this.dictCache[dictType]
    },

    clearDict() {
      this.dictCache = {}
    }
  }
})
