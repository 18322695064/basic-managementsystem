<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { useUserStore } from '@/store'
import { getCaptchaImage } from '@/api/auth'
import { UserOutlined, LockOutlined, SafetyCertificateOutlined } from '@ant-design/icons-vue'

const { t } = useI18n()
const router = useRouter()
const route = useRoute()
const userStore = useUserStore()

const loginForm = reactive({
  username: 'admin',
  password: 'superAdmin@088',
  code: '',
  uuid: ''
})

const captchaImg = ref('')
const loading = ref(false)

const getCaptcha = async () => {
  const res = await getCaptchaImage()
  captchaImg.value = res.data.img
  loginForm.uuid = res.data.uuid
}

const handleLogin = async () => {
  if (!loginForm.username || !loginForm.password || !loginForm.code) {
    return
  }
  loading.value = true
  try {
    await userStore.login(loginForm)
    const redirect = route.query.redirect || '/'
    router.push(redirect)
  } catch (e) {
    getCaptcha()
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  getCaptcha()
})
</script>

<template>
  <div style="min-height: 100vh; display: flex; justify-content: center; align-items: center; background: #f0f2f5">
    <a-card style="width: 400px">
      <h2 style="text-align: center; margin-bottom: 24px">{{ t('login.title') }}</h2>
      <a-form :model="loginForm" @finish="handleLogin">
        <a-form-item>
          <a-input v-model:value="loginForm.username" :placeholder="t('login.username')" size="large">
            <template #prefix><UserOutlined /></template>
          </a-input>
        </a-form-item>
        <a-form-item>
          <a-input-password v-model:value="loginForm.password" :placeholder="t('login.password')" size="large">
            <template #prefix><LockOutlined /></template>
          </a-input-password>
        </a-form-item>
        <a-form-item>
          <a-row :gutter="16">
            <a-col :span="14">
              <a-input v-model:value="loginForm.code" :placeholder="t('login.captcha')" size="large">
                <template #prefix><SafetyCertificateOutlined /></template>
              </a-input>
            </a-col>
            <a-col :span="10">
              <img :src="captchaImg" @click="getCaptcha" style="width: 100%; height: 40px; cursor: pointer" :alt="t('login.captcha')" />
            </a-col>
          </a-row>
        </a-form-item>
        <a-form-item>
          <a-button type="primary" html-type="submit" :loading="loading" block size="large">
            {{ t('login.btnLogin') }}
          </a-button>
        </a-form-item>
      </a-form>
    </a-card>
  </div>
</template>
