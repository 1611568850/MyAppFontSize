import TitleBar from '../view/TitleBar'
import SetViewModel from '../viewmodel/SetView/setViewModel'
import ChatData from '../viewmodel/SetView/ChatData'
import ChatItem from '../view/ChatItem'
import StyleConstants from '../common/constants/StyleConstants'
import Slider from '../view/Slider'
import PreferencesUtil from '../common/database/PreferencesUtil'
import Logger from '../common/utils/Logger'

const TAG = '[SetFontSizePage]';

@Entry
@Component
struct SetFontSize {
    private contentArr = SetViewModel.initChatData();
    @State fontSizeText: Resource = $r("app.string.set_size_normal");
    @State changeFontSize: number = 0;

    onPageShow() {
        PreferencesUtil.getChangeFontSize().then((value) => {
            this.changeFontSize = value;
            this.fontSizeText = SetViewModel.getTextByFontSize(value)
            Logger.info(TAG, 'Get the value of changeFontSize: ' + this.changeFontSize);
        })
    }

    build() {
        Column() {
            TitleBar({ isBack: true, title: $r('app.string.set_title') })
            List() {
                ForEach(this.contentArr, (item: ChatData) => {
                    ListItem() {
                        ChatItem({ item: item ,changeFontSize: this.changeFontSize })
                    }
                }, (item: ChatData) => JSON.stringify(item))
            }
            .layoutWeight(StyleConstants.WEIGHT_FULL)

            Slider({ fontSizeText: $fontSizeText, changeFontSize: $changeFontSize })
        }
        .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
        .height(StyleConstants.FULL_HEIGHT)
        .width(StyleConstants.FULL_WIDTH)
    }
}