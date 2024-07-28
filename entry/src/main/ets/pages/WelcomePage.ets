import { router } from '@kit.ArkUI';

@Entry
@Component
struct WelcomePage {
  @State opacityNum: number = 0.2;

  onPageShow(): void {
    this.opacityNum = 1;
  }

  build() {
    Column() {
      Image($r("app.media.welcome_img"))
        .opacity(this.opacityNum)
        .animation({
          duration: 1500, onFinish: () => {
            router.replaceUrl({ url: 'pages/main/MainPage' });
          }
        })
    }.width('100%')
    .height('100%')
  }
}