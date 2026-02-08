import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import qs.widgets
import qs.theme

PanelWindow {
	default property alias content: contentLoader.sourceComponent
	property alias scale: shape.scale
	id: dialog
	visible: false
	WlrLayershell.layer: WlrLayer.Overlay
	implicitWidth: shape.implicitWidth * scale
	implicitHeight: shape.implicitHeight * scale
	color: "transparent"
	focusable: true

	Rectangle {
		id: shape
		implicitWidth: contentLoader.implicitWidth
		implicitHeight: contentLoader.implicitHeight
		anchors {
			verticalCenter: parent.verticalCenter
			horizontalCenter: parent.horizontalCenter
		}
		color: Colors.background
		border.color: Colors.foreground
		border.width: 3
		radius: implicitHeight / 2

		Loader {
			id: contentLoader	
			anchors.centerIn: parent
			focus: true
		}

		Keys.onPressed: (event) => {
			if (event.key === Qt.Key_Escape) {
				dialog.visible = false;
				event.accepted = true;
			}
		}

		onActiveFocusChanged: {
			if (!activeFocus) {
				dialog.visible = false;
			}
		}
	}
}
