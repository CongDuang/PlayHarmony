import CommonConstants from '../../common/constants/CommonConstants'
import MainPageTypeModel from '../../viewmodel/MainPageTypeModel'
import { HomeView } from './view/HomeView';

@Entry
@Component
struct MainPage {
  tabController = new TabsController();
  @State currentIndex: number = 0;

  @Builder
  tabBarBuilder(item: MainPageTypeModel, index: number) {
    Column() {
      Image(this.currentIndex === index ? item.selectedIcon : item.icon)
        .width(25)
        .height(25)
        .margin({ bottom: 3 })

      Text(item.content)
        .fontSize(11)
        .fontColor(this.currentIndex === index ? $r('app.color.main_tab_bar_text_selected_color') :
        $r('app.color.main_tab_bar_text_normal_color'))
    }.layoutWeight(1)
    .justifyContent(FlexAlign.Start)
    .padding({ top: 11 })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {

        Stack() {
          Tabs({ controller: this.tabController, index: this.currentIndex, barPosition: BarPosition.End }) {
            ForEach(CommonConstants.TabBars_DEFAULT_MAIN_PAGE_TYPES, (item: MainPageTypeModel, index: number) => {
              TabContent() {
                if (item.name === 'home') {
                  HomeView()
                } else if (item.name === 'project') {
                  Text(item.content)
                } else if (item.name === 'official_account') {
                  Text(item.content)
                } else {
                  Text(item.content)
                }
              }.width('100%')
              .height('100%')
              .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
              .tabBar(this.tabBarBuilder(item, index))
            }, (item: MainPageTypeModel) => item.name ?? "")
          }
          .barBackgroundColor($r('app.color.main_tab_bar_bg_color'))
          .width('100%')
          .height('100%')
          .scrollable(false)
          .onTabBarClick((index: number) => {
            console.info('main page click', index.toString())
            this.currentIndex = index;
          })
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

        }.width('100%')
        .height('100%')
      }
    }
    .width('100%')
    .height('100%')
  }
}