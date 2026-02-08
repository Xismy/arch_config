import QtQuick
import Quickshell.Wayland
import qs.services
import qs.components
import qs.config
import qs.theme

Column {
	function mapIcon(app: string, title: string) : string {
		return Config.windowsIcons[app] ?? app;
	} 

	Row {
		id: list 
		anchors.horizontalCenter: parent.horizontalCenter

		Repeater {
			model: SortFilterProxyModel {
				model:CompositorService.windowsList

				filters: ValueFilter {
					roleName: "ws"
					value: CompositorService.activeWorkspaceId
				}
			}

			Button {
				readonly property bool active: model.id === CompositorService.activeWindowId
				id: icon

				onActiveChanged: {
					if(active) {
						label.text = model.title
						list.anchors.horizontalCenterOffset = list.width / 2 - icon.x - icon.width / 2
					}
				}

				text: mapIcon(model.appId, model.title)
				fontSize: active? Fonts.size : Fonts.size * 0.6
				fontBold: active
				fontColor: active? Colors.secondary : Colors.inactive
			}

		}
	}

	Label {
		id: label
		anchors.horizontalCenter: parent.horizontalCenter
		text: ""
		font.pixelSize: Fonts.size * 0.7
	}
}
