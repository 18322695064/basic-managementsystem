<template>
  <div class="app-container">
    <a-card title="在线用户">
      <a-table :columns="columns" :data-source="onlineUsers" :loading="loading" row-key="userId" :pagination="false">
        <template #bodyCell="{ column, record }">
          <template v-if="column.key === 'expireSeconds'">
            <a-tag :color="record.expireSeconds > 3600 ? 'green' : record.expireSeconds > 600 ? 'orange' : 'red'">
              {{ Math.floor(record.expireSeconds / 60) }}分钟
            </a-tag>
          </template>
          <template v-if="column.key === 'action'">
            <a-popconfirm title="确定要强制下线该用户吗？" @confirm="handleForceLogout(record.userId)">
              <a-button type="link" danger size="small" v-hasPermi="['monitor:online:forceLogout']">强退</a-button>
            </a-popconfirm>
          </template>
        </template>
      </a-table>
    </a-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { message } from 'ant-design-vue'
import request from '@/utils/request'

const loading = ref(false)
const onlineUsers = ref([])

const columns = [
  { title: '用户ID', dataIndex: 'userId', key: 'userId' },
  { title: '用户名', dataIndex: 'userName', key: 'userName' },
  { title: '剩余时间', key: 'expireSeconds' },
  { title: '操作', key: 'action', width: 120 }
]

const loadOnlineUsers = async () => {
  loading.value = true
  try {
    const res = await request.get('/monitor/online/list')
    if (res.code === 200) {
      onlineUsers.value = res.data || []
    }
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

const handleForceLogout = async (userId) => {
  try {
    await request.delete(`/monitor/online/${userId}`)
    message.success('已强制下线')
    await loadOnlineUsers()
  } catch (e) {
    console.error(e)
  }
}

onMounted(() => {
  loadOnlineUsers()
})
</script>

<style scoped>
.app-container { padding: 20px; }
</style>
