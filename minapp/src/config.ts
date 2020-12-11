const debug = process.env.NODE_ENV !== 'production'

export default {
  debug,
  app: 'wx_s2a',
  baseUrl: debug ? 'https://app.joy666.cn/api' : 'https://url.production/api',
}
