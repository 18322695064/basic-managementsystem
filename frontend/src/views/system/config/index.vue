<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listConfig, addConfig, updateConfig, delConfig } from '@/api/config'
import { message, Modal } from 'ant-design-vue'

const loading = ref(false)
const dataSource = ref([])
const total = ref(0)
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  configName: '',
  configKey: '',
  configType: ''
})

const visible = ref(false)
const form = reactive({
  id: undefined,
  configName: '',
  configKey: '',
  configValue: '',
  configType: 'N',
  remark: ''
})

const columns = [
  { title: '参数编号', dataIndex: 'id', width: 80 },
  { title: '参数名称', dataIndex: 'configName', width: 180 },
  { title: '参数键名', dataIndex: 'configKey', width: 200 },
  { title: '参数键值', dataIndex: 'configValue', width: 150 },
  { title: '系统内置', dataIndex: 'configType', width: 100 },
  { title: '创建时间', dataIndex: 'createTime', width: 180 },
  { title: '操作', key: 'action', width: 150, fixed: 'right' }
]

const getList = async () => {
  loading.value = true
  try {
    const res = await listConfig(queryParams)
    dataSource.value = res.data.rows || []
    total.value = res.data.total || 0
  } finally {
    loading.value = false
  }
}

const handleAdd = () => {
  Object.assign(form, { id: undefined, configName: '', configKey: '', configValue: '', configType: 'N', remark: '' })
  visible.value = true
}

const handleEdit = (record) => {
  Object.assign(form, record)
  visible.value = true
}

const handleDelete = (record) => {
  Modal.confirm({
    title: '确认删除',
    content: `确定要删除参数 ${record.configName} 吗？`,
    okText: '确定',
    cancelText: '取消',
    onOk: async () => {
      await delConfig(record.id)
      message.success('删除成功')
      getList()
    }
  })
}

const handleSubmit = async () => {
  if (form.id) {
    await updateConfig(form)
    message.success('修改成功')
  } else {
    await addConfig(form)
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
  queryParams.configName = ''
  queryParams.configKey = ''
  queryParams.configType = ''
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
        <a-form-item label="参数名称">
          <a-input v-model:value="queryParams.configName" placeholder="请输入参数名称" allow-clear />
        </a-form-item>
        <a-form-item label="参数键名">
          <a-input v-model:value="queryParams.configKey" placeholder="请输入参数键名" allow-clear />
        </a-form-item>
        <a-form-item>
          <a-space>
            <a-button type="primary" @click="handleSearch">搜索</a-button>
            <a-button @click="handleReset">重置</a-button>
          </a-space>
        </a-form-item>
      </a-form>

      <a-space style="margin-bottom: 16px">
        <a-button type="primary" @click="handleAdd" v-hasPermi="['system:config:add']">新增</a-button>
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
        :scroll="{ x: 1000 }"
      >
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'configType'">
            <a-tag :color="record.configType === 'Y' ? 'blue' : 'default'">
              {{ record.configType === 'Y' ? '是' : '否' }}
            </a-tag>
          </template>
          <template v-if="column.key === 'action'">
            <a-space>
              <a @click="handleEdit(record)" v-hasPermi="['system:config:edit']">修改</a>
              <a @click="handleDelete(record)" style="color: #ff4d4f" v-hasPermi="['system:config:remove']">删除</a>
            </a-space>
          </template>
        </template>
      </a-table>
    </a-card>

    <a-modal v-model:open="visible" :title="form.id ? '修改参数' : '新增参数'" @ok="handleSubmit" :width="500" okText="确定" cancelText="取消">
      <a-form :model="form" :label-col="{ span: 4 }">
        <a-form-item label="参数名称" required>
          <a-input v-model:value="form.configName" placeholder="请输入参数名称" />
        </a-form-item>
        <a-form-item label="参数键名" required>
          <a-input v-model:value="form.configKey" placeholder="请输入参数键名" />
        </a-form-item>
        <a-form-item label="参数键值" required>
          <a-input v-model:value="form.configValue" placeholder="请输入参数键值" />
        </a-form-item>
        <a-form-item label="系统内置">
          <a-radio-group v-model:value="form.configType">
            <a-radio value="Y">是</a-radio>
            <a-radio value="N">否</a-radio>
          </a-radio-group>
        </a-form-item>
        <a-form-item label="备注">
          <a-textarea v-model:value="form.remark" placeholder="请输入备注" />
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>
