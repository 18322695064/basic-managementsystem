<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listLoginLog, cleanLoginLog } from '@/api/log'
import { message, Modal } from 'ant-design-vue'

const loading = ref(false)
const dataSource = ref([])
const total = ref(0)
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  accountNumber: '',
  loginIp: '',
  loginStatus: ''
})

const columns = [
  { title: '日志编号', dataIndex: 'id', width: 80 },
  { title: '登录账号', dataIndex: 'accountNumber', width: 120 },
  { title: '登录IP', dataIndex: 'loginIp', width: 130 },
  { title: '浏览器', dataIndex: 'browser', width: 100 },
  { title: '操作系统', dataIndex: 'os', width: 120 },
  { title: '状态', dataIndex: 'loginStatus', width: 80 },
  { title: '提示消息', dataIndex: 'msg', width: 150 },
  { title: '登录时间', dataIndex: 'loginTime', width: 180 }
]

const getList = async () => {
  loading.value = true
  try {
    const res = await listLoginLog(queryParams)
    dataSource.value = res.data.rows || []
    total.value = res.data.total || 0
  } finally {
    loading.value = false
  }
}

const handleClean = () => {
  Modal.confirm({
    title: '确认清空',
    content: '确定要清空所有登录日志吗？',
    okText: '确定',
    cancelText: '取消',
    onOk: async () => {
      await cleanLoginLog()
      message.success('清空成功')
      getList()
    }
  })
}

const handleSearch = () => {
  queryParams.pageNum = 1
  getList()
}

const handleReset = () => {
  queryParams.accountNumber = ''
  queryParams.loginIp = ''
  queryParams.loginStatus = ''
  handleSearch()
}

const handleTableChange = (pagination) => {
  queryParams.pageNum = pagination.current
  queryParams.pageSize = pagination.pageSize
  getList()
}

onMounted(() => {
  getList()
})
</script>

<template>
  <div>
    <a-card>
      <a-form layout="inline" style="margin-bottom: 16px">
        <a-form-item label="登录账号">
          <a-input v-model:value="queryParams.accountNumber" placeholder="请输入登录账号" allow-clear />
        </a-form-item>
        <a-form-item label="登录IP">
          <a-input v-model:value="queryParams.loginIp" placeholder="请输入登录IP" allow-clear />
        </a-form-item>
        <a-form-item label="状态">
          <a-select v-model:value="queryParams.loginStatus" placeholder="请选择" allow-clear style="width: 100px">
            <a-select-option value="0">成功</a-select-option>
            <a-select-option value="1">失败</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item>
          <a-space>
            <a-button type="primary" @click="handleSearch">搜索</a-button>
            <a-button @click="handleReset">重置</a-button>
            <a-button danger @click="handleClean">清空</a-button>
          </a-space>
        </a-form-item>
      </a-form>

      <a-table
        :columns="columns"
        :data-source="dataSource"
        :loading="loading"
        :pagination="{
          current: queryParams.pageNum,
          pageSize: queryParams.pageSize,
          total: total,
          showSizeChanger: true,
          showQuickJumper: true,
          showTotal: (total) => `共 ${total} 条`
        }"
        @change="handleTableChange"
        row-key="id"
        :scroll="{ x: 1000 }"
      >
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'loginStatus'">
            <a-tag :color="record.loginStatus === '0' ? 'green' : 'red'">
              {{ record.loginStatus === '0' ? '成功' : '失败' }}
            </a-tag>
          </template>
        </template>
      </a-table>
    </a-card>
  </div>
</template>
