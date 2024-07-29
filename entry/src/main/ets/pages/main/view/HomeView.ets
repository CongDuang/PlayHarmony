import { TitleBar } from '../../../widgets/TitleBar'

@Component
export struct HomeView {
  build() {
    Column() {
      TitleBar({
        title: $r('app.string.home'),
        showSearch: true,
        onSearch: () => {
          // TODO to search page
          console.info('home view clicked search')
        }
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}