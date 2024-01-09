import CommonConstants from '../common/constants/CommonConstants'
import StyleConstants from '../common/constants/StyleConstants'
import SettingItem from '../view/SettingItem'
import SettingData from '../viewmodel/Home/SettingData'
import TitleBar from '../view/TitleBar'
import HomeViewModel from '../viewmodel/Home/HomeViewModel'
import router from '@ohos.router'
import PreferencesUtil from '../common/database/PreferencesUtil'
import Logger from '../common/utils/Logger'

const TAG = '[HomePage]';

@Entry
@Component
struct HomePage {
    private settingArr = HomeViewModel.initSettingData()
    @State changeFontSize: number = CommonConstants.SET_SIZE_NORMAL;

    onPageShow() {
        PreferencesUtil.getChangeFontSize().then((value) => {
            this.changeFontSize = value;
            Logger.info(TAG, 'Get the value of changeFontSize: ' + this.changeFontSize);
        });
    }

    @Builder SettingItems() {
        List() {
            ForEach(this.settingArr.slice(CommonConstants.START_INDEX, CommonConstants.END_INDEX),
                (item: SettingData, index?: number) => {
                    ListItem() {
                        SettingItem({
                            setting: item,
                            itemClick: () => {
                                if (index === CommonConstants.SET_FONT_INDEX) {
                                    router.pushUrl({
                                        url: CommonConstants.SET_URL
                                    })
                                }
                            },
                            changeFontSize:this.changeFontSize
                        })
                    }
                }, (item: SettingData) => JSON.stringify(item))
        }
    }

    build() {
        Column() {
            TitleBar({ isBack: false, title: $r('app.string.home_title') })

            Row() {
                SettingItem({
                    setting: this.settingArr[CommonConstants.DISPLAY_INDEX],
                    itemClick: () => {
                    }
                })
            }
            .blockBackground(StyleConstants.BLOCK_TOP_MARGIN_FIRST_PERCENT)

            Row() {
                SettingItem({
                    setting: this.settingArr[CommonConstants.VOICE_INDEX],
                    itemClick: () => {
                    }
                })
            }
            .blockBackground(StyleConstants.BLOCK_TOP_MARGIN_SECOND_PERCENT)

            Row() {
                this.SettingItems()
            }
            .blockBackground(StyleConstants.BLOCK_TOP_MARGIN_SECOND_PERCENT)

        }
        .height(StyleConstants.FULL_HEIGHT)
        .width(StyleConstants.FULL_WIDTH)
        .backgroundColor($r('sys.color.ohos_id_color_sub_background'))

    }
}

@Extend(Row) function blockBackground(marginTop: string) {
    .backgroundColor(Color.White)
    .borderRadius($r('app.float.block_background_radius'))
    .margin({ top: marginTop })
    .width(StyleConstants.BLOCK_WIDTH_PERCENT)
    .padding({ top: $r('app.float.block_vertical_padding'), bottom: $r('app.float.block_vertical_padding') })
}