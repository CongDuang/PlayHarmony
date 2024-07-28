import CommonConstants from '../../common/constants/CommonConstants'
import MainPageTypeModel from '../../viewmodel/MainPageTypeModel'
import { HomeView } from './view/HomeView';


@Entry
@Component
struct MainPage {
  tabController = new TabsController();
  @State currentIndex: number = 0;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Tabs({ controller: this.tabController, index: this.currentIndex }) {
        ForEach(CommonConstants.TabBars_DEFAULT_MAIN_PAGE_TYPES, (item: MainPageTypeModel) => {
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
          }
        }, (item: MainPageTypeModel) => item.name ?? "")
      }.padding({ bottom: 12 })
      .scrollable(false)

      Row() {
        Row() {
          ForEach(CommonConstants.TabBars_DEFAULT_MAIN_PAGE_TYPES, (item: MainPageTypeModel, index: number) => {
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
            .onClick(() => {
              this.currentIndex = index;
              this.tabController.changeIndex(index);
            })
          }, (item: MainPageTypeModel) => item.name ?? "")
        }
        .height(55)
        .layoutWeight(1)
        .margin({ left: 30, right: 30, bottom: 15 })
        .borderRadius(15)
        .backgroundColor($r("app.color.main_tab_bar_bg_color"))
      }.width('100%')
    }
  }
}