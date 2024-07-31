import { PullToRefresh } from '@ohos/pulltorefresh';
import { HtmlEntityReplace } from 'html_entities_replace';
import Logger from '../common/Logger';
import BaseResp, { ErroCode, PageInlineResp } from '../models/BaseResp';
import HttpUtil from '../utils/HttpUtil';
import { ArticleModel } from '../viewmodel/ArticleModel';
import { CategoryModel } from '../viewmodel/CategoryModel';

@Component
export struct ArticleList {
  @Prop category: CategoryModel;
  @State page: number = 0;
  @State articleList: ArticleModel[] = [];
  private scroller: Scroller = new Scroller();

  aboutToAppear(): void {
    this.getArticleListData(0);
  }

  /**
   * 获取项目列表数据
   * @param page
   */
  private async getArticleListData(page: number): Promise<boolean> {
    // 获取列表数据
    const resp: BaseResp<PageInlineResp<ArticleModel>> =
      await HttpUtil.getInstance()
        .get<PageInlineResp<ArticleModel>, undefined>(`/article/list/${page}/json?page_size=20${this.category ?
          `&cid=${this.category.id}` : ''}`);
    if (resp.errorCode === ErroCode.OK && resp.data) {
      if (page === 0) {
        this.articleList.length = 0;
      }
      // 拼接数据
      this.articleList.push(...resp.data!.datas);
      // 如果接口调用成功了，再修改 page
      this.page = page;
      return true;
    }
    return false;
  }

  @Builder
  private listView() {
    List({ space: 10, scroller: this.scroller }) {
      ForEach(this.articleList, (item: ArticleModel, index: number) => {
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
          bottom: index === this.articleList.length - 1 ? 10 : 0,
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
      PullToRefresh({
        data: this.articleList,
        scroller: this.scroller,
        customList: () => {
          this.listView();
        },
        onRefresh: async () => {
          const isSuccessful = await this.getArticleListData(0);
          if (isSuccessful) {
            return Promise.resolve("刷新成功");
          } else {
            return Promise.resolve('刷新失败');
          }
        },
        onLoadMore: async () => {
          const isSuccessful = await this.getArticleListData(this.page + 1);
          if (isSuccessful) {
            return Promise.resolve('');
          }
          return Promise.resolve(undefined);
        },
        customRefresh: null,
        customLoad: null,
      })
    }
  }
}