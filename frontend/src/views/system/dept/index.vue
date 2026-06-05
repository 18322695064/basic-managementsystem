<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listDept, addDept, updateDept, delDept, downloadDeptTemplate, importDept } from '@/api/dept'
import { message, Modal } from 'ant-design-vue'

const loading = ref(false)
const dataSource = ref([])
const queryParams = reactive({
  deptName: '',
  status: ''
})

const visible = ref(false)
const form = reactive({
  id: undefined,
  orgName: '',
  orgAddress: '',
  orgDuty: '',
  superOrg: '',
  grade: '',
  cityCode: '',
  remark: ''
})

const columns = [
  { title: '组织名称', dataIndex: 'orgName', width: 200 },
  { title: '地址', dataIndex: 'orgAddress', width: 180 },
  // { title: '职责', dataIndex: 'orgDuty', width: 150 },
  { title: '级别', dataIndex: 'grade', width: 100 },
  { title: '创建时间', dataIndex: 'createTime', width: 180 },
  { title: '操作', key: 'action', width: 200, fixed: 'right' }
]

const getList = async () => {
  loading.value = true
  try {
    const res = await listDept(queryParams)
    dataSource.value = buildTree(res.data || [])
  } finally {
    loading.value = false
  }
}

const buildTree = (list) => {
  const map = {}
  const tree = []
  list.forEach(item => {
    map[item.id] = { ...item, children: [] }
  })
  list.forEach(item => {
    if (item.superOrg && map[item.superOrg]) {
      map[item.superOrg].children.push(map[item.id])
    } else {
      tree.push(map[item.id])
    }
  })
  return tree
}

const handleAdd = (superOrg = '') => {
  Object.assign(form, { id: undefined, orgName: '', orgAddress: '', orgDuty: '', superOrg, grade: '', cityCode: '', remark: '' })
  visible.value = true
}

const handleEdit = (record) => {
  Object.assign(form, record)
  visible.value = true
}

const handleDelete = (record) => {
  Modal.confirm({
    title: '确认删除',
    content: `确定要删除组织 ${record.orgName} 吗？`,
    okText: '确定',
    cancelText: '取消',
    onOk: async () => {
      await delDept(record.id)
      message.success('删除成功')
      getList()
    }
  })
}

const handleSubmit = async () => {
  if (form.id) {
    await updateDept(form)
    message.success('修改成功')
  } else {
    await addDept(form)
    message.success('新增成功')
  }
  visible.value = false
  getList()
    }

const importVisible = ref(false)
const importFile = ref(null)

// const handleDownloadTemplate = async () => {
//   try {
//     const res = await downloadDeptTemplate()
//     const blob = new Blob([res], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' })
//     const url = URL.createObjectURL(blob)
//     const a = document.createElement('a')
//     a.href = url
//     a.download = '组织导入模板.xlsx'
//     a.click()
//     URL.revokeObjectURL(url)
//   } catch (e) {
//     message.error('下载模板失败')
//   }
// }

// const handleImport = async () => {
//   if (!importFile.value) {
//     message.warning('请选择文件')
//     return
//   }
//   const formData = new FormData()
//   formData.append('file', importFile.value)
//   try {
//     const res = await importDept(formData)
//     message.success(res.msg || '导入完成')
//     importVisible.value = false
//     importFile.value = null
//     getList()
//   } catch (e) {
//     message.error('导入失败')
//   }
// }

const handleSearch = () => {
  getList()
}

const handleReset = () => {
  queryParams.deptName = ''
  queryParams.status = ''
  handleSearch()
}

onMounted(() => {
  getList()
})
</script>

<template>
  <div>
    <a-card>
      <a-form layout="inline" style="margin-bottom: 16px">
        <a-form-item label="组织名称">
          <a-input v-model:value="queryParams.deptName" placeholder="请输入组织名称" allow-clear />
        </a-form-item>
        <a-form-item>
          <a-space>
            <a-button type="primary" @click="handleSearch">搜索</a-button>
            <a-button @click="handleReset">重置</a-button>
          </a-space>
        </a-form-item>
      </a-form>

      <a-space style="margin-bottom: 16px">
        <a-button type="primary" @click="handleAdd()" v-hasPermi="['system:dept:add']">新增</a-button>
        <!-- <a-button @click="importVisible = true" v-hasPermi="['system:dept:import']">导入</a-button> -->
      </a-space>

      <a-table
        :columns="columns"
        :data-source="dataSource"
        :loading="loading"
        :pagination="false"
        row-key="id"
        :scroll="{ x: 1000 }"
        childrenColumnName="children"
      >
        <template #bodyCell="{ column, record }">
          <template v-if="column.key === 'action'">
            <a-space>
              <a @click="handleAdd(record.id)" v-hasPermi="['system:dept:add']">新增</a>
              <a @click="handleEdit(record)" v-hasPermi="['system:dept:edit']">修改</a>
              <a @click="handleDelete(record)" style="color: #ff4d4f" v-hasPermi="['system:dept:remove']">删除</a>
            </a-space>
          </template>
        </template>
      </a-table>
    </a-card>

    <a-modal v-model:open="visible" :title="form.id ? '修改组织' : '新增组织'" @ok="handleSubmit" :width="600" okText="确定" cancelText="取消">
      <a-form :model="form" :label-col="{ span: 4 }">
        <a-form-item label="组织名称" required>
          <a-input v-model:value="form.orgName" placeholder="请输入组织名称" />
        </a-form-item>
        <a-form-item label="地址">
          <a-input v-model:value="form.orgAddress" placeholder="请输入地址" />
        </a-form-item>
        <!--<a-form-item label="职责">
          <a-input v-model:value="form.orgDuty" placeholder="请输入职责" />
        </a-form-item>-->
        <a-form-item label="级别">
          <a-input v-model:value="form.grade" placeholder="请输入级别" />
        </a-form-item>
        <!--<a-form-item label="城市编码">
          <a-input v-model:value="form.cityCode" placeholder="请输入城市编码" />
        </a-form-item>-->
        <a-form-item label="备注">
          <a-textarea v-model:value="form.remark" placeholder="请输入备注" />
        </a-form-item>
      </a-form>
    </a-modal>

    <!-- <a-modal v-model:open="importVisible" title="导入组织" okText="开始导入" cancelText="取消" @ok="handleImport">
      <a-space direction="vertical" style="width: 100%">
        <a-button @click="handleDownloadTemplate">下载模板</a-button>
        <input type="file" accept=".xlsx,.xls" @change="e => importFile = e.target.files[0]" />
      </a-space>
    </a-modal> -->
  </div>
</template>
