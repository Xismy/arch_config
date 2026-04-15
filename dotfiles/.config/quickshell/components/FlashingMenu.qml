import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.theme

Button {
	id: button
	default property alias content: contentLoader.sourceComponent
	property bool opened: false

	onHoveredChanged: function() {
		if(hovered) {
			opened = !opened
		}
		else {
			closeTimer.running = !hovered
		}
	}

	Timer {
		id: closeTimer
		interval: 100
		repeat: false
		running: false
		onTriggered: {
			if(!popupArea.containsMouse) opened = false
		}
	}

	PopupWindow {
		id: popup
		visible: shape.state === "opened"
		anchor {
			item: parent
			adjustment: PopupAdjustment.None
			rect {
				x: 0
				y: -implicitHeight / 2 + button.implicitHeight / 2
				height: implicitHeight
				width: implicitWidth
			}
		}
		implicitWidth: popupArea.implicitWidth
		implicitHeight: popupArea.implicitHeight
		color: "transparent"

		Rectangle {
			id: shape
			width: 0
			height: popup.height
			color: Colors.background
			radius: 10
			topLeftRadius: 0
			bottomLeftRadius: 0
			border.width: 0
			clip: true

			WrapperMouseArea {
				id: popupArea
				hoverEnabled: true
				margin: 24

				onEntered: function() {
					closeTimer.running = false
				}

				onExited: function() {
					closeTimer.running = true
				}

				Loader {
					id: contentLoader
				}
			}

			states: [
				State {
					name: "opened"
					when: button.opened

					PropertyChanges {
						target: shape
						width: popup.width
					}
				},
				State {
					name: "closed"
					when: !button.opened

					PropertyChanges {
						target: shape
						width: 0
					}
				}
			]

			transitions: Transition {
				NumberAnimation {
					properties: "width"
					duration: 100
					easing.type: Easing.InOutQuad
				}
			}

		}
	}
}
