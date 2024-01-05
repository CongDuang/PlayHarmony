import { Home } from './Home';

class TabBar {
  title: Resource;
  selectedImg: Resource;
  normalImg: Resource;
}

@Entry
@Component
struct Index {
  @State
  currentIndex: number = 0;
  tabs: TabBar[] = [
    {
      title: $r('app.string.home_page'),
      selectedImg: $r("app.media.ic_home_selected"),
      normalImg: $r("app.media.ic_home")
    },
    {
      title: $r('app.string.project_page'),
      selectedImg: $r("app.media.ic_project_selected"),
      normalImg: $r("app.media.ic_project")
    },
    {
      title: $r('app.string.official_page'),
      selectedImg: $r("app.media.ic_account_selected"),
      normalImg: $r("app.media.ic_account")
    },
    {
      title: $r('app.string.mine_page'),
      selectedImg: $r("app.media.ic_mine_selected"),
      normalImg: $r("app.media.ic_mine")
    }
  ]
  tabsController: TabsController = new TabsController();

  @Builder
  tabBuilder(title: Resource, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .margin({ top: 3 })
        .fontSize(11)
        .fontColor(this.currentIndex === targetIndex ? $r('app.color.select_color') : $r('app.color.normal_color'))
    }
    .layoutWeight(1)
    .onClick(() => {
      this.currentIndex = targetIndex;
    })
  }

  /**
   * 构建第一页
   */
  @Builder
  tabsBuilder() {
    Tabs({
      index: this.currentIndex,
      controller: this.tabsController
    }) {
      TabContent() {
        Home()
      }
      .tabIndex(0)

      TabContent() {
        Text("1").fontSize(30)
          .fontColor(Color.Black)
      }
      .tabIndex(1)

      TabContent() {
        Text("2").fontSize(30)
          .fontColor(Color.Black)
      }
      .tabIndex(2)

      TabContent() {
        Text("3").fontSize(30)
          .fontColor(Color.Black)
      }
      .tabIndex(3)
    }
    .margin({ bottom: 30 })
    .barWidth(0)
    .barHeight(0)
    .scrollable(false)
  }

  build() {
    Row() {
      Stack({ alignContent: Alignment.Bottom }) {
        this.tabsBuilder()
        Row() {
          Row() {
            ForEach(this.tabs, (item: TabBar, index) => {
              this.tabBuilder(item.title, index, item.selectedImg, item.normalImg)
            }, (item) => JSON.stringify(item))
          }
          .height(55)
          .margin({
            top: 15,
            bottom: 15,
            left: 30,
            right: 30
          })
          .borderRadius(15)
          .backgroundColor($r('app.color.home_bottom_bg_color'))
        }
        .width('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          repeating: false,
          colors: [
            [$r('app.color.home_bottom_mask_start'), 0.0],
            [$r('app.color.home_bottom_mask_end'), 1.0]
          ]
        })
      }
      .width('100%')
    }
    .backgroundColor($r('app.color.color_background'))
    .height('100%')
  }
}