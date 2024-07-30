import Logger from '../common/Logger';
import { TextButton } from './TextButton';

@Preview
@Component
export struct MineHeader {
  avatarImgUrl?: string;
  nickname?: string;

  build() {
    Row() {
      Row() {
        Image(this.avatarImgUrl ?? $r('app.media.mine_default_avatar'))
          .width(70)
          .height(70)
          .objectFit(ImageFit.Fill)

        Column() {
          TextButton({
            text: "未登录", onClickCallback: () => {
            }
          })
          TextButton({ text: "请点击进行登录" })
            .margin({ top: 10 })
        }
        .height('100%')
        .margin({
          left: 20,
        })
        .alignItems(HorizontalAlign.Start)
        .height(70)
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height(170)
    .padding({ left: 30, right: 30 })
    .backgroundColor($r('app.color.primary_color'))
  }
}