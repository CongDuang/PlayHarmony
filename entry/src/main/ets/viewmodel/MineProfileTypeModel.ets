export default class MineProfileTypeModel {
  icon: Resource | null = null;
  content: string | ResourceStr = "";
  type: ProfileType;
}

type ProfileType = 'scores' | 'collect' | 'history' | 'about_me' | undefined;