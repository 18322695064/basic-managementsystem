<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listDictType, addDictType, updateDictType, delDictType, listDictData, addDictData, updateDictData, delDictData } from '@/api/dict'
import { message, Modal } from 'ant-design-vue'

const loading = ref(false)
const dataSource = ref([])
const total = ref(0)
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  dictName: '',
  dictType: '',
  status: ''
})

const visible = ref(false)
const form = reactive({
  id: undefined,
  dictName: '',
  dictType: '',
  status: '0',
  remark: ''
})

const dictDataVisible = ref(false)
const dictDataList = ref([])
const currentDictType = ref('')
const dictDataFormVisible = ref(false)
const dictDataForm = reactive({
  id: undefined,
  dictType: '',
  dictLabel: '',
  dictValue: '',
  dictSort: 0,
  isDefault: 'N',
  status: '0'
})

const columns = [
  { title: '字典编号', dataIndex: 'id', width: 80 },
  { title: '字典名称', dataIndex: 'dictName', width: 150 },
  { title: '字典类型', dataIndex: 'dictType', width: 180 },
  { title: '状态', dataIndex: 'status', width: 80 },
  { title: '创建时间', dataIndex: 'createTime', width: 180 },
  { title: '操作', key: 'action', width: 200, fixed: 'right' }
]

const dictDataColumns = [
  { title: '标签', dataIndex: 'dictLabel', width: 120 },
  { title: '值', dataIndex: 'dictValue', width: 120 },
  { title: '排序', dataIndex: 'dictSort', width: 80 },
  { title: '状态', dataIndex: 'status', width: 80 },
  { title: '操作', key: 'action', width: 120 }
]

const getList = async () => {
  loading.value = true
  try {
    const res = await listDictType(queryParams)
    dataSource.value = res.data.rows || []
    total.value = res.data.total || 0
  } finally {
    loading.value = false
  }
}

const handleAdd = () => {
  Object.assign(form, { id: undefined, dictName: '', dictType: '', status: '0', remark: '' })
  visible.value = true
}

const handleEdit = (record) => {
  Object.assign(form, record)
  visible.value = true
}

const handleDelete = (record) => {
  Modal.confirm({
    title: '确认删除',
    content: `确定要删除字典 ${record.dictName} 吗？`,
    okText: '确定',
    cancelText: '取消',
    onOk: async () => {
      await delDictType(record.id)
      message.success('删除成功')
      getList()
    }
  })
}

const handleSubmit = async () => {
  if (form.id) {
    await updateDictType(form)
    message.success('修改成功')
  } else {
    await addDictType(form)
    message.success('新增成功')
  }
  visible.value = false
  getList()
}

const handleDictData = async (record) => {
  currentDictType.value = record.dictType
  dictDataVisible.value = true
  const res = await listDictData({ dictType: record.dictType, pageNum: 1, pageSize: 100 })
  dictDataList.value = res.data.rows || []
}

const handleAddDictData = () => {
  Object.assign(dictDataForm, { id: undefined, dictType: currentDictType.value, dictLabel: '', dictValue: '', dictSort: 0, isDefault: 'N', status: '0' })
  dictDataFormVisible.value = true
}

const handleEditDictData = (record) => {
  Object.assign(dictDataForm, record)
  dictDataFormVisible.value = true
}

const handleDeleteDictData = async (record) => {
  await delDictData(record.id)
  message.success('删除成功')
  handleDictData({ dictType: currentDictType.value })
}

const handleDictDataSubmit = async () => {
  if (dictDataForm.id) {
    await updateDictData(dictDataForm)
    message.success('修改成功')
  } else {
    await addDictData(dictDataForm)
    message.success('新增成功')
  }
  dictDataFormVisible.value = false
  handleDictData({ dictType: currentDictType.value })
}

const handleSearch = () => {
  queryParams.pageNum = 1
  getList()
}

