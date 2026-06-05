<template>
  <div class="app-container">
    <a-row :gutter="16">
      <a-col :span="8">
        <a-card title="用户信息">
          <div class="user-info">
            <a-avatar :size="80" style="background-color: #1890ff; font-size: 32px">
              {{ userStore.nickname?.charAt(0) || 'U' }}
            </a-avatar>
            <h3 style="margin-top: 12px">{{ userStore.nickname || userStore.username }}</h3>
            <p style="color: #999">{{ userStore.roles?.join(', ') || '普通用户' }}</p>
          </div>
          <a-descriptions :column="1" size="small" style="margin-top: 16px">
            <a-descriptions-item label="账号">{{ userStore.username }}</a-descriptions-item>
            <a-descriptions-item label="昵称">{{ profileForm.nickName }}</a-descriptions-item>
            <a-descriptions-item label="邮箱">{{ profileForm.email || '未设置' }}</a-descriptions-item>
            <a-descriptions-item label="手机">{{ profileForm.phoneNumber || '未设置' }}</a-descriptions-item>
          </a-descriptions>
        </a-card>
      </a-col>
      <a-col :span="16">
        <a-card title="基本资料" style="margin-bottom: 16px">
          <a-form :model="profileForm" layout="vertical" @finish="handleUpdateProfile">
            <a-row :gutter="16">
              <a-col :span="12">
                <a-form-item label="昵称" name="nickName" :rules="[{ required: true, message: '请输入昵称' }]">
                  <a-input v-model:value="profileForm.nickName" />
                </a-form-item>
              </a-col>
              <a-col :span="12">
                <a-form-item label="邮箱" name="email" :rules="[{ type: 'email', message: '请输入正确的邮箱' }]">
                  <a-input v-model:value="profileForm.email" />
                </a-form-item>
              </a-col>
              <a-col :span="12">
                <a-form-item label="手机号" name="phoneNumber" :rules="[{ pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号' }]">
                  <a-input v-model:value="profileForm.phoneNumber" />
                </a-form-item>
              </a-col>
            </a-row>
            <a-form-item>
              <a-button type="primary" html-type="submit" :loading="profileLoading">保存修改</a-button>
            </a-form-item>
          </a-form>
        </a-card>
        <a-card title="修改密码">
          <a-form :model="pwdForm" layout="vertical" @finish="handleUpdatePwd">
            <a-form-item label="旧密码" name="oldPassword" :rules="[{ required: true, message: '请输入旧密码' }]">
              <a-input-password v-model:value="pwdForm.oldPassword" />
            </a-form-item>
            <a-form-item label="新密码" name="newPassword" :rules="[{ required: true, message: '请输入新密码' }, { min: 6, message: '密码至少6位' }]">
              <a-input-password v-model:value="pwdForm.newPassword" />
            </a-form-item>
            <a-form-item label="确认密码" name="confirmPassword" :rules="[{ required: true, message: '请确认密码' }, { validator: validateConfirmPwd }]">
              <a-input-password v-model:value="pwdForm.confirmPassword" />
            </a-form-item>
            <a-form-item>
              <a-button type="primary" html-type="submit" :loading="pwdLoading">修改密码</a-button>
            </a-form-item>
          </a-form>
        </a-card>
      </a-col>
    </a-row>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { message } from 'ant-design-vue'
import { useUserStore } from '@/store/modules/user'
import request from '@/utils/request'

const userStore = useUserStore()

const profileForm = ref({
  nickName: '',
  email: '',
  phoneNumber: ''
})
const profileLoading = ref(false)

const pwdForm = ref({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})
const pwdLoading = ref(false)

const validateConfirmPwd = async (_rule, value) => {
  if (value && value !== pwdForm.value.newPassword) {
    throw new Error('两次输入的密码不一致')
  }
}

const loadProfile = async () => {
  try {
    const res = await request.get('/auth/getInfo')
    if (res.code === 200) {
      const user = res.data.user
      profileForm.value = {
        nickName: user.nickName || '',
        email: user.email || '',
        phoneNumber: user.phoneNumber || ''
      }
    }
  } catch (e) {
    console.error(e)
  }
}

const handleUpdateProfile = async () => {
  profileLoading.value = true
  try {
    await request.put('/auth/updateProfile', profileForm.value)
    message.success('修改成功')
    await userStore.getInfo()
  } catch (e) {
    console.error(e)
  } finally {
    profileLoading.value = false
  }
}

const handleUpdatePwd = async () => {
  pwdLoading.value = true
  try {
    await request.put('/auth/updatePwd', {
      oldPassword: pwdForm.value.oldPassword,
      newPassword: pwdForm.value.newPassword
    })
    message.success('密码修改成功，请重新登录')
    pwdForm.value = { oldPassword: '', newPassword: '', confirmPassword: '' }
    await userStore.logout()
  } catch (e) {
    console.error(e)
  } finally {
    pwdLoading.value = false
  }
}

onMounted(() => {
  loadProfile()
})
</script>

<style scoped>
.app-container {
  padding: 20px;
}
.user-info {
  text-align: center;
  padding: 20px 0;
}
</style>
