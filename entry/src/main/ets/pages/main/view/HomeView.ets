import HttpUtil from '../../../utils/HttpUtil'
import { TitleBar } from '../../../widgets/TitleBar'
import BaseResp, { ErroCode } from '../../../models/BaseResp'
import { HomeBannerModel } from '../../../viewmodel/HomeBannerModel'

@Preview
@Component
export struct HomeView {
  @State banners: HomeBannerModel[] = [];

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
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}