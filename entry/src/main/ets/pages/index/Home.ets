import { HomeListItem } from './view/HomeListItem'

@Component
@Preview
export struct Home {
  private swiperController: SwiperController = new SwiperController()

  build() {
    Column() {
      Swiper(this.swiperController) {
        Text("1")
          .backgroundColor(Color.Gray)
        Text("2")
          .backgroundColor(Color.Pink)
      }
      .loop(true)
      .width('100%')
      .padding({
        top: 10,
        left: 10,
        right: 10
      })
      .height(180)

      List() {
        ListItem() {
          HomeListItem()
        }
      }
      .width("100%")
      .height("100%")
      .margin({
        top: 10,
        left: 10,
        right: 10
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}