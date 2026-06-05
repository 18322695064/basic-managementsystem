<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listOperLog, cleanOperLog } from '@/api/log'
import { message, Modal } from 'ant-design-vue'

const loading = ref(false)
const dataSource = ref([])
const total = ref(0)
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  operName: '',
  status: undefined
})

const columns = [
  { title: '日志编号', dataIndex: 'id', width: 200 },
  { title: '操作人', dataIndex: 'realname', width: 120 },
  { title: '操作IP', dataIndex: 'clientIp', width: 130 },
  { title: '日志类型', dataIndex: 'logType', width: 100 },
  { title: '日志内容', dataIndex: 'logContent', width: 300 },
  { title: '状态', dataIndex: 'isError', width: 80 },
  { title: '操作时间', dataIndex: 'createTime', width: 180 }
]

const logTypeMap = { 0: '其它', 1: '新增', 2: '修改', 3: '删除', 4: '查询' }

const getList = async () => {
  loading.value = true
  try {
    const res = await listOperLog(queryParams)
    dataSource.value = res.data.rows || []
    total.value = res.data.total || 0
  } finally {
    loading.value = false
  }
}

const handleClean = () => {
  Modal.confirm({
    title: '确认清空',
    content: '确定要清空所有操作日志吗？',
    okText: '确定',
    cancelText: '取消',
    onOk: async () => {
      await cleanOperLog()
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
  queryParams.operName = ''
  queryParams.status = undefined
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
        <a-form-item label="操作人">
          <a-input v-model:value="queryParams.operName" placeholder="请输入操作人" allow-clear />
        </a-form-item>
        <a-form-item label="状态">
          <a-select v-model:value="queryParams.status" placeholder="请选择" allow-clear style="width: 100px">
            <a-select-option :value="0">成功</a-select-option>
            <a-select-option :value="1">失败</a-select-option>
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
          showTotal: (total) => '共 ' + total + ' 条'
        }"
        @change="handleTableChange"
        row-key="id"
        :scroll="{ x: 1200 }"
      >
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'logType'">
            <a-tag>{{ logTypeMap[record.logType] || '其它' }}</a-tag>
          </template>
          <template v-if="column.dataIndex === 'isError'">
            <a-tag :color="record.isError === 0 ? 'green' : 'red'">
              {{ record.isError === 0 ? '成功' : '失败' }}
            </a-tag>
          </template>
        </template>
      </a-table>
    </a-card>
  </div>
</template>
