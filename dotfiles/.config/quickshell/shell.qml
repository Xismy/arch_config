//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components
import qs.widgets
import qs.theme

ShellRoot {
	PanelWindow {
		id: bar
		color: "transparent"
		anchors.top: true
		implicitWidth: Screen.width * 0.8
		implicitHeight: Sizes.barHeight

		RowLayout {
			id: left
			spacing: Sizes.widgetSpacing
			anchors.left: parent.left
			anchors.right: middle.left
			height: parent.height
			Network {}
			Audio {}
			Windows {Layout.fillWidth: true}
		}
		Rectangle {
			id: middle
			implicitWidth: clock.implicitWidth * 2
			height: parent.height
			anchors.horizontalCenter: parent.horizontalCenter
			color: Colors.widgetBg
			bottomLeftRadius: height / 2
			bottomRightRadius: height / 2
			Clock {
				id: clock
				color: "transparent"
				anchors.centerIn: parent
			}
		}
		RowLayout {
			id: right
			spacing: Sizes.widgetSpacing
			anchors.right: parent.right
			anchors.left: middle.right
			height: parent.height
			Tray {Layout.fillWidth: true}
			ServicesManager {}
			Power {}
		}
	}

	Panel {
		id: workspaces
		anchors.left: true
		exclusionMode: ExclusionMode.Ignore
		implicitWidth: wsMenu.implicitWidth
		implicitHeight: wsMenu.implicitHeight

		FlashingMenu {
			id: wsMenu
			Workspaces {}
		}
	}

	Dialog {
		id: dialog
	}

	IpcHandler {
		target: "bar"
		function toggleAutoHide() {
			bar.autoHide = !bar.autoHide
		}
		function flashShow() {
			bar.flashing = true
		}
	}

	IpcHandler {
		target: "dialog"
		function showPowerBar() {
			dialog.content = Qt.createComponent("widgets/power/PowerBar.qml")
			dialog.scale = 2
			dialog.visible = true
		}
	}

	Component.onCompleted: {
		CompositorService.onWorkspaceActivated.connect(ws => {
			//bar.flashing = true
			BackgroundService.setBackground(CompositorService.workspacesList.get(ws - 1).name);
		});
	}
}
