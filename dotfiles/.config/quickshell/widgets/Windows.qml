import QtQuick
import Quickshell.Wayland
import qs.services
import qs.components
import qs.config
import qs.theme

Widget {
	function mapIcon(app: string, title: string) : string {
		return Config.windowsIcons[app] ?? app;
	} 

	Row {
		property var activeChild: null
		id: list 
		anchors.centerIn: parent
		anchors.horizontalCenterOffset: implicitWidth / 2 - activeChild?.implicitWidth / 2 - activeChild?.x ?? 0

		Repeater {
			id: repeater
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
						list.activeChild = icon
					}
				}

				text: mapIcon(model.appId, model.title) + (active? " " + model.appId : "")
				fontSize: active? Fonts.size : Fonts.size * 0.6
				fontBold: active
				fontColor: active? Colors.secondary : Colors.inactive
			}

		}
	}
}