const handleReset = () => {
  queryParams.dictName = ''
  queryParams.dictType = ''
  queryParams.status = ''
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
        <a-form-item label="字典名称">
          <a-input v-model:value="queryParams.dictName" placeholder="请输入字典名称" allow-clear />
        </a-form-item>
        <a-form-item label="字典类型">
          <a-input v-model:value="queryParams.dictType" placeholder="请输入字典类型" allow-clear />
        </a-form-item>
        <a-form-item>
          <a-space>
            <a-button type="primary" @click="handleSearch">搜索</a-button>
            <a-button @click="handleReset">重置</a-button>
          </a-space>
        </a-form-item>
      </a-form>

      <a-space style="margin-bottom: 16px">
        <a-button type="primary" @click="handleAdd" v-hasPermi="['system:dict:add']">新增</a-button>
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
          <template v-if="column.dataIndex === 'status'">
            <a-tag :color="record.status === '0' ? 'green' : 'red'">
              {{ record.status === '0' ? '正常' : '停用' }}
            </a-tag>
          </template>
          <template v-if="column.key === 'action'">
            <a-space>
              <a @click="handleDictData(record)">数据</a>
              <a @click="handleEdit(record)" v-hasPermi="['system:dict:edit']">修改</a>
              <a @click="handleDelete(record)" style="color: #ff4d4f" v-hasPermi="['system:dict:remove']">删除</a>
            </a-space>
          </template>
        </template>
      </a-table>
    </a-card>

    <a-modal v-model:open="visible" :title="form.id ? '修改字典' : '新增字典'" @ok="handleSubmit" :width="500" okText="确定" cancelText="取消">
      <a-form :model="form" :label-col="{ span: 4 }">
        <a-form-item label="字典名称" required>
          <a-input v-model:value="form.dictName" placeholder="请输入字典名称" />
        </a-form-item>
        <a-form-item label="字典类型" required>
          <a-input v-model:value="form.dictType" :disabled="!!form.id" placeholder="请输入字典类型" />
        </a-form-item>
        <a-form-item label="状态">
          <a-radio-group v-model:value="form.status">
            <a-radio value="0">正常</a-radio>
            <a-radio value="1">停用</a-radio>
          </a-radio-group>
        </a-form-item>
        <a-form-item label="备注">
          <a-textarea v-model:value="form.remark" placeholder="请输入备注" />
        </a-form-item>
      </a-form>
    </a-modal>

    <a-drawer v-model:open="dictDataVisible" title="字典数据" :width="600">
      <a-button type="primary" @click="handleAddDictData" style="margin-bottom: 16px">新增</a-button>
      <a-table :columns="dictDataColumns" :data-source="dictDataList" row-key="id" size="small">
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'status'">
            <a-tag :color="record.status === '0' ? 'green' : 'red'">
              {{ record.status === '0' ? '正常' : '停用' }}
            </a-tag>
          </template>
          <template v-if="column.key === 'action'">
            <a-space>
              <a @click="handleEditDictData(record)">修改</a>
              <a @click="handleDeleteDictData(record)" style="color: #ff4d4f">删除</a>
            </a-space>
          </template>
        </template>
      </a-table>
      <a-modal v-model:open="dictDataFormVisible" title="字典数据" @ok="handleDictDataSubmit" :width="400" okText="确定" cancelText="取消">
        <a-form :model="dictDataForm" :label-col="{ span: 4 }">
          <a-form-item label="标签" required>
            <a-input v-model:value="dictDataForm.dictLabel" placeholder="请输入标签" />
          </a-form-item>
          <a-form-item label="值" required>
            <a-input v-model:value="dictDataForm.dictValue" placeholder="请输入值" />
          </a-form-item>
          <a-form-item label="排序">
            <a-input-number v-model:value="dictDataForm.dictSort" :min="0" style="width: 100%" />
          </a-form-item>
          <a-form-item label="状态">
            <a-radio-group v-model:value="dictDataForm.status">
              <a-radio value="0">正常</a-radio>
              <a-radio value="1">停用</a-radio>
            </a-radio-group>
          </a-form-item>
        </a-form>
      </a-modal>
    </a-drawer>
  </div>
</template>
