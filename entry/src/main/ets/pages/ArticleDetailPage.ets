import Logger from '../common/Logger';
import { TitleBar } from '../widgets/TitleBar'
import { router } from '@kit.ArkUI';
import { ArticleModel } from '../viewmodel/ArticleModel';
import { HtmlEntityReplace } from 'html_entities_replace';
import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct ArticleDetailPage {
  @State article?: ArticleModel | null = null;
  webviewCtrl = new webview.WebviewController();

  aboutToAppear(): void {
    this.article = (router.getParams() as DetailParam).article;
  }

  build() {
    Column() {
      TitleBar({ title: HtmlEntityReplace.replace(this.article?.title), showBack: true, showSearch: true })
      if (this.article?.link) {
        Web({
          src: this.article?.link!,
          controller: this.webviewCtrl
        }).layoutWeight(1)
      }
    }
  }
}

export class DetailParam {
  article: ArticleModel

  constructor(article: ArticleModel) {
    this.article = article;
  }
}