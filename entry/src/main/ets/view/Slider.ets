import CommonConstants from '../common/constants/CommonConstants';
import StyleConstants from '../common/constants/StyleConstants'
import setViewModal from '../viewmodel/SetView/setViewModel'
import PreferencesUtil from '../common/database/PreferencesUtil';

@Component
export default struct SliderLayout {
    @Link fontSizeText: Resource;
    @Link changeFontSize: number;

    build() {
        Column() {
            Text($r('app.string.set_font_size'))
                .fontSize($r('app.float.set_text'))
                .fontColor($r('app.color.text'))
                .margin({
                    left: StyleConstants.SLIDER_LAYOUT_LEFT_PERCENT,
                    top: StyleConstants.SLIDER_LAYOUT_TOP_PERCENT
                })
                .fontWeight(FontWeight.Medium)
            Column() {
                Text(this.fontSizeText)
                    .fontSize($r('app.float.set_text'))
                    .fontColor($r('app.color.text'))
                Row() {
                    Text($r('app.string.set_char_a'))
                        .fontColor($r('app.color.text'))
                        .fontSize($r('app.float.set_small_a'))
                        .fontWeight(FontWeight.Medium)
                        .textAlign(TextAlign.End)
                        .width(StyleConstants.A_WIDTH_PERCENT)
                        .padding({ right: $r('app.float.a_right_padding') })
                    Slider({
                        value: this.changeFontSize === CommonConstants.SET_SIZE_HUGE
                            ? CommonConstants.SET_SLIDER_MAX : this.changeFontSize,
                        max: CommonConstants.SET_SLIDER_MAX,
                        min: CommonConstants.SET_SLIDER_MIN,
                        step: CommonConstants.SET_SLIDER_STEP,
                        style: SliderStyle.InSet
                    })
                        .showSteps(true)
                        .width(StyleConstants.SLIDER_WIDTH_PERCENT)
                        .onChange(async (value: number) => {
                            if (this.changeFontSize === 0) {
                                this.changeFontSize = await PreferencesUtil.getChangeFontSize()
                                this.fontSizeText = setViewModal.getTextByFontSize(value)
                                return
                            }
                            this.changeFontSize = (value === CommonConstants.SET_SLIDER_MAX ?
                            CommonConstants.SET_SIZE_HUGE : value)

                            this.fontSizeText = setViewModal.getTextByFontSize(this.changeFontSize);
                            PreferencesUtil.saveChangeFontSize(this.changeFontSize)
                        })

                    Text($r('app.string.set_char_a'))
                        .fontColor($r('app.color.text'))
                        .fontSize($r('app.float.set_big_a'))
                        .fontWeight(FontWeight.Bold)
                        .width(StyleConstants.A_WIDTH_PERCENT)
                        .padding({ left: $r('app.float.a_left_padding') })
                }
            }
            .backgroundColor(Color.White)
            .borderRadius($r('app.float.block_background_radius'))
            .width(StyleConstants.BLOCK_WIDTH_PERCENT)
            .padding({ top: $r('app.float.slider_top_padding'), bottom: $r('app.float.slider_bottom_padding') })
            .margin({
                left: StyleConstants.SLIDER_HORIZONTAL_MARGIN_PERCENT,
                right: StyleConstants.SLIDER_HORIZONTAL_MARGIN_PERCENT,
                top: StyleConstants.SLIDER_TOP_MARGIN_PERCENT,
                bottom: StyleConstants.SLIDER_BOTTOM_MARGIN_PERCENT
            })
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.End)
    }
}