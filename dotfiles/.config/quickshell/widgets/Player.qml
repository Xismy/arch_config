import QtQuick
import qs.components
import qs.theme

Item {
	implicitWidth: buttonsSet.implicitWidth + 50
	implicitHeight: buttonsSet.implicitHeight + 10

	ListModel {
		id: buttons
		ListElement {
			icon: '󰒮'
		}
		ListElement {
			icon: ''
		}
		ListElement {
			icon: '󰒭'
		}
	}

	Row {
		id: buttonsSet
		anchors.centerIn: parent
		spacing: 25
		Repeater {
			model: buttons
			Button {
				text: model.icon
				fontSize: 64
			}
		}
	}
}
