<template>
  <a-config-provider :theme="themeConfig">
    <router-view />
  </a-config-provider>
</template>

<script setup>
import { computed, watch } from 'vue'
import { theme } from 'ant-design-vue'
import { useAppStore } from '@/store/modules/app'

const appStore = useAppStore()

const themeConfig = computed(() => ({
  algorithm: appStore.darkMode ? theme.darkAlgorithm : theme.defaultAlgorithm,
  token: {
    borderRadius: 6
  }
}))

watch(() => appStore.darkMode, (dark) => {
  document.body.style.background = dark ? '#141414' : '#fff'
}, { immediate: true })
</script>

<style>
body {
  margin: 0;
  padding: 0;
  transition: background 0.3s;
}
</style>
