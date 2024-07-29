import HttpUtil from '../../../utils/HttpUtil'
import { TitleBar } from '../../../widgets/TitleBar'
import BaseResp, { ErroCode } from '../../../models/BaseResp'
import { HomeBannerModel } from '../../../viewmodel/HomeBannerModel'
import { PullToRefresh } from '@ohos/pulltorefresh'

@Preview
@Component
export struct HomeView {
  @State banners: HomeBannerModel[] = [];
  private scroller: Scroller = new Scroller();

  async aboutToAppear() {
    await this.getBannerData();
  }

  /**
   * 获取banner数据
   */
  async getBannerData() {
    const resp: BaseResp<HomeBannerModel[]> =
      await HttpUtil.getInstance().get<HomeBannerModel[], undefined>('/banner/json');
    if (resp.errorCode == ErroCode.OK && resp.data) {
      this.banners = resp.data!;
    }
  }

  @Builder
  private listView() {
    List({ space: 10, scroller: this.scroller }) {
      ForEach(this.banners, (item: HomeBannerModel, index: number) => {
        ListItem() {
          Column() {

            Row() {
              Text("干货")
                .fontSize(13)
                .fontColor($r('app.color.text_color'))

              Text("最新")
                .fontSize(13)
                .fontColor($r('app.color.red_btn_bg_color'))
                .margin({ left: 5, right: 5 })

              Text("置顶")
                .fontSize(13)
                .fontColor($r('app.color.red_btn_bg_color'))
                .margin({ left: 5, right: 5 })

              Text("发布时间")
                .fontSize(13)
                .fontColor($r('app.color.text_color'))
                .margin({ left: 5, right: 5 })
                .layoutWeight(1)
                .textAlign(TextAlign.End)
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)

            Row() {
              Text("文章标题很长很长文章标题很长很长文章标题很长很长文章标题很长很长")
                .fontSize(15)
                .fontColor($r('app.color.text_color_black'))
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)

              Image('')
                .width(70)
                .height(70)
                .alt('Image')
                .visibility(Visibility.None)
            }
            .alignItems(VerticalAlign.Top)
            .margin({ top: 4 })

            Row() {
              Text("分类")
                .fontColor($r('app.color.red_btn_bg_color'))
                .fontSize(13)

              Image($r('app.media.favorite_selected'))
                .width(20)
                .height(20)
                .margin({ top: 1 })
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 4 })
          }
        }
        .padding(10)
        .margin({ left: 10, right: 10 })
        .borderRadius(6)
        .backgroundColor($r('app.color.article_bg'))
      })
    }
    .width('100%')
    .height('100%')
    .margin({ top: 10 })
  }

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

      // banner
      Swiper() {
        ForEach(this.banners, (item: HomeBannerModel, index: number) => {
          Image(item.imagePath)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Fill)
        })
      }
      .width(355)
      .height(180)
      .loop(true)
      .backgroundColor(Color.Gray)
      .borderRadius(10)
      .margin({
        left: 10,
        right: 10,
        top: 10,
      })
      .autoPlay(true)

      // 列表
      PullToRefresh({
        data: this.banners,
        scroller: this.scroller,
        customList: () => this.listView(),
        onRefresh: () => {
          return Promise.resolve("刷新成功");
        },
        onLoadMore: () => {
          return Promise.resolve('');
        }
      })
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}