const showAlert = (title: string, message: string | object) => {
  const content = typeof message === 'string' ? message : toString(message)
  uni.showModal({
    title: title || '',
    content,
    showCancel: false,
  })
}

const toString = (data: any) => JSON.stringify(data)

export { showAlert, toString }
