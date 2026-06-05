<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listTable, getTableInfo, previewCode, generateCode, createTable, updateTable } from '@/api/gen'
import { message, Modal } from 'ant-design-vue'

const loading = ref(false)
const tableList = ref([])
const total = ref(0)
const queryParams = reactive({
  tableName: '',
  pageNum: 1,
  pageSize: 10
})

const selectedTable = ref(null)
const columnVisible = ref(false)
const columns = ref([])
const tableComment = ref('')

const previewVisible = ref(false)
const previewData = ref({})
const previewKeys = [
  { key: 'entity', label: 'Entity.java' },
  { key: 'mapper', label: 'Mapper.java' },
  { key: 'service', label: 'Service.java' },
  { key: 'serviceImpl', label: 'ServiceImpl.java' },
  { key: 'controller', label: 'Controller.java' },
  { key: 'vue', label: 'index.vue' },
  { key: 'api', label: 'API.js' },
  { key: 'sql', label: 'Menu.sql' }
]
const activePreviewKey = ref('entity')

const tableColumns = [
  { title: '表名', dataIndex: 'tableName', width: 200 },
  { title: '备注', dataIndex: 'tableComment', ellipsis: true },
  { title: '操作', key: 'action', width: 360, fixed: 'right' }
]

const columnCols = [
  { title: '列名', dataIndex: 'columnName', width: 150 },
  { title: '类型', dataIndex: 'columnType', width: 150 },
  { title: 'Java类型', dataIndex: 'javaType', width: 120 },
  { title: 'Java属性', dataIndex: 'javaField', width: 150 },
  { title: '可空', dataIndex: 'isNullable', width: 80 },
  { title: '备注', dataIndex: 'columnComment', ellipsis: true }
]

const formVisible = ref(false)
const formTitle = ref('')
const isEdit = ref(false)
const form = reactive({
  tableName: '',
  tableComment: '',
  columns: []
})

const columnTypeOptions = [
  { value: 'varchar', label: 'varchar' },
  { value: 'text', label: 'text' },
  { value: 'integer', label: 'integer' },
  { value: 'bigint', label: 'bigint' },
  { value: 'smallint', label: 'smallint' },
  { value: 'boolean', label: 'boolean' },
  { value: 'numeric', label: 'numeric' },
  { value: 'timestamp', label: 'timestamp' },
  { value: 'date', label: 'date' },
  { value: 'double', label: 'double precision' }
]

const blankColumn = () => ({
  columnName: '',
  columnType: 'varchar',
  length: null,
  isNullable: 'YES',
  defaultValue: '',
  comment: ''
})

const getList = async () => {
  loading.value = true
  try {
    const res = await listTable(queryParams)
    tableList.value = res.data.rows || []
    total.value = res.data.total || 0
  } finally {
    loading.value = false
  }
}

const handleSearch = () => { queryParams.pageNum = 1; getList() }
const handleReset = () => { queryParams.tableName = ''; handleSearch() }

const handleTableChange = (pagination) => {
  queryParams.pageNum = pagination.current
  queryParams.pageSize = pagination.pageSize
  getList()
}

const handleView = async (record) => {
  selectedTable.value = record.tableName
  try {
    const res = await getTableInfo(record.tableName)
    columns.value = res.data.columns || []
    tableComment.value = res.data.tableComment || ''
    columnVisible.value = true
  } catch { message.error('获取表结构失败') }
}

const handleAdd = () => {
  isEdit.value = false
  formTitle.value = '新增表'
  form.tableName = ''
  form.tableComment = ''
  form.columns = [blankColumn()]
  formVisible.value = true
}

