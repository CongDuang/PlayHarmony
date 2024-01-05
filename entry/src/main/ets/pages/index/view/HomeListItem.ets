@Component
@Preview
export struct HomeListItem {
  private isHasImg: boolean = true;

  build() {
    Column() {
      Row() {
        Text("作者")
          .fontSize(13)
          .fontColor($r('app.color.text_color'))

        Text("Newest")
          .fontSize(13)
          .margin({
            left: 5,
            right: 5
          })
          .fontColor($r('app.color.red_btn_bg_color'))

        Text("Topping")
          .fontSize(13)
          .margin({
            left: 5,
            right: 5
          })
          .fontColor($r('app.color.red_btn_bg_color'))

        Text("发布时间")
          .margin({
            left: 5,
            right: 5
          })
          .fontSize(13)
          .fontColor($r('app.color.text_color'))
          .layoutWeight(1)
          .textAlign(TextAlign.End)
      }

      Row() {
        Text("文章标题很长很长文章标题很长很长文章标题很长很长文章标题很长很长文章标题很长很长文章标题很长很长")
          .fontSize(15)
          .layoutWeight(1)
          .fontColor($r('app.color.text_color_black'))

        Image($r('app.media.startIcon'))
          .width(70)
          .height(70)
          .visibility(this.isHasImg ? Visibility.Visible : Visibility.None)
      }
      .margin({
        top: 4
      })

      Row() {
        Text("分类")
          .fontSize(13)
          .fontColor($r("app.color.red_btn_bg_color"))
          .margin({
            top: 4
          })
          .layoutWeight(1)

        Blank()
          .backgroundColor($r('app.color.red_btn_bg_color'))
          .width(20)
          .height(20)
          .margin({
            left: 5,
            right: 5,
            top: 8
          })
      }
    }
    .padding(10)
    .margin({
      top: 10,
      left: 10,
      right: 10
    })
    .alignItems(HorizontalAlign.Start)
    .border({
      width: 0.5,
      color: $r('app.color.article_bg'),
      radius: 6
    })
    .backgroundColor($r('app.color.article_bg'))
  }
}