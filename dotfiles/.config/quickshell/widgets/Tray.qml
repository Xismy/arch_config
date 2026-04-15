import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import qs.components

Widget {
	id: tray
	align: right

	Row {
		Repeater {
			model: SystemTray.items
			ImgButton {
				id: button
				source: modelData.icon
				onClicked: function() {
					modelData.activate();
				}
				onRightClicked: function() {
					menu.menu = modelData.menu
					menu.anchor.item = button
					menu.anchor.margins.top = height
					menu.open()
				}
			}
		}

		QsMenuAnchor {
			id: menu
		}
	}
}
