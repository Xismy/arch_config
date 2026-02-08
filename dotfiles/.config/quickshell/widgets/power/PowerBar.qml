import QtQuick
import Quickshell.Io
import qs.components
import qs.config

Row {
	property int selected: 0
	id: popup
	spacing: 20

	ListModel {
		id: powerMenuModel
		ListElement { text: "⏻"; color: "#ff7060"; command: "poweroff" }
		ListElement { text: ""; color: "#4090ff"; command: "reboot" }
		ListElement { text: ""; color: "#ffaa55"; command: "lock" }
		ListElement { text: ""; color: "#00ffd0"; command: "logout" }
	}

	Process {
		id: process
	}

	Repeater {
		model: powerMenuModel

		Button {
			text: model.text
			font.pointSize: 24
			fontColor: model.color
			padding: 13
			focus: (index === popup.selected)

			onClicked: {
				let cmd = Config.powerCommands[model.command]
				if (cmd) {
					process.command = cmd
					process.running = true
				}
			}
		}
	}

	Keys.onPressed: (event) => {
		console.log("key pressed: " + event.key)
		if (event.key === Qt.Key_Right) {
			popup.selected = (popup.selected + 1) % powerMenuModel.count
			event.accepted = true
		} else if (event.key === Qt.Key_Left) {
			popup.selected = (popup.selected - 1 + powerMenuModel.count) % powerMenuModel.count
			event.accepted = true
		} else if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
			let btn = popup.children[popup.selected]
			btn.animateClick()
			event.accepted = true
		}
	}
}
