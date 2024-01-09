import { ItemDirection } from './ItemDirection'

export default class ChatData {
    itemDirection: ItemDirection = ItemDirection.LEFT
    content: Resource = $r('app.string.empty')
}