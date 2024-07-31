@Preview
@Component
export struct TextButton {
   text: string = "";
   fontColor?: ResourceColor = $r('app.color.white');
   pressedColor?: ResourceColor = $r('app.color.gray_white');
   onClickCallback: () => void = () => {
  };
  @State private _color?: ResourceColor = this.fontColor;

  build() {
    Text(this.text)
      .fontColor(this._color)
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .onClick(() => {
        this.onClickCallback()
      })
      .onTouch((event: TouchEvent) => {
        if (event.type === TouchType.Down) {
          this._color = this.pressedColor;
        } else {
          this._color = this.fontColor;
        }
      })
  }
}