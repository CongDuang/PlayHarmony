import router from '@ohos.router'

@Entry
@Component
export struct Welcome {
  onPageShow() {
    setTimeout(() => {
      router.replaceUrl({
        url: 'pages/Index',
      })
    }, 500)
  }

  build() {
    Column() {
      Image($rawfile('images/img_welcome.webp')).layoutWeight(1)
    }
  }
}