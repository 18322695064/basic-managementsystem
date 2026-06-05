<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listFile, delFile, downloadFile } from '@/api/file'
import { getToken } from '@/utils/auth'
import { message, Modal } from 'ant-design-vue'
import { DownloadOutlined, DeleteOutlined } from '@ant-design/icons-vue'

const loading = ref(false)
const dataSource = ref([])
const total = ref(0)
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  originalName: '',
  fileType: ''
})

const columns = [
  { title: '文件编号', dataIndex: 'id', width: 80 },
  { title: '文件名称', dataIndex: 'originalName', width: 200 },
  { title: '文件类型', dataIndex: 'fileType', width: 120 },
  { title: '文件大小', dataIndex: 'fileSize', width: 120 },
  { title: '上传人', dataIndex: 'uploadBy', width: 100 },
  { title: '上传时间', dataIndex: 'uploadTime', width: 180 },
  { title: '操作', key: 'action', width: 150, fixed: 'right' }
]

const uploadHeaders = {
  Authorization: 'Bearer ' + getToken()
}

const formatFileSize = (size) => {
  if (!size) return '-'
  if (size < 1024) return size + ' B'
  if (size < 1024 * 1024) return (size / 1024).toFixed(2) + ' KB'
  return (size / 1024 / 1024).toFixed(2) + ' MB'
}

const getList = async () => {
  loading.value = true
  try {
    const res = await listFile(queryParams)
    dataSource.value = res.data.rows || []
    total.value = res.data.total || 0
  } finally {
    loading.value = false
  }
}

const handleDownload = async (record) => {
  try {
    const blob = await downloadFile(record.id)
    const url = window.URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = record.originalName
    a.click()
    window.URL.revokeObjectURL(url)
  } catch {
    message.error('下载失败')
  }
}

const handleDelete = (record) => {
  Modal.confirm({
    title: '确认删除',
    content: '确定要删除文件 ' + record.originalName + ' 吗？',
    okText: '确定',
    cancelText: '取消',
    onOk: async () => {
      await delFile(record.id)
      message.success('删除成功')
      getList()
    }
  })
}

const handleUploadChange = (info) => {
  if (info.file.status === 'done') {
    message.success('上传成功')
    getList()
  } else if (info.file.status === 'error') {
    message.error('上传失败')
  }
}

const handleSearch = () => {
  queryParams.pageNum = 1
  getList()
}

const handleReset = () => {
  queryParams.originalName = ''
  queryParams.fileType = ''
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
        <a-form-item label="文件名称">
          <a-input v-model:value="queryParams.originalName" placeholder="请输入文件名称" allow-clear />
        </a-form-item>
        <a-form-item label="文件类型">
          <a-input v-model:value="queryParams.fileType" placeholder="请输入文件类型" allow-clear />
        </a-form-item>
        <a-form-item>
          <a-space>
            <a-button type="primary" @click="handleSearch">搜索</a-button>
            <a-button @click="handleReset">重置</a-button>
          </a-space>
        </a-form-item>
      </a-form>

      <a-upload 
        action="/api/system/file/upload" 
        :headers="uploadHeaders" 
        :show-upload-list="false" 
        @change="handleUploadChange"
      >
        <a-button type="primary" style="margin-bottom: 16px" v-hasPermi="['system:file:upload']">上传文件</a-button>
      </a-upload>

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
        :scroll="{ x: 900 }"
      >
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'fileSize'">
            {{ formatFileSize(record.fileSize) }}
          </template>
          <template v-if="column.key === 'action'">
            <a-space>
              <a @click="handleDownload(record)">
                <DownloadOutlined /> 下载
              </a>
              <a @click="handleDelete(record)" style="color: #ff4d4f" v-hasPermi="['system:file:remove']">
                <DeleteOutlined /> 删除
              </a>
            </a-space>
          </template>
        </template>
      </a-table>
    </a-card>
  </div>
</template>
