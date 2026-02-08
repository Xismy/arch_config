import QtQuick
import Quickshell
import Quickshell.Io
import qs.theme
import qs.services
import qs.components
import qs.config

Item {
	implicitWidth: list.implicitWidth
	implicitHeight: list.implicitHeight

	Process {
		id: launcher
		command: Config.launcherCommands
	}

	Row {
		id: list
		spacing: 15
		height: parent.height

		Repeater {
			model: CompositorService.workspacesList

			Button {
				anchors.verticalCenter: list.verticalCenter
				text: model.name
				fontColor: model.id === CompositorService.activeWorkspaceId? Colors.primary : Colors.foreground
				onClicked: {
					CompositorService.switchWorkspace(model.id)
				}
			}
		}
	}
}
