import { router } from '@kit.ArkUI';

@Preview
@Component
export struct TitleBar {
  title?: Resource | string = "";
  showBack?: boolean = false;
  showSearch?: boolean = false;
  onBack: () => void = () => router.back();
  onSearch?: () => void;

  build() {
    Row() {
      SymbolGlyph($r('sys.symbol.arrow_left'))
        .fontSize(22)
        .fontColor([$r('app.color.white')])
        .padding({
          left: 16,
          right: 16,
          top: 12,
          bottom: 12
        })
        .visibility(this.showBack ? Visibility.Visible : Visibility.Hidden)
        .onClick(this.onBack)
      Text(this.title ?? "")
        .fontColor($r('app.color.white'))
        .fontSize(18)
        .width('100%')
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)

      SymbolGlyph($r('sys.symbol.magnifyingglass'))
        .fontSize(22)
        .fontColor([$r('app.color.white')])
        .padding({
          left: 16,
          right: 16,
          top: 12,
          bottom: 12
        })
        .visibility(this.showSearch ? Visibility.Visible : Visibility.Hidden)
        .onClick(this.onSearch)
    }
    .width('100%')
    .backgroundColor($r('app.color.primary_color'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}