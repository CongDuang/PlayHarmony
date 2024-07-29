import { TitleBar } from '../../../widgets/TitleBar'

@Component
export struct HomeView {
  build() {
    Column() {
      TitleBar({ title: $r('app.string.home') })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}