import { router } from '@kit.ArkUI';

@Entry
@Component
struct WelcomePage {
  @State opacityNum: number = 0.2;

  onPageShow(): void {
    this.opacityNum = 1;
  }

  build() {
    Stack() {
      Image($r('app.media.welcome_img'))
        .height('100%')
        .width('100%')
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])// 图片组件的绘制区域扩展至状态栏和导航条。
        .opacity(this.opacityNum)
        .animation({
          duration: 1000, onFinish: () => {
            router.replaceUrl({ url: 'pages/main/MainPage' })
          }
        })
    }.height('100%').width('100%')
  }
}