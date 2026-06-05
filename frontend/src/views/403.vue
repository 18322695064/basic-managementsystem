<template>
  <div class="error-page">
    <div class="error-content">
      <h1 class="error-code">403</h1>
      <p class="error-desc">抱歉，您没有权限访问该页面</p>
      <a-button type="primary" @click="goBack">返回上一页</a-button>
      <a-button style="margin-left: 12px" @click="goHome">回到首页</a-button>
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'

const router = useRouter()

const goBack = () => {
  router.go(-1)
}

const goHome = () => {
  router.push('/')
}
</script>

<style scoped>
.error-page {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background: #f0f2f5;
}
.error-content {
  text-align: center;
}
.error-code {
  font-size: 120px;
  font-weight: 700;
  color: #409eff;
  margin: 0;
  line-height: 1;
}
.error-desc {
  font-size: 20px;
  color: #666;
  margin: 24px 0 40px;
}
</style>
