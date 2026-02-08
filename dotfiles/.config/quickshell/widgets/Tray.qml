import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Controls
import qs.components


Row {

	Repeater {
		model: SystemTray.items
		/*Button {
			id: button
			text: modelData.icon
			acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
			onClicked: function(event) {
				if(event.button === Qt.LeftButton) {
					modelData.activate()
				} else if(event.button === Qt.RightButton) {
					menu.menu = modelData.menu
					menu.anchor.item = button
					menu.open()
				} else if(event.button === Qt.MiddleButton) {
					modelData.secondaryActivate()
				}
			}
		}*/
		Image {
			source: modelData.icon
			width: 32
			height: 32
		}
	}

	QsMenuAnchor {
		id: menu
	}
}
