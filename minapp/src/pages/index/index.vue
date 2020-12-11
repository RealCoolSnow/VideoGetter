<template>
  <view class="container">
    <AtButton class="btn mt-10" openType="getUserInfo" v-if="!userInfo"
      >Login</AtButton
    >
    <AtAvatar :image="userInfo.avatarUrl" circle v-else></AtAvatar>
  </view>
</template>

<script lang="ts">
import './index.less'

import { AtButton, AtAvatar } from 'taro-ui-vue'
import { computed, reactive } from 'vue'
import { useStore } from 'vuex'

export default {
  components: {
    AtButton,
    AtAvatar,
  },
  setup() {
    const store = useStore()
    const state = reactive({
      authed: false,
    })
    const userInfo = computed(() => store.getters.userInfo)
    return { state, userInfo }
  },
}
</script>
