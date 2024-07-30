import MainPageTypeModel from '../../viewmodel/MainPageTypeModel';
import MineProfileTypeModel from '../../viewmodel/MineProfileTypeModel';

export default class CommonConstants {
  static readonly TabBars_DEFAULT_MAIN_PAGE_TYPES: Array<MainPageTypeModel> = [
    {
      id: 0,
      name: "home",
      content: "首页",
      icon: $r('app.media.tab_bar_home'),
      selectedIcon: $r('app.media.tab_bar_selected_home'),
    },
    {
      id: 1,
      name: "project",
      content: "项目",
      icon: $r('app.media.tab_bar_project'),
      selectedIcon: $r('app.media.tab_bar_selected_project'),
    },
    {
      id: 2,
      name: "official_account",
      content: "公众号",
      icon: $r('app.media.tab_bar_official_account'),
      selectedIcon: $r('app.media.tab_bar_selected_official_account'),
    },
    {
      id: 3,
      name: "mine",
      content: "我的",
      icon: $r('app.media.tab_bar_mine'),
      selectedIcon: $r('app.media.tab_bar_selected_mine'),
    },
  ];
  static readonly MIME_PROFILE_DEFAULT_TYPES: MineProfileTypeModel[] = [
    {
      content: "我的积分",
      icon: $r('app.media.mine_scores'),
      type: 'scores',
    },
    {
      content: "我的收藏",
      icon: $r('app.media.mine_collection'),
      type: 'scores',
    },
    {
      content: "浏览历史",
      icon: $r('app.media.mine_history'),
      type: 'scores',
    },
    {
      content: "关于我",
      icon: $r('app.media.mine_about_me'),
      type: 'scores',
    },
  ];
}
