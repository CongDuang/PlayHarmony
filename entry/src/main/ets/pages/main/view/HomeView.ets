import HttpUtil from '../../../utils/HttpUtil'
import { TitleBar } from '../../../widgets/TitleBar'
import BaseResp, { ErroCode, PageInlineResp } from '../../../models/BaseResp'
import { HomeBannerModel } from '../../../viewmodel/HomeBannerModel'
import { PullToRefresh } from '@ohos/pulltorefresh'
import { ArticleModel } from '../../../viewmodel/ArticleModel'
import { HtmlEntityReplace } from 'html_entities_replace';
import { ArticleList } from '../../../widgets/ArticleListView'

@Preview
@Component
export struct HomeView {
  @State banners: HomeBannerModel[] = [];
  private scroller: Scroller = new Scroller();
  @State page: number = 0;
  @State homeArticleList: ArticleModel[] = [];

  aboutToAppear() {
    // banner数据
    this.getBannerData();
    // 列表数据
    // this.getHomeListData(0);
  }

  /**
   * 获取banner数据
   */
  async getBannerData() {
    const resp: BaseResp<HomeBannerModel[]> =
      await HttpUtil.getInstance().get<HomeBannerModel[], undefined>('/banner/json');
    if (resp.errorCode === ErroCode.OK && resp.data) {
      this.banners = resp.data!;
    }
  }

  /**
   * 获取首页列表数据
   * @param page 页码
   * @returns
   */
  async getHomeListData(page: number): Promise<boolean> {
    let topArticleList: ArticleModel[] = [];
    if (page === 0) {
      const topArticleResp = await HttpUtil.getInstance().get<ArticleModel[], undefined>('/article/top/json')
      if (topArticleResp.errorCode === ErroCode.OK && topArticleResp.data) {
        topArticleList = topArticleResp.data!;
      }
    }

    // 获取列表数据
    const resp: BaseResp<PageInlineResp<ArticleModel>> =
      await HttpUtil.getInstance()
        .get<PageInlineResp<ArticleModel>, undefined>(`/article/list/${page}/json?page_size=20`);
    if (resp.errorCode === ErroCode.OK && resp.data) {
      if (page === 0) {
        this.homeArticleList.length = 0;
      }
      // 先拼接置顶的数据
      if (topArticleList.length > 0) {
        this.homeArticleList.push(...topArticleList);
      }
      // 拼接数据
      this.homeArticleList.push(...resp.data!.datas);
      // 如果接口调用成功了，再修改 page
      this.page = page;
      return true;
    }
    return false;
  }

  @Builder
  private listView() {
    List({ space: 10, scroller: this.scroller }) {
      ForEach(this.homeArticleList, (item: ArticleModel, index: number) => {
        ListItem() {
          Column() {

            Row() {
              Text(item.author.length === 0 ? item.shareUser : item.author)
                .fontSize(13)
                .fontColor($r('app.color.text_color'))

              Text("最新")
                .fontSize(13)
                .fontColor($r('app.color.red_btn_bg_color'))
                .margin({ left: 5, right: 5 })
                .visibility(item.fresh ? Visibility.Visible : Visibility.None)

              Text("置顶")
                .fontSize(13)
                .fontColor($r('app.color.red_btn_bg_color'))
                .margin({ left: 5, right: 5 })
                .visibility(item.type > 0 ? Visibility.Visible : Visibility.None)

              Text(item.niceShareDate)
                .fontSize(13)
                .fontColor($r('app.color.text_color'))
                .margin({ left: 5, right: 5 })
                .layoutWeight(1)
                .textAlign(TextAlign.End)
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)

            Row() {

              Text(HtmlEntityReplace.replace(item.title))
                .fontSize(15)
                .fontColor($r('app.color.text_color_black'))
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)

              Image(item.envelopePic)
                .width(70)
                .height(70)
                .alt('Image')
                .visibility(item.envelopePic.length === 0 ? Visibility.None : Visibility.Visible)
            }
            .alignItems(VerticalAlign.Top)
            .margin({ top: 4 })

            Row() {
              Text(item.superChapterName)
                .fontColor($r('app.color.red_btn_bg_color'))
                .fontSize(13)

              Image(item.collect ? $r('app.media.favorite_selected') : $r('app.media.favorite'))
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
        .borderRadius(6)
        .backgroundColor($r('app.color.article_bg'))
        .margin({
          top: index === 0 ? 10 : 0,
          bottom: index === this.homeArticleList.length - 1 ? 10 : 0,
          left: 10,
          right: 10
        })
      })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .edgeEffect(EdgeEffect.None)
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
      Row() {
        Swiper() {
          ForEach(this.banners, (item: HomeBannerModel, index: number) => {
            Image(item.imagePath)
              .width('100%')
              .height('100%')
              .objectFit(ImageFit.Fill)
          })
        }
        .width('100%')
        .height(180)
        .loop(true)
        .backgroundColor(Color.Gray)
        .borderRadius(10)
        .autoPlay(true)
      }.width('100%')
      .padding({
        left: 10,
        right: 10,
        top: 10
      })

      // 列表
      ArticleList({})
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}