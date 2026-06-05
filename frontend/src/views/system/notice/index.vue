<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listNotice, addNotice, updateNotice, delNotice } from '@/api/notice'
import { message, Modal } from 'ant-design-vue'

const loading = ref(false)
const dataSource = ref([])
const total = ref(0)
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  noticeTitle: '',
  noticeType: ''
})

const visible = ref(false)
const form = reactive({
  id: undefined,
  noticeTitle: '',
  noticeType: '1',
  noticeContent: '',
  status: '0'
})

const columns = [
  { title: '序号', dataIndex: 'id', width: 80 },
  { title: '公告标题', dataIndex: 'noticeTitle', width: 200 },
  { title: '公告类型', dataIndex: 'noticeType', width: 100 },
  { title: '状态', dataIndex: 'status', width: 80 },
  { title: '创建者', dataIndex: 'createBy', width: 100 },
  { title: '创建时间', dataIndex: 'createTime', width: 180 },
  { title: '操作', key: 'action', width: 150, fixed: 'right' }
]

const noticeTypeMap = { '1': '通知', '2': '公告' }

const getList = async () => {
  loading.value = true
  try {
    const res = await listNotice(queryParams)
    dataSource.value = res.data.rows || []
    total.value = res.data.total || 0
  } finally {
    loading.value = false
  }
}

const handleAdd = () => {
  Object.assign(form, { id: undefined, noticeTitle: '', noticeType: '1', noticeContent: '', status: '0' })
  visible.value = true
}

const handleEdit = (record) => {
  Object.assign(form, record)
  visible.value = true
}

const handleDelete = (record) => {
  Modal.confirm({
    title: '确认删除',
    content: `确定要删除公告 ${record.noticeTitle} 吗？`,
    okText: '确定',
    cancelText: '取消',
    onOk: async () => {
      await delNotice(record.id)
      message.success('删除成功')
      getList()
    }
  })
}

const handleSubmit = async () => {
  if (form.id) {
    await updateNotice(form)
    message.success('修改成功')
  } else {
    await addNotice(form)
    message.success('新增成功')
  }
  visible.value = false
  getList()
}

const handleSearch = () => {
  queryParams.pageNum = 1
  getList()
}

const handleReset = () => {
  queryParams.noticeTitle = ''
  queryParams.noticeType = ''
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
        <a-form-item label="公告标题">
          <a-input v-model:value="queryParams.noticeTitle" placeholder="请输入公告标题" allow-clear />
        </a-form-item>
        <a-form-item label="类型">
          <a-select v-model:value="queryParams.noticeType" placeholder="请选择" allow-clear style="width: 120px">
            <a-select-option value="1">通知</a-select-option>
            <a-select-option value="2">公告</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item>
          <a-space>
            <a-button type="primary" @click="handleSearch">搜索</a-button>
            <a-button @click="handleReset">重置</a-button>
          </a-space>
        </a-form-item>
      </a-form>

      <a-space style="margin-bottom: 16px">
        <a-button type="primary" @click="handleAdd" v-hasPermi="['system:notice:add']">新增</a-button>
      </a-space>

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
        :scroll="{ x: 900 }"
      >
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'noticeType'">
            <a-tag>{{ noticeTypeMap[record.noticeType] || record.noticeType }}</a-tag>
          </template>
          <template v-if="column.dataIndex === 'status'">
            <a-tag :color="record.status === '0' ? 'green' : 'red'">
              {{ record.status === '0' ? '正常' : '关闭' }}
            </a-tag>
          </template>
          <template v-if="column.key === 'action'">
            <a-space>
              <a @click="handleEdit(record)" v-hasPermi="['system:notice:edit']">修改</a>
              <a @click="handleDelete(record)" style="color: #ff4d4f" v-hasPermi="['system:notice:remove']">删除</a>
            </a-space>
          </template>
        </template>
      </a-table>
    </a-card>

    <a-modal v-model:open="visible" :title="form.id ? '修改公告' : '新增公告'" @ok="handleSubmit" :width="600" okText="确定" cancelText="取消">
      <a-form :model="form" :label-col="{ span: 4 }">
        <a-form-item label="公告标题" required>
          <a-input v-model:value="form.noticeTitle" placeholder="请输入公告标题" />
        </a-form-item>
        <a-form-item label="公告类型" required>
          <a-radio-group v-model:value="form.noticeType">
            <a-radio value="1">通知</a-radio>
            <a-radio value="2">公告</a-radio>
          </a-radio-group>
        </a-form-item>
        <a-form-item label="内容">
          <a-textarea v-model:value="form.noticeContent" placeholder="请输入内容" :rows="6" />
        </a-form-item>
        <a-form-item label="状态">
          <a-radio-group v-model:value="form.status">
            <a-radio value="0">正常</a-radio>
            <a-radio value="1">关闭</a-radio>
          </a-radio-group>
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>
