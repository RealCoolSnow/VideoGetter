import {
  createApp,
} from 'vue'
import App from './App.vue'
// import { createI18nWithLocale } from './locale'
// import store from './store'

// const i18n = createI18nWithLocale(store.getters.language)

const app = createApp(App)
// app.use(i18n)
app.mount()