const handleEdit = async (record) => {
  isEdit.value = true
  formTitle.value = '修改表 - ' + record.tableName
  form.tableName = record.tableName
  try {
    const res = await getTableInfo(record.tableName)
    form.tableComment = res.data.tableComment || ''
    const existingCols = (res.data.columns || [])
      .filter(c => !['id','create_by','create_time','update_by','update_time','deleted'].includes(c.columnName))
      .map(c => ({
      columnName: c.columnName,
      columnType: c.columnType,
      length: c.charMaxLength || null,
      isNullable: c.isNullable === 'YES' ? 'YES' : 'NO',
      defaultValue: '',
      comment: c.columnComment || '',
      _existing: true
    }))
    form.columns = existingCols
    formVisible.value = true
  } catch { message.error('获取表结构失败') }
}

const addColumn = () => { form.columns.push(blankColumn()) }
const removeColumn = (idx) => {
  const col = form.columns[idx]
  if (col._existing) {
    col._action = 'drop'
  } else {
    form.columns.splice(idx, 1)
  }
}
const onColumnChange = (col) => {
  if (col._existing && col._action !== 'drop') {
    col._action = 'modify'
  }
}

const handleFormSubmit = async () => {
  if (!isEdit.value && (!form.tableName || !form.tableName.match(/^[a-zA-Z_][a-zA-Z0-9_]*$/))) {
    message.error('表名只能包含字母、数字和下划线，且不能以数字开头')
    return
  }
  if (isEdit.value) {
    const allCols = form.columns.filter(c => c.columnName)
    await updateTable(form.tableName, { tableComment: form.tableComment, columns: allCols })
    message.success('修改成功')
  } else {
    const validCols = form.columns.filter(c => c.columnName)
    const reserved = validCols.filter(c => ['id','create_by','create_time','update_by','update_time','deleted'].includes(c.columnName))
    if (reserved.length > 0) {
      message.error('列名不能使用保留字段: ' + reserved.map(c => c.columnName).join(', '))
      return
    }
    if (validCols.length === 0) {
      message.error('请至少添加一个列')
      return
    }
    await createTable({ tableName: form.tableName, tableComment: form.tableComment, columns: validCols })
    message.success('新增成功')
  }
  formVisible.value = false
  getList()
}

const handlePreview = async (record) => {
  try {
    const res = await previewCode(record.tableName)
    previewData.value = res.data || {}
    activePreviewKey.value = 'entity'
    previewVisible.value = true
  } catch { message.error('预览失败') }
}

const handleGenerate = async (record) => {
  try {
    const blob = await generateCode(record.tableName)
    const url = window.URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = 'codegen_' + record.tableName + '.zip'
    a.click()
    window.URL.revokeObjectURL(url)
    message.success('代码已生成，菜单权限已自动导入到 sys_menu 表')
  } catch { message.error('生成失败') }
}

onMounted(() => { getList() })
</script>

