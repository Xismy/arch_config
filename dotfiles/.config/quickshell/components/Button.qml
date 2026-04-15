import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import qs.theme

Button {
	property string fontColor: Colors.foreground
	property string hoverText: text
	property alias fontFamily: label.font.family
	property alias fontSize: label.font.pixelSize
	property alias fontBold: label.font.bold

	id: button

	contentItem: Text {
		id: label
		text: button.hovered ? button.hoverText : button.text
		font {
			family: Fonts.family
			pixelSize: Fonts.size
			bold: true
		}
		color: button.hovered ? Colors.foreground : fontColor
	}

	background: null

	states: [
		State {
			when: button.pressed
			name: "pressed"
			PropertyChanges {
				target: button
				scale: 0.75
			}
		}
	]

	transitions: [
		Transition {
			NumberAnimation {
				properties: "scale"
				duration: 100
				easing.type: Easing.InOutQuad
			}
		}
	]
}


