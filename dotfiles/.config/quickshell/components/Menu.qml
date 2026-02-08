import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.theme

Button {
	default property alias content: contentLoader.sourceComponent
	property string closedText: ''
	property string openedText: closedText
	property string closedFg: Colors.foreground
	property string openedFg: Colors.foreground
	property bool opened: false

	text: opened ? openedText : closedText
	fontColor: opened? openedFg : closedFg

	Component.onCompleted: {
		let parentItem = parent;
		while(parentItem) {
			if(parentItem.hasOwnProperty("hasExpandedSubmenu")) {
				openedChanged.connect(_ => {
					if(parentItem) {
						parentItem.hasExpandedSubmenu = opened;
					}
				});
				break;
			}
			parentItem = parentItem.parent;
		}
	}

	onClicked: function() {
		popup.anchor.window = QsWindow.window
		opened = !opened
		let pos = mapToGlobal(implicitWidth - popup.implicitWidth / 2, height)
		popup.anchor.rect.x = Math.max(Math.min(pos.x, Screen.width - popup.implicitWidth), 0)
		popup.anchor.rect.y = pos.y
	}

	onHoveredChanged: function() {
		closeTimer.running = !hovered
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
		visible: opened
		implicitWidth: popupArea.implicitWidth
		implicitHeight: popupArea.implicitHeight
		color: "transparent"

		Rectangle {
			id: shape
			width: parent.width
			height: 0
			color: Colors.background
			radius: 10
			border.color: Colors.foreground
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

			states: State {
				name: "opened"
				when: popup.visible

				PropertyChanges {
					target: shape
					height: popup.height
				}
			}

			transitions: Transition {
				NumberAnimation {
					properties: "height"
					duration: 300
					easing.type: Easing.InOutQuad
				}
			}

		}
	}
}
