import QtQuick
import qs.components
import qs.theme

Widget {
	required property var node
	required property string unmutedIcon
	required property string mutedIcon
	property string icon_: node && !node.audio.muted? unmutedIcon : mutedIcon

	Row {
		id: buttons

		Menu {
			property string value: node ? (node.audio.volume * 100).toFixed(0) : ""
			closedText: value
			Slider {
				width: 200
				text: icon_
				visible: node != null
				value: node ? node.audio.volume : 0
				onValueChanged: {
					if(node) {
						node.audio.volume = value
					}
				}
			}

		}

		Button {
			text: icon_
			onClicked: {
				if(node) {
					node.audio.muted = !node.audio.muted
				}
			}
		}
	}
}
