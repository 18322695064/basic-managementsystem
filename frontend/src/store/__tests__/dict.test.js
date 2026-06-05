import { describe, it, expect, beforeEach, vi } from 'vitest'
import { setActivePinia, createPinia } from 'pinia'
import { useDictStore } from '../modules/dict'

vi.mock('@/api/dict', () => ({
  getDictDataByType: vi.fn()
}))

import { getDictDataByType } from '@/api/dict'

describe('dict store', () => {
  beforeEach(() => {
    setActivePinia(createPinia())
    vi.clearAllMocks()
  })

  describe('getDictData', () => {
    it('should fetch and cache dict data', async () => {
      const mockData = [
        { dictValue: '0', dictLabel: '男' },
        { dictValue: '1', dictLabel: '女' }
      ]
      getDictDataByType.mockResolvedValue({ data: mockData })

      const store = useDictStore()
      const result = await store.getDictData('sys_user_sex')

      expect(result).toEqual(mockData)
      expect(store.dictCache['sys_user_sex']).toEqual(mockData)
      expect(getDictDataByType).toHaveBeenCalledWith('sys_user_sex')
    })

    it('should return cached data without calling API', async () => {
      const cached = [{ dictValue: '0', dictLabel: '启用' }]
      const store = useDictStore()
      store.dictCache['sys_normal_disable'] = cached

      const result = await store.getDictData('sys_normal_disable')

      expect(result).toEqual(cached)
      expect(getDictDataByType).not.toHaveBeenCalled()
    })
  })

  describe('removeDict', () => {
    it('should remove specific dict from cache', () => {
      const store = useDictStore()
      store.dictCache = { type_a: [], type_b: [] }

      store.removeDict('type_a')

      expect(store.dictCache.type_a).toBeUndefined()
      expect(store.dictCache.type_b).toBeDefined()
    })
  })

  describe('clearDict', () => {
    it('should clear all dict cache', () => {
      const store = useDictStore()
      store.dictCache = { type_a: [], type_b: [] }

      store.clearDict()

      expect(store.dictCache).toEqual({})
    })
  })
})
