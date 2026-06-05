import { createApp } from 'vue'
import Antd from 'ant-design-vue'
import zhCN from 'ant-design-vue/es/locale/zh_CN'
import App from './App.vue'
import router from './router'
import pinia from './store'
import directive from './directive'
import i18n from './i18n'
import 'ant-design-vue/dist/reset.css'

const app = createApp(App)

app.use(Antd, { locale: zhCN })
app.use(router)
app.use(pinia)
app.use(directive)
app.use(i18n)

app.mount('#app')
