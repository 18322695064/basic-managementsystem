<script setup>
import { ref, reactive, onMounted, computed } from 'vue'
import { listMenu, addMenu, updateMenu, delMenu } from '@/api/menu'
import { message, Modal } from 'ant-design-vue'
import * as Icons from '@ant-design/icons-vue'

const loading = ref(false)
const dataSource = ref([])
const queryParams = reactive({
  menuName: '',
  status: ''
})

const visible = ref(false)
const form = reactive({
  id: undefined,
  parentId: 0,
  menuName: '',
  menuType: 'C',
  path: '',
  component: '',
  perms: '',
  icon: '',
  sortOrder: 0,
  status: '0',
  visible: '0'
})

const iconInput = ref('')
const iconSearch = ref('')
const commonIcons = computed(() => {
  const list = [
    'DashboardOutlined', 'UserOutlined', 'TeamOutlined', 'MenuOutlined',
    'ApartmentOutlined', 'BookOutlined', 'ToolOutlined', 'NotificationOutlined',
    'FileTextOutlined', 'LoginOutlined', 'SettingOutlined', 'FileOutlined',
    'DesktopOutlined', 'HomeOutlined', 'AppstoreOutlined', 'DatabaseOutlined',
    'CloudOutlined', 'ShoppingOutlined', 'MailOutlined', 'MessageOutlined',
    'BellOutlined', 'AlertOutlined', 'CheckCircleOutlined', 'CloseCircleOutlined',
    'InfoCircleOutlined', 'WarningOutlined', 'QuestionCircleOutlined', 'StarOutlined',
    'HeartOutlined', 'LockOutlined', 'UnlockOutlined', 'KeyOutlined',
    'SafetyCertificateOutlined', 'SecurityScanOutlined', 'EyeOutlined', 'EyeInvisibleOutlined',
    'SearchOutlined', 'FilterOutlined', 'DownloadOutlined', 'UploadOutlined',
    'SyncOutlined', 'ReloadOutlined', 'DeleteOutlined', 'EditOutlined',
    'PlusOutlined', 'MinusOutlined', 'ExportOutlined', 'ImportOutlined',
    'PrinterOutlined', 'SaveOutlined', 'FolderOutlined', 'FileAddOutlined',
    'LinkOutlined', 'DisconnectOutlined', 'SwapOutlined', 'DragOutlined',
    'PictureOutlined', 'VideoCameraOutlined', 'AudioOutlined', 'CameraOutlined',
    'CalendarOutlined', 'ClockCircleOutlined', 'EnvironmentOutlined', 'GlobalOutlined',
    'TagsOutlined', 'TagOutlined', 'FlagOutlined', 'ThunderboltOutlined',
    'TrophyOutlined', 'GiftOutlined', 'ShopOutlined', 'DollarOutlined',
    'ThunderboltOutlined', 'FireOutlined', 'RocketOutlined', 'BulbOutlined',
    'CustomerServiceOutlined', 'PhoneOutlined', 'MobileOutlined', 'TabletOutlined',
    'LaptopOutlined', 'DesktopOutlined', 'WifiOutlined', 'BarcodeOutlined',
    'ScanOutlined', 'QrcodeOutlined', 'SendOutlined', 'ShareAltOutlined',
    'FormOutlined', 'CopyOutlined', 'ScissorOutlined', 'SnippetsOutlined',
    'OrderedListOutlined', 'UnorderedListOutlined', 'AlignLeftOutlined', 'AlignCenterOutlined',
    'PushpinOutlined', 'PaperClipOutlined', 'HistoryOutlined', 'TransactionOutlined',
    'BugOutlined', 'CodeOutlined', 'ConsoleSqlOutlined', 'CloudServerOutlined',
    'ApiOutlined', 'ControlOutlined', 'CompassOutlined', 'DashboardOutlined',
    'FundOutlined', 'BarChartOutlined', 'PieChartOutlined', 'LineChartOutlined',
    'AreaChartOutlined', 'RadarChartOutlined', 'DotChartOutlined', 'StockOutlined',
    'HeatMapOutlined', 'BoxPlotOutlined', 'SlidersOutlined', 'ProjectOutlined',
    'ScheduleOutlined', 'ProfileOutlined', 'SolutionOutlined', 'AuditOutlined',
    'InsuranceOutlined', 'IdcardOutlined', 'BankOutlined', 'CalculatorOutlined',
    'AimOutlined', 'BuildOutlined', 'CarOutlined', 'CarryOutOutlined',
    'CrownOutlined', 'ExperimentOutlined', 'HourglassOutlined', 'ShopOutlined',
    'ToolOutlined', 'TrademarkCircleOutlined', 'WechatOutlined', 'AlipayCircleOutlined',
    'RobotOutlined', 'SmileOutlined', 'MehOutlined', 'FrownOutlined'
  ]
  if (iconSearch.value) {
    return list.filter(name => name.toLowerCase().includes(iconSearch.value.toLowerCase()))
  }
  return list
})

const IconComponent = (name) => Icons[name] || null

const columns = [
  { title: '菜单名称', dataIndex: 'menuName', width: 180 },
  { title: '图标', dataIndex: 'icon', width: 80 },
  { title: '类型', dataIndex: 'menuType', width: 80 },
  { title: '路由地址', dataIndex: 'path', width: 150 },
  { title: '组件路径', dataIndex: 'component', width: 180 },
  { title: '权限标识', dataIndex: 'perms', width: 180 },
  { title: '排序', dataIndex: 'sortOrder', width: 80 },
  { title: '状态', dataIndex: 'status', width: 80 },
  { title: '操作', key: 'action', width: 150, fixed: 'right' }
]

const menuTypeMap = { M: '目录', C: '菜单', F: '按钮' }

const getList = async () => {
  loading.value = true
  try {
    const res = await listMenu(queryParams)
    dataSource.value = buildTree(res.data || [])
  } finally {
    loading.value = false
  }
}

const buildTree = (list) => {
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

const handleAdd = (parentId = 0) => {
  Object.assign(form, { id: undefined, parentId, menuName: '', menuType: 'C', path: '', component: '', perms: '', icon: '', sortOrder: 0, status: '0', visible: '0' })
  iconInput.value = ''
  visible.value = true
}

const handleEdit = (record) => {
  Object.assign(form, record)
  iconInput.value = record.icon || ''
  visible.value = true
}

const handleIconSelect = (name) => {
  form.icon = name
  iconInput.value = name
}

const handleDelete = (record) => {
  Modal.confirm({
    title: '确认删除',
    content: `确定要删除菜单 ${record.menuName} 吗？`,
    okText: '确定',
    cancelText: '取消',
    okText: '确定',
    cancelText: '取消',
    onOk: async () => {
      await delMenu(record.id)
      message.success('删除成功')
      getList()
    }
  })
}

const handleSubmit = async () => {
  if (form.id) {
    await updateMenu(form)
    message.success('修改成功')
  } else {
    await addMenu(form)
    message.success('新增成功')
  }
  visible.value = false
  getList()
}

const handleSearch = () => {
  getList()
}

const handleReset = () => {
  queryParams.menuName = ''
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
        <a-form-item label="菜单名称">
          <a-input v-model:value="queryParams.menuName" placeholder="请输入菜单名称" allow-clear />
        </a-form-item>
        <a-form-item label="状态">
          <a-select v-model:value="queryParams.status" placeholder="请选择" allow-clear style="width: 120px">
            <a-select-option value="0">正常</a-select-option>
            <a-select-option value="1">停用</a-select-option>
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
        <a-button type="primary" @click="handleAdd()" v-hasPermi="['system:menu:add']">新增</a-button>
      </a-space>

      <a-table
        :columns="columns"
        :data-source="dataSource"
        :loading="loading"
        :pagination="false"
        row-key="id"
        :scroll="{ x: 1200 }"
        childrenColumnName="children"
      >
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'icon'">
            <component :is="IconComponent(record.icon)" v-if="record.icon && IconComponent(record.icon)" />
            <span v-else>{{ record.icon }}</span>
          </template>
          <template v-if="column.dataIndex === 'menuType'">
            <a-tag>{{ menuTypeMap[record.menuType] || record.menuType }}</a-tag>
          </template>
          <template v-if="column.dataIndex === 'status'">
            <a-tag :color="record.status === '0' ? 'green' : 'red'">
              {{ record.status === '0' ? '正常' : '停用' }}
            </a-tag>
          </template>
          <template v-if="column.key === 'action'">
            <a-space>
              <a @click="handleAdd(record.id)" v-hasPermi="['system:menu:add']">新增</a>
              <a @click="handleEdit(record)" v-hasPermi="['system:menu:edit']">修改</a>
              <a @click="handleDelete(record)" style="color: #ff4d4f" v-hasPermi="['system:menu:remove']">删除</a>
            </a-space>
          </template>
        </template>
      </a-table>
    </a-card>

    <a-modal v-model:open="visible" :title="form.id ? '修改菜单' : '新增菜单'" @ok="handleSubmit" :width="700" okText="确定" cancelText="取消">
      <a-form :model="form" :label-col="{ span: 4 }">
        <a-form-item label="菜单类型" required>
          <a-radio-group v-model:value="form.menuType">
            <a-radio-button value="M">目录</a-radio-button>
            <a-radio-button value="C">菜单</a-radio-button>
            <a-radio-button value="F">按钮</a-radio-button>
          </a-radio-group>
        </a-form-item>
        <a-form-item label="菜单名称" required>
          <a-input v-model:value="form.menuName" placeholder="请输入菜单名称" />
        </a-form-item>
        <a-form-item v-if="form.menuType !== 'F'" label="路由地址">
          <a-input v-model:value="form.path" placeholder="请输入路由地址" />
        </a-form-item>
        <a-form-item v-if="form.menuType === 'C'" label="组件路径">
          <a-input v-model:value="form.component" placeholder="请输入组件路径" />
        </a-form-item>
        <a-form-item label="权限标识">
          <a-input v-model:value="form.perms" placeholder="请输入权限标识" />
        </a-form-item>
        <a-form-item v-if="form.menuType !== 'F'" label="图标">
          <a-row :gutter="8">
            <a-col :span="16">
              <a-input v-model:value="form.icon" placeholder="点击右侧图标选择" />
            </a-col>
            <a-col :span="8">
              <component :is="IconComponent(form.icon)" v-if="form.icon && IconComponent(form.icon)" :style="{ fontSize: '20px' }" />
              <span v-else style="color: #999">无图标</span>
            </a-col>
          </a-row>
          <div style="margin-top: 8px; padding: 8px; border: 1px solid #d9d9d9; border-radius: 4px; max-height: 200px; overflow-y: auto">
            <a-input v-model:value="iconSearch" placeholder="搜索图标..." allow-clear size="small" style="margin-bottom: 8px" />
            <div style="display: flex; flex-wrap: wrap; gap: 4px">
              <span v-for="name in commonIcons" :key="name"
                @click="handleIconSelect(name)"
                :style="{ 
                  padding: '4px 8px', cursor: 'pointer', borderRadius: '4px',
                  border: form.icon === name ? '2px solid #1890ff' : '1px solid transparent',
                  background: form.icon === name ? '#e6f7ff' : 'transparent'
                }"
              >
                <component :is="IconComponent(name)" v-if="IconComponent(name)" :style="{ fontSize: '18px' }" />
              </span>
            </div>
          </div>
        </a-form-item>
        <a-form-item label="排序">
          <a-input-number v-model:value="form.sortOrder" :min="0" style="width: 100%" />
        </a-form-item>
        <a-form-item label="状态">
          <a-radio-group v-model:value="form.status">
            <a-radio value="0">正常</a-radio>
            <a-radio value="1">停用</a-radio>
          </a-radio-group>
        </a-form-item>
        <a-form-item v-if="form.menuType !== 'F'" label="可见">
          <a-radio-group v-model:value="form.visible">
            <a-radio value="0">显示</a-radio>
            <a-radio value="1">隐藏</a-radio>
          </a-radio-group>
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>
