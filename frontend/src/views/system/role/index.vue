<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listRole, getRole, addRole, updateRole, delRole, updateRoleMenuPerms, updateRoleDataScope } from '@/api/role'
import { listMenu } from '@/api/menu'
import { message, Modal } from 'ant-design-vue'

const loading = ref(false)
const dataSource = ref([])
const total = ref(0)
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  roleName: '',
  roleKey: '',
  status: ''
})

const visible = ref(false)
const form = reactive({
  id: undefined,
  roleName: '',
  roleCode: '',
  roleType: '',
  remarks: '',
  dataScope: '1'
})

const menuVisible = ref(false)
const menuList = ref([])
const checkedMenuIds = ref([])
const currentRole = ref({})

const columns = [
  { title: '角色编号', dataIndex: 'id', width: 200 },
  { title: '角色名称', dataIndex: 'roleName', width: 150 },
  { title: '角色编码', dataIndex: 'roleCode', width: 180 },
  { title: '角色类型', dataIndex: 'roleType', width: 100 },
  { title: '创建时间', dataIndex: 'createTime', width: 180 },
  { title: '操作', key: 'action', width: 250, fixed: 'right' }
]

const getList = async () => {
  loading.value = true
  try {
    const res = await listRole(queryParams)
    dataSource.value = res.data.rows || []
    total.value = res.data.total || 0
  } finally {
    loading.value = false
  }
}

const handleAdd = () => {
  Object.assign(form, { id: undefined, roleName: '', roleCode: '', roleType: '', remarks: '', dataScope: '1' })
  visible.value = true
}

const handleEdit = (record) => {
  Object.assign(form, record)
   visible.value = true
}

const handleDelete = (record) => {
  Modal.confirm({
    title: '确认删除',
    content: `确定要删除角色 ${record.roleName} 吗？`,
    okText: '确定',
    cancelText: '取消',
    onOk: async () => {
      await delRole(record.id)
      message.success('删除成功')
      getList()
    }
  })
}

const handleMenuPerm = async (record) => {
  currentRole.value = record
  try {
    const [menuRes, roleRes] = await Promise.all([
      listMenu({}),
      getRole(record.id)
    ])
    menuList.value = buildMenuTree(menuRes.data || [])
    checkedMenuIds.value = roleRes.data.menuIds || []
    menuVisible.value = true
  } catch (e) {
    message.error('加载菜单数据失败')
  }
}

const buildMenuTree = (list) => {
  const map = {}
  const tree = []
  list.forEach(item => { map[item.id] = { ...item, children: [] } })
  list.forEach(item => {
    if (item.parentId && map[item.parentId]) {
      map[item.parentId].children.push(map[item.id])
    } else {
      tree.push(map[item.id])
    }
  })
  return tree
}

const getAllMenuIds = (nodes) => {
  let ids = []
  for (const node of nodes) {
    ids.push(node.id)
    if (node.children && node.children.length > 0) {
      ids = ids.concat(getAllMenuIds(node.children))
    }
  }
  return ids
}

const handleCheckAll = (checked) => {
  if (checked) {
    checkedMenuIds.value = getAllMenuIds(menuList.value)
  } else {
    checkedMenuIds.value = []
  }
}

const handleMenuSubmit = async () => {
  await updateRoleMenuPerms({ id: currentRole.value.id, menuIds: checkedMenuIds.value })
  message.success('菜单权限设置成功')
  menuVisible.value = false
  getList()
}

const handleSubmit = async () => {
  if (form.id) {
    await updateRole(form)
    await updateRoleDataScope(form.id, form.dataScope)
    message.success('修改成功')
  } else {
    await addRole(form)
    const res = await listRole({ pageNum: 1, pageSize: 100 })
    const newRole = (res.data?.rows || []).find(r => r.roleCode === form.roleCode)
    if (newRole) {
      await updateRoleDataScope(newRole.id, form.dataScope)
    }
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
  queryParams.roleName = ''
  queryParams.roleKey = ''
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
        <a-form-item label="角色名称">
          <a-input v-model:value="queryParams.roleName" placeholder="请输入角色名称" allow-clear />
        </a-form-item>
        <a-form-item label="角色编码">
          <a-input v-model:value="queryParams.roleKey" placeholder="请输入角色编码" allow-clear />
        </a-form-item>
        <a-form-item>
          <a-space>
            <a-button type="primary" @click="handleSearch">搜索</a-button>
            <a-button @click="handleReset">重置</a-button>
          </a-space>
        </a-form-item>
      </a-form>

      <a-space style="margin-bottom: 16px">
        <a-button type="primary" @click="handleAdd" v-hasPermi="['system:role:add']">新增</a-button>
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
          <template v-if="column.key === 'action'">
            <a-space>
              <a @click="handleEdit(record)" v-hasPermi="['system:role:edit']">修改</a>
              <a @click="handleMenuPerm(record)" v-hasPermi="['system:role:edit']">菜单权限</a>
              <a @click="handleDelete(record)" style="color: #ff4d4f" v-hasPermi="['system:role:remove']">删除</a>
            </a-space>
          </template>
        </template>
      </a-table>
    </a-card>

    <a-modal v-model:open="visible" :title="form.id ? '修改角色' : '新增角色'" @ok="handleSubmit" :width="500" okText="确定" cancelText="取消">
      <a-form :model="form" :label-col="{ span: 4 }">
        <a-form-item label="角色名称" required>
          <a-input v-model:value="form.roleName" placeholder="请输入角色名称" />
        </a-form-item>
        <a-form-item label="角色编码" required>
          <a-input v-model:value="form.roleCode" placeholder="请输入角色编码" />
        </a-form-item>
        <a-form-item label="角色类型">
          <a-input v-model:value="form.roleType" placeholder="请输入角色类型" />
        </a-form-item>
        <a-form-item label="数据权限">
          <a-select v-model:value="form.dataScope" placeholder="请选择数据权限范围">
            <a-select-option value="1">全部数据</a-select-option>
            <a-select-option value="2">本部门数据</a-select-option>
            <a-select-option value="3">本部门及下级</a-select-option>
            <a-select-option value="4">仅本人</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="备注">
          <a-textarea v-model:value="form.remarks" placeholder="请输入备注" />
        </a-form-item>
      </a-form>
    </a-modal>

    <a-modal v-model:open="menuVisible" title="菜单权限 - {{ currentRole.roleName }}" @ok="handleMenuSubmit" :width="500" :destroy-on-close="true" okText="确定" cancelText="取消">
      <div style="margin-bottom: 12px">
        <a-checkbox :checked="checkedMenuIds.length === getAllMenuIds(menuList).length"
          @change="e => handleCheckAll(e.target.checked)">全选/全不选</a-checkbox>
      </div>
      <a-tree
        v-model:checkedKeys="checkedMenuIds"
        :field-names="{ key: 'id', title: 'menuName' }"
        :tree-data="menuList"
        checkable
        default-expand-all
      />
    </a-modal>
  </div>
</template>
