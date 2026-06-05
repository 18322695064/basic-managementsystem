<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listUser, addUser, updateUser, delUser, resetUserPwd, getUser, downloadUserTemplate, importUser } from '@/api/user'
import { getRoleOptions } from '@/api/role'
import { getDeptOptions } from '@/api/dept'
import { message, Modal, Upload } from 'ant-design-vue'

const loading = ref(false)
const dataSource = ref([])
const total = ref(0)
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  username: '',
  nickname: '',
  status: ''
})

const visible = ref(false)
const roleOptions = ref([])
const deptOptions = ref([])
const form = reactive({
  id: undefined,
  accountNumber: '',
  nickName: '',
  password: '',
  email: '',
  phoneNumber: '',
  activateStatus: '1',
  departmentId: '',
  roleIds: []
})
const formRules = {
  accountNumber: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  nickName: [{ required: true, message: '请输入昵称', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

const columns = [
  { title: '用户编号', dataIndex: 'id', width: 80 },
  { title: '用户名', dataIndex: 'accountNumber', width: 120 },
  { title: '昵称', dataIndex: 'nickName', width: 120 },
  { title: '部门', dataIndex: 'deptName', width: 120 },
  { title: '手机号', dataIndex: 'phoneNumber', width: 120 },
  { title: '状态', dataIndex: 'activateStatus', width: 80 },
  { title: '创建时间', dataIndex: 'addTime', width: 180 },
  { title: '操作', key: 'action', width: 250, fixed: 'right' }
]

const getList = async () => {
  loading.value = true
  try {
    const res = await listUser(queryParams)
    dataSource.value = res.data.rows || []
    total.value = res.data.total || 0
  } finally {
    loading.value = false
  }
}

const loadRoleOptions = async () => {
  try {
    const res = await getRoleOptions()
    roleOptions.value = res.data || []
  } catch (e) {
    console.error('加载角色列表失败', e)
  }
}

const loadDeptOptions = async () => {
  try {
    const res = await getDeptOptions()
    const list = res.data || []
    deptOptions.value = buildDeptTree(list)
  } catch (e) {
    console.error('加载部门列表失败', e)
  }
}

const buildDeptTree = (list) => {
  if (!list || list.length === 0) return []
  const map = {}
  const tree = []
  list.forEach(item => { map[item.id] = { ...item, children: [] } })
  list.forEach(item => {
    if (item.superOrg && map[item.superOrg]) {
      map[item.superOrg].children.push(map[item.id])
    } else {
      tree.push(map[item.id])
    }
  })
  return tree
}

const handleAdd = () => {
  Object.assign(form, { id: undefined, accountNumber: '', nickName: '', password: '', email: '', phoneNumber: '', activateStatus: '1', departmentId: '', roleIds: [] })
  visible.value = true
}

const handleEdit = async (record) => {
  try {
    const res = await getUser(record.id)
    const user = res.data
    Object.assign(form, { 
      ...record, 
      password: '',
      roleIds: user.roleIds || []
    })
    visible.value = true
  } catch (e) {
    message.error('获取用户信息失败')
  }
}

const handleDelete = (record) => {
  Modal.confirm({
    title: '确认删除',
    content: `确定要删除用户 ${record.nickName} 吗？`,
    okText: '确定',
    cancelText: '取消',
    onOk: async () => {
      await delUser(record.id)
      message.success('删除成功')
      getList()
    }
  })
}

const handleResetPwd = (record) => {
  Modal.confirm({
    title: '重置密码',
    content: `确定要重置用户【${record.nickName}】的密码吗？密码将重置为 123456`,
    okText: '确定',
    cancelText: '取消',
    onOk: async () => {
      await resetUserPwd(record.id, '123456')
      message.success('密码已重置为 123456')
    }
  })
}

const handleSubmit = async () => {
  if (form.id) {
    await updateUser(form)
    message.success('修改成功')
  } else {
    await addUser(form)
    message.success('新增成功')
  }
  visible.value = false
  getList()
}

const handleExport = () => {
  window.open('/api/system/user/export?' + new URLSearchParams({
    username: queryParams.username || '',
    nickname: queryParams.nickname || '',
    status: queryParams.status || ''
  }).toString(), '_blank')
}

const importVisible = ref(false)
const importFile = ref(null)

const handleDownloadTemplate = async () => {
  try {
    const res = await downloadUserTemplate()
    const blob = new Blob([res], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = '用户导入模板.xlsx'
    a.click()
    URL.revokeObjectURL(url)
  } catch (e) {
    message.error('下载模板失败')
  }
}

const handleImport = async () => {
  if (!importFile.value) {
    message.warning('请选择文件')
    return
  }
  const formData = new FormData()
  formData.append('file', importFile.value)
  try {
    const res = await importUser(formData)
    message.success(res.msg || '导入完成')
    importVisible.value = false
    importFile.value = null
    getList()
  } catch (e) {
    message.error('导入失败')
  }
}

const handleSearch = () => {
  queryParams.pageNum = 1
  getList()
}

const handleReset = () => {
  queryParams.username = ''
  queryParams.nickname = ''
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
  loadRoleOptions()
  loadDeptOptions()
})
</script>

<template>
  <div>
    <a-card>
      <a-form layout="inline" style="margin-bottom: 16px">
        <a-form-item label="用户名">
          <a-input v-model:value="queryParams.username" placeholder="请输入用户名" allow-clear />
        </a-form-item>
        <a-form-item label="昵称">
          <a-input v-model:value="queryParams.nickname" placeholder="请输入昵称" allow-clear />
        </a-form-item>
        <a-form-item label="状态">
          <a-select v-model:value="queryParams.status" placeholder="请选择" allow-clear style="width: 120px">
            <a-select-option value="1">正常</a-select-option>
            <a-select-option value="2">停用</a-select-option>
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
        <a-button type="primary" @click="handleAdd" v-hasPermi="['system:user:add']">新增</a-button>
        <a-button @click="handleExport" v-hasPermi="['system:user:export']">导出</a-button>
        <a-button @click="importVisible = true" v-hasPermi="['system:user:import']">导入</a-button>
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
          <template v-if="column.dataIndex === 'activateStatus'">
            <a-tag :color="record.activateStatus === '1' ? 'green' : 'red'">
              {{ record.activateStatus === '1' ? '正常' : '停用' }}
            </a-tag>
          </template>
          <template v-if="column.key === 'action'">
            <a-space>
              <a @click="handleEdit(record)" v-hasPermi="['system:user:edit']">修改</a>
              <a @click="handleDelete(record)" style="color: #ff4d4f" v-hasPermi="['system:user:remove']">删除</a>
              <a @click="handleResetPwd(record)" v-hasPermi="['system:user:resetPwd']">重置密码</a>
            </a-space>
          </template>
        </template>
      </a-table>
    </a-card>

    <a-modal v-model:open="visible" :title="form.id ? '修改用户' : '新增用户'" @ok="handleSubmit" :width="600" okText="确定" cancelText="取消">
      <a-form :model="form" :rules="formRules" :label-col="{ span: 4 }">
        <a-form-item label="用户名" name="accountNumber">
          <a-input v-model:value="form.accountNumber" :disabled="!!form.id" placeholder="请输入用户名" />
        </a-form-item>
        <a-form-item label="昵称" name="nickName">
          <a-input v-model:value="form.nickName" placeholder="请输入昵称" />
        </a-form-item>
        <a-form-item v-if="!form.id" label="密码" name="password">
          <a-input-password v-model:value="form.password" placeholder="请输入密码" />
        </a-form-item>
        <a-form-item label="手机号">
          <a-input v-model:value="form.phoneNumber" placeholder="请输入手机号" />
        </a-form-item>
        <a-form-item label="邮箱">
          <a-input v-model:value="form.email" placeholder="请输入邮箱" />
        </a-form-item>
        <a-form-item label="角色">
          <a-select v-model:value="form.roleIds" mode="multiple" placeholder="请选择角色">
            <a-select-option v-for="r in roleOptions" :key="r.id" :value="r.id">{{ r.roleName }}</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="部门">
          <a-tree-select
            v-model:value="form.departmentId"
            placeholder="请选择部门"
            :tree-data="deptOptions"
            :field-names="{ children: 'children', label: 'orgName', value: 'id', key: 'id' }"
            allow-clear
          />
        </a-form-item>
        <a-form-item label="状态">
          <a-radio-group v-model:value="form.activateStatus">
            <a-radio value="1">正常</a-radio>
            <a-radio value="2">停用</a-radio>
          </a-radio-group>
        </a-form-item>
      </a-form>
    </a-modal>

    <a-modal v-model:open="importVisible" title="导入用户" okText="开始导入" cancelText="取消" @ok="handleImport">
      <a-space direction="vertical" style="width: 100%">
        <a-button @click="handleDownloadTemplate">下载模板</a-button>
        <input type="file" accept=".xlsx,.xls" @change="e => importFile = e.target.files[0]" />
      </a-space>
    </a-modal>
  </div>
</template>
