import QtQuick
import Quickshell
import Quickshell.Io
import qs.theme
import qs.services
import qs.components
import qs.config

Widget {
	Process {
		id: launcher
		command: Config.launcherCommands
	}

	Row {
		id: list

		Repeater {
			model: CompositorService.workspacesList

			Button {
				text: model.name
				fontColor: model.id === CompositorService.activeWorkspaceId? Colors.primary : Colors.foreground
				onClicked: {
					CompositorService.switchWorkspace(model.id)
				}
			}
		}
	}
}
