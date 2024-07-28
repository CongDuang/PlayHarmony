export default class MainPageTypeModel {
  id: number = 0;
  name: MainPageName = undefined;
  content: string = "";
  icon: Resource | null = null;
  selectedIcon: Resource | null = null;
}

type MainPageName = 'home' | 'project' | 'official_account' | 'mine' | undefined;