<template>
  <div>
    <a-card title="代码生成器">
      <a-form layout="inline" style="margin-bottom: 16px">
        <a-form-item label="表名">
          <a-input v-model:value="queryParams.tableName" placeholder="请输入表名" allow-clear style="width:200px" />
        </a-form-item>
        <a-form-item>
          <a-space>
            <a-button type="primary" @click="handleSearch">搜索</a-button>
            <a-button @click="handleReset">重置</a-button>
          </a-space>
        </a-form-item>
      </a-form>

      <a-space style="margin-bottom: 16px">
        <a-button type="primary" @click="handleAdd" v-hasPermi="['tool:gen:add']">新增</a-button>
      </a-space>

      <a-table
        :columns="tableColumns"
        :data-source="tableList"
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
        row-key="tableName"
        :scroll="{ x: 900 }"
      >
        <template #bodyCell="{ column, record }">
          <template v-if="column.key === 'action'">
            <a-space>
              <a @click="handleEdit(record)" v-hasPermi="['tool:gen:edit']">修改</a>
              <a @click="handleView(record)" v-hasPermi="['tool:gen:query']">查看结构</a>
              <a @click="handlePreview(record)" v-hasPermi="['tool:gen:preview']">预览代码</a>
              <a @click="handleGenerate(record)" v-hasPermi="['tool:gen:generate']" style="color:#1890ff">生成代码</a>
            </a-space>
          </template>
        </template>
      </a-table>
    </a-card>

    <a-modal v-model:open="columnVisible" :title="'表结构 - ' + (selectedTable || '')" :footer="null" :width="900">
      <a-descriptions v-if="tableComment" :column="1" style="margin-bottom:16px">
        <a-descriptions-item label="备注">{{ tableComment }}</a-descriptions-item>
      </a-descriptions>
      <a-table :columns="columnCols" :data-source="columns" :pagination="false" row-key="columnName" size="small" />
    </a-modal>

    <a-modal v-model:open="previewVisible" title="代码预览" :footer="null" :width="900">
      <a-tabs v-model:activeKey="activePreviewKey">
        <a-tab-pane v-for="item in previewKeys" :key="item.key" :tab="item.label">
          <div style="max-height:500px;overflow-y:auto;background:#1e1e1e;border-radius:4px;padding:12px">
            <pre style="margin:0;color:#d4d4d4;font-size:13px;line-height:1.5;white-space:pre-wrap;word-break:break-all">{{ previewData[item.key] || '' }}</pre>
          </div>
        </a-tab-pane>
      </a-tabs>
    </a-modal>

    <a-modal v-model:open="formVisible" :title="formTitle" @ok="handleFormSubmit" :width="750" okText="确定" cancelText="取消">
      <a-form :model="form" :label-col="{ span: 4 }">
        <a-form-item label="表名" required v-if="!isEdit">
          <a-input v-model:value="form.tableName" placeholder="如: sys_demo" :disabled="isEdit" />
        </a-form-item>
        <a-form-item label="备注">
          <a-input v-model:value="form.tableComment" placeholder="表注释" />
        </a-form-item>

        <a-form-item label="列定义">
          <a-alert type="info" show-icon style="margin-bottom:8px" message="以下字段由系统自动维护，请勿添加: id / create_by / create_time / update_by / update_time / deleted" />
          <div v-for="(col, idx) in form.columns" :key="idx" v-show="col._action !== 'drop'"
            :style="{ display:'flex',alignItems:'center',gap:'6px',marginBottom:'6px',padding:'4px',border:'1px solid '+ (col._existing ? '#d9d9d9' : '#f0f0f0'),borderRadius:'4px',background: col._existing ? '#fafafa' : 'transparent' }">
            <a-input v-model:value="col.columnName" placeholder="列名" size="small" style="width:100px" @change="onColumnChange(col)" />
            <a-select v-model:value="col.columnType" :options="columnTypeOptions" size="small" style="width:110px" @change="onColumnChange(col)" />
            <a-input-number v-model:value="col.length" placeholder="长度" size="small" style="width:70px" :min="0" @change="onColumnChange(col)" />
            <a-select v-model:value="col.isNullable" size="small" style="width:70px" @change="onColumnChange(col)">
              <a-select-option value="YES">可空</a-select-option>
              <a-select-option value="NO">必填</a-select-option>
            </a-select>
            <a-input v-model:value="col.defaultValue" placeholder="默认值" size="small" style="width:90px" @change="onColumnChange(col)" />
            <a-input v-model:value="col.comment" placeholder="备注" size="small" style="width:120px" @change="onColumnChange(col)" />
            <a-button size="small" danger @click="removeColumn(idx)">删</a-button>
          </div>
          <div v-for="(col, idx) in form.columns" :key="'drop-'+idx" v-show="col._action === 'drop'"
            style="display:flex;align-items:center;gap:6px;margin-bottom:6px;padding:4px;border:1px solid #ff4d4f;border-radius:4px;background:#fff2f0;text-decoration:line-through;color:#ff4d4f">
            <span style="width:100px">{{ col.columnName }}</span>
            <span style="width:110px">{{ col.columnType }}</span>
            <span style="flex:1;font-size:12px">将删除此列</span>
            <a-button size="small" @click="col._action = undefined">撤销</a-button>
          </div>
          <a-button type="dashed" size="small" @click="addColumn" block>+ 新增列</a-button>
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>
