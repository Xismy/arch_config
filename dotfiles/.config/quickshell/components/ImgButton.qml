import QtQuick
import QtQuick.Controls
import qs.theme

Button {
	id: button
	property alias source: img.source
	signal rightClicked()
	implicitHeight: 28
	implicitWidth: 28

	contentItem: Image {
		id: img
	}

	background: none

	TapHandler {
		id: mouseArea
		acceptedButtons: Qt.RightButton
		onSingleTapped: function(point, button) { 
			console.log(button)
			if(button === Qt.RightButton) {
				rightClicked();
			} 
		}
	}

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


