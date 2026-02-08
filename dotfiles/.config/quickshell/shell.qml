import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import qs.services
import qs.components
import qs.widgets
import qs.theme

ShellRoot {
	Background {}
	Panel {
		id: bar
		anchors.top: true

		Item {
			implicitWidth: Screen.width * 0.8
			implicitHeight: Math.max(workspacesPanel.implicitHeight, windows.implicitHeight, rightPanel.implicitHeight)

			Workspaces {
				id: workspacesPanel
				anchors {
					left: parent.left
					leftMargin: 10
					verticalCenter: parent.verticalCenter
				}
			}

			Windows {
				id: windows
				anchors{
					horizontalCenter: parent.horizontalCenter
					verticalCenter: parent.verticalCenter
				}
			}

			Row {
				id: rightPanel
				anchors {
					right: parent.right
					rightMargin: 10
					verticalCenter: parent.verticalCenter
				}

				spacing: 24

				Network {}
				Audio {}
				Clock {}
				Tray {}
				ServicesManager {}
				Power {}
			}
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
			bar.flashing = true
		});
	}
}
