import App from '@system.app'

@Preview
@Component
export struct ProjectView {
  @Builder
  tabBarItem() {
    Column() {
      Text("123")
        .fontColor($r('app.color.white'))
        .padding({ bottom: 5 })
        .border({ width: { bottom: 5 }, color: $r('app.color.white') })
    }
  }

  build() {
    Column() {
      Column() {
        Tabs() {
          TabContent() {
          }
          .tabBar(this.tabBarItem())
          .backgroundColor($r('app.color.gray_white'))
          .outlineColor(Color.Red)
        }
        .backgroundColor($r('app.color.primary_color'))
        .barHeight(30)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
        .foregroundColor(Color.White)
        .barMode(BarMode.Scrollable, { nonScrollableLayoutStyle: LayoutStyle.ALWAYS_AVERAGE_SPLIT })
        .barPosition(BarPosition.Start)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .backgroundColor(Color.Gray)
      .height('100%')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
  }
}