import CommonConstants from '../common/constants/CommonConstants'
import StyleConstants from '../common/constants/StyleConstants'
import ChatData from '../viewmodel/SetView/ChatData'
import { ItemDirection } from '../viewmodel/SetView/ItemDirection'

@Component
export default struct ChatItem {
    item: ChatData = new ChatData()
    @Prop changeFontSize: number;
    @State isLineFeed: boolean = false;

    build() {
        Column() {
            Row() {
                Image(this.item.itemDirection === ItemDirection.RIGHT ? $r('app.media.right_head') : $r('app.media.left_head'))
                    .width(StyleConstants.SET_CHAT_HEAD_SIZE_PERCENT)
                    .margin({
                        left: this.item.itemDirection === ItemDirection.RIGHT
                            ? StyleConstants.HEAD_LEFT_PERCENT : StyleConstants.HEAD_RIGHT_PERCENT,
                        right: this.item.itemDirection === ItemDirection.RIGHT
                            ? StyleConstants.HEAD_RIGHT_PERCENT : StyleConstants.HEAD_LEFT_PERCENT
                    })
                Row() {
                    Text(this.item.content)
                        .fontWeight(FontWeight.Medium)
                        .fontSize(this.changeFontSize + StyleConstants.UNIT_FP)
                        .fontColor($r('app.color.text'))
                        .onAreaChange((oldValue, newValue) => {
                            this.isLineFeed = newValue.height > StyleConstants.DOUBLE_ROW_MIN
                        })

                }
                .constraintSize({ maxWidth: StyleConstants.MAX_CHAT_WIDTH_PERCENT })
                .backgroundColor(this.item.itemDirection === ItemDirection.RIGHT
                    ? $r('app.color.set_chat_right_bg') : $r('app.color.set_chat_left_bg'))
                .borderRadius($r('app.float.set_chat_content_bg_radius'))
                .padding({
                    left: $r('app.float.set_chat_content_vertical_padding'),
                    right: $r('app.float.set_chat_content_vertical_padding'),
                    top: $r('app.float.set_chat_content_horizontal_padding'),
                    bottom: $r('app.float.set_chat_content_horizontal_padding')
                })

            }
            .width(StyleConstants.FULL_WIDTH)
            .direction(this.item.itemDirection === ItemDirection.RIGHT ? Direction.Rtl : Direction.Ltr)
            .margin({ top: StyleConstants.CHAT_TOP_MARGIN_PERCENT })
            .alignItems(VerticalAlign.Top)

        }
    }
}