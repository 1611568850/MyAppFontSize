import SettingData from '../viewmodel/Home/SettingData'
import StyleConstants from '../common/constants/StyleConstants'

@Component
export default struct SettingItem {
    @Prop changeFontSize: number
    setting: SettingData = new SettingData()
    itemClick: Function = () => {
    }

    build() {
        Row() {
            Image(this.setting.settingImage)
                .height($r('app.float.setting_item_ic_size'))
                .width($r('app.float.setting_item_ic_size'))
                .margin({
                    left: $r('app.float.setting_ic_margin_left'),
                    right: $r('app.float.setting_ic_margin_right')
                })
            Text(this.setting.settingName)
                .fontColor($r('app.color.text'))
                .fontWeight(FontWeight.Medium)
                .fontSize(this.changeFontSize + StyleConstants.UNIT_FP)

        }
        .width(StyleConstants.FULL_WIDTH)
        .height($r('app.float.setting_item_height'))
        .onClick(() => {
            this.itemClick();
        })
    }
}