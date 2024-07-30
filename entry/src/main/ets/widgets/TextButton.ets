@Preview
@Component
export struct TextButton {
  text: string = "";
  fontColor?: ResourceColor = $r('app.color.white');
  pressedColor?: ResourceColor = $r('app.color.gray_white');
  onClickCallback: () => void = () => {
  };

  build() {
    Text(this.text)
      .stateStyles({
        pressed: {
          .backgroundColor('#1a000000')
        },
        normal: {
          .backgroundColor(Color.Transparent)
        },
      })
      .fontColor(this.fontColor)
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .onClick(() => {
        this.onClickCallback()
      })
  }
}