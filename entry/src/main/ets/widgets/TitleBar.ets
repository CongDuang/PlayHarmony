@Component
export struct TitleBar {
  title: Resource | null = null;

  build() {
    Stack({}) {
      Text(this.title ?? "")
        .fontColor($r('app.color.white'))
        .fontSize(18)
    }
    .width('100%')
    .padding({ bottom: 11, top: 11 })
    .backgroundColor($r('app.color.primary_color'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}