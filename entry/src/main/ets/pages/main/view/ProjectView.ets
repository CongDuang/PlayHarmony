import { PullToRefresh } from '@ohos/pulltorefresh';
import { HtmlEntityReplace } from 'html_entities_replace';
import Logger from '../../../common/Logger';
import BaseResp, { ErroCode, PageInlineResp } from '../../../models/BaseResp';
import HttpUtil from '../../../utils/HttpUtil'
import { ArticleModel } from '../../../viewmodel/ArticleModel';
import { CategoryModel } from '../../../viewmodel/CategoryModel'
import { ArticleList } from '../../../widgets/ArticleListView';


@Preview
@Component
export struct ProjectView {
  @State categoryList: CategoryModel[] = [];
  @State currentTabIndex: number = 0;
  topRectHeightPx: number = AppStorage.get<number>('topRectHeight') ?? 0;

  aboutToAppear(): void {
    Logger.debug('topRectHeightPx', this.topRectHeightPx.toString());
    this.getProjectCategory()
  }

  /**
   * 获取项目分类
   */
  private async getProjectCategory() {
    const resp = await HttpUtil.getInstance().get<CategoryModel[], undefined>('/project/tree/json');
    if (resp.errorCode === ErroCode.OK && resp.data && resp.data.length > 0) {
      this.categoryList = resp.data;
    }
  }

  @Builder
  tabBarItem(category: CategoryModel, index: number) {
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
            ForEach(this.categoryList, (category: CategoryModel, index: number) => {
              TabContent() {
                ArticleList({ category: category })
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