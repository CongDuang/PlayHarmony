import CommonConstants from '../../../common/constants/CommonConstants'
import MineProfileTypeModel from '../../../viewmodel/MineProfileTypeModel'
import { MineHeader } from '../../../widgets/MineHeader'
import { TitleBar } from '../../../widgets/TitleBar'

@Preview
@Component
export struct MineView {
  @Builder
  item(text: string, icon: Resource) {

  }

  build() {
    Column() {
      TitleBar({ title: "我的" })
      MineHeader()

      Column() {
        ForEach(CommonConstants.MIME_PROFILE_DEFAULT_TYPES, (item: MineProfileTypeModel) => {
          Row() {
            Image(item.icon)
              .width(20)
              .height(24)
              .objectFit(ImageFit.Fill)
              .fillColor($r('app.color.profile_color'))

            Text(item.content)
              .fontSize(15)
              .fontColor($r('app.color.text_color_dark'))
              .layoutWeight(1)
              .margin({
                left: 5
              })

            SymbolGlyph($r('sys.symbol.chevron_right'))
              .fontSize(25)
              .width(25)
              .height(25)
          }
          .stateStyles({
            normal: {
              .backgroundColor(Color.Transparent)
            },
            pressed: {
              .backgroundColor($r('app.color.gray_white'))
            }
          })
          .width('100%')
          .padding({ left: 10, top: 10, bottom: 10 })
        })
      }
      .margin(16)
      .borderRadius(5)
      .shadow({ color: $r('app.color.gray_white'), radius: 10, })
      .clip(true)

      Button('退出登录')
        .margin({ top: 2 })
        .fontSize(13)
        .padding({ left: 50, right: 50 })
        .backgroundColor($r('app.color.btn_exit_login'))
    }
    .width('100%')
    .height('100%')
  }
}