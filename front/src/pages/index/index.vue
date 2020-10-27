<template>
  <view class="content">
    <button
      v-if="!state.userInfo.avatarUrl"
      open-type="getUserInfo"
      class="mt"
      @getuserinfo="onGetUserInfo"
    >
      getUserInfo
    </button>
    <view v-else class="userinfo">
      <image :src="state.userInfo.avatarUrl" />
      <text>{{ state.userInfo.nickName }}</text>
    </view>
    <button class="mt" @click="inc">
      Counter - {{ state.counter }}
    </button>
    <button class="mt" @click="httpTest">
      Http Test
    </button>
    <navigator url="/pages/about/index" class="mt">
      <button>Show About</button>
    </navigator>
  </view>
</template>

<script>
import { reactive, computed } from 'vue'
import store from '@/store'
import MutationTypes from '@/store/mutation-types'
import { helloGet } from '@/service/api'
import { showAlert } from '@/utils/app'

export default {
  setup() {
    const state = reactive({
      counter: computed(() => store.getters.counter),
      userInfo: {},
    })
    const inc = () => {
      store.commit(MutationTypes.APP.SET_COUNTER, 1)
    }
    const httpTest = () => {
      helloGet()
        .then((res) => {
          console.log(res)
          showAlert('success', res)
        })
        .catch((err) => {
          console.log(err)
          showAlert('fail', err)
        })
    }
    const onGetUserInfo = (e) => {
      console.log(e)
      state.userInfo = e.detail.userInfo
    }
    return {
      state,
      inc,
      httpTest,
      onGetUserInfo,
    }
  },
}
</script>

<style lang="less">
.content {
  text-align: center;
  padding: 20rpx 20rpx;
  .mt {
    margin-top: 20rpx;
  }
  .userinfo {
    display: flex;
    flex-direction: column;
    align-items: center;
    image {
      width: 160rpx;
      height: 160rpx;
      border-radius: 100%;
    }
    text {
      margin-top: 5rpx;
    }
  }
}
</style>
