import MutationTypes from '@/store/mutation-types'
import Taro from '@tarojs/taro'
import { fullUrlWithBase, Post } from '../service/http/'
import store from '../store'
const loginURL = 'https://www.joy666.cn/wxapi'
interface LoginResult {
  id: string
  session_id: string
}
const loginServer = (code: string) => {
  const url = fullUrlWithBase(loginURL, 'user/v3_login.html')
  let clientInfo = Taro.getSystemInfoSync()
  clientInfo['launchOption'] = Taro.getLaunchOptionsSync()
  Post(url, {
    code: code,
    client: JSON.stringify(clientInfo),
  }).then((res) => {
    console.log(res)
    if (res.code == 0 && res.data) {
      const loginResult: LoginResult = res.data as LoginResult
      store.commit(MutationTypes.APP.SET_SESSION_ID, loginResult.session_id)
      store.commit(MutationTypes.APP.SET_USER_ID, loginResult.id)
      getUserInfo()
    }
  })
}

const getUserInfo = () => {
  checkUserInfoScope().then(() => {
    Taro.getUserInfo({
      success: function (res) {
        updateUserInfo(res.userInfo)
      },
    })
  })
}

const checkUserInfoScope = () => {
  return new Promise((resolve, reject) => {
    Taro.getSetting({
      success: function (res) {
        if (res.authSetting['scope.userInfo']) {
          resolve(true)
        } else {
          reject()
        }
      },
      fail: function () {
        reject()
      },
    })
  })
}

const updateUserInfo = (userinfo: any) => {
  store.commit(MutationTypes.APP.SET_USER_INFO, userinfo)
  const url = fullUrlWithBase(loginURL, 'user/update_userinfo.html')
  Post(url, userinfo).then((res) => {
    console.log(res)
  })
}

const silentLogin = () => {
  Taro.login({
    success: function (res) {
      if (res.code) {
        loginServer(res.code)
      }
    },
  })
}

export { silentLogin, updateUserInfo, checkUserInfoScope }
