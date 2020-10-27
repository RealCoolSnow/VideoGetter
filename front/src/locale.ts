import { createI18n } from 'vue-i18n'
import en from '../locales/en.json'
import cn from '../locales/cn.json'

const messages = {
  en,
  cn,
}

const locales = Object.keys(messages)

const createI18nWithLocale = (locale: string): any => {
  return createI18n({
    locale,
    messages,
  })
}
export {
  messages, locales, createI18nWithLocale,
}
