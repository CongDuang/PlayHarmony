import MainPageTypeModel from '../../viewmodel/MainPageTypeModel';

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
}