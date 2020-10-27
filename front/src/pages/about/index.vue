<template>
  <div class="container">
    <logo />
    <text>this is about page</text>
  </div>
</template>
<script>
import Logo from '@/components/Logo'
export default {
  components: {
    Logo,
  },
  setup() {},
}
</script>
<style lang="less">
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20rpx;
  text {
    font-size: @font-base;
    color: @primary-color;
  }
}
</style>
