import App from '@system.app'
import { HtmlEntityReplace } from 'html_entities_replace';
import Logger from '../../../common/Logger';
import { ErroCode } from '../../../models/BaseResp';
import HttpUtil from '../../../utils/HttpUtil'
import { ProjectCategoryModel } from '../../../viewmodel/project/ProjectCategoryModel'


@Preview
@Component
export struct ProjectView {
  @State categoryList: ProjectCategoryModel[] = [];
  @State currentTabIndex: number = 0;
  topRectHeightPx: number = AppStorage.get<number>('topRectHeight') ?? 0;

  aboutToAppear(): void {
    Logger.debug('topRectHeightPx', this.topRectHeightPx.toString());
    this.getProjectCategory()
  }

  @Builder
  private projectListView() {
    List() {
      // ListItem() {
      //   Column() {
      //
      //     Row() {
      //       Text(item.author.length === 0 ? item.shareUser : item.author)
      //         .fontSize(13)
      //         .fontColor($r('app.color.text_color'))
      //
      //       Text("最新")
      //         .fontSize(13)
      //         .fontColor($r('app.color.red_btn_bg_color'))
      //         .margin({ left: 5, right: 5 })
      //         .visibility(item.fresh ? Visibility.Visible : Visibility.None)
      //
      //       Text("置顶")
      //         .fontSize(13)
      //         .fontColor($r('app.color.red_btn_bg_color'))
      //         .margin({ left: 5, right: 5 })
      //         .visibility(item.type > 0 ? Visibility.Visible : Visibility.None)
      //
      //       Text(item.niceShareDate)
      //         .fontSize(13)
      //         .fontColor($r('app.color.text_color'))
      //         .margin({ left: 5, right: 5 })
      //         .layoutWeight(1)
      //         .textAlign(TextAlign.End)
      //     }
      //     .width('100%')
      //     .justifyContent(FlexAlign.Start)
      //
      //     Row() {
      //
      //       Text(HtmlEntityReplace.replace(category.name))
      //         .fontSize(15)
      //         .fontColor($r('app.color.text_color_black'))
      //         .fontWeight(FontWeight.Bold)
      //         .layoutWeight(1)
      //
      //       Image(item.envelopePic)
      //         .width(70)
      //         .height(70)
      //         .alt('Image')
      //         .backgroundColor(Color.Gray)
      //         .visibility(item.envelopePic.length === 0 ? Visibility.None : Visibility.Visible)
      //     }
      //     .alignItems(VerticalAlign.Top)
      //     .margin({ top: 4 })
      //
      //     Row() {
      //       Text(item.superChapterName)
      //         .fontColor($r('app.color.red_btn_bg_color'))
      //         .fontSize(13)
      //
      //       Image($r('app.media.favorite_selected'))
      //         .width(20)
      //         .height(20)
      //         .margin({ top: 1 })
      //     }
      //     .width('100%')
      //     .alignItems(VerticalAlign.Top)
      //     .justifyContent(FlexAlign.SpaceBetween)
      //     .margin({ top: 4 })
      //   }
      // }
      // .padding(10)
      // .borderRadius(6)
      // .backgroundColor($r('app.color.article_bg'))
      // .margin({
      //   top: index === 0 ? 10 : 0,
      //   bottom: index === this.homeArticleList.length - 1 ? 10 : 0,
      //   left: 10,
      //   right: 10
      // })
    }
    .width('100%')
    .height('100%')
  }

  /**
   * 获取项目分类
   */
  private async getProjectCategory() {
    const resp = await HttpUtil.getInstance().get<ProjectCategoryModel[], undefined>('/project/tree/json');
    if (resp.errorCode === ErroCode.OK && resp.data && resp.data.length > 0) {
      this.categoryList = resp.data;
    }
  }

  @Builder
  tabBarItem(category: ProjectCategoryModel, index: number) {
    Column() {
      Text(HtmlEntityReplace.replace(category.name))
        .fontColor($r('app.color.white'))
        .padding({ bottom: 5 })
        .border({
          width: { bottom: 5 },
          color: this.currentTabIndex === index ? $r('app.color.white') : Color.Transparent
        })
        .margin({ left: 10, right: 10 })
    }
  }

  build() {
    Column() {
      Column() {
        Stack() {
          Column() {
            Blank()
              .width('100%')
              .height((vp2px(30) + this.topRectHeightPx) + 'px')
              .backgroundColor($r('app.color.primary_color'))
              .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
          }
          .width('100%')
          .height('100%')
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

          Tabs({ index: this.currentTabIndex }) {
            ForEach(this.categoryList, (category: ProjectCategoryModel, index: number) => {
              TabContent() {
                ProjectList({ category: category, index: index })
              }
              .tabBar(this.tabBarItem(category, index))
              .backgroundColor($r('app.color.gray_white'))
            })
          }
          .backgroundColor(Color.Transparent)
          .barHeight(30)
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
          .foregroundColor(Color.White)
          .barMode(BarMode.Scrollable, { nonScrollableLayoutStyle: LayoutStyle.ALWAYS_AVERAGE_SPLIT })
          .barPosition(BarPosition.Start)
          .width('100%')
          .height('100%')
          .onChange((index: number) => {
            this.currentTabIndex = index;
          })
        }

      }
      .width('100%')
      .height('100%')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    }
    .backgroundColor($r('app.color.gray_white'))
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
  }
}

@Component
export struct ProjectList {
  @Prop category: ProjectCategoryModel;
  @Prop index: number = -1;

  aboutToAppear(): void {
    Logger.debug("ProjectList", "aboutToAppear" + this.index)
  }

  /**
   * 获取项目列表数据
   * @param page
   */
  private getProjectListData(page: number) {

  }

  build() {
    Column() {
      Text(this.category.name)
    }
  }
}