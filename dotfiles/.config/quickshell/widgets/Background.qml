import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.services

PanelWindow {
	id: background
	WlrLayershell.layer: WlrLayer.Background
	exclusionMode: ExclusionMode.Ignore
	color: "#111111"
	anchors {
		top: true
		bottom: true
		left: true
		right: true
	}

	Image {
		property int target: 0
		id: bg
		anchors.fill: parent
		states: [
			State {
				name: "visible"
				when: bg.target === 0
				PropertyChanges {
					target: bg
					opacity: 1
				}
			},
			State {
				name: "hidden"
				when: bg.target !== 0
				PropertyChanges {
					target: bg
					opacity: 0.0
				}
			}
		]
		transitions: [
			Transition {
				from: "visible"
				to: "hidden"
				NumberAnimation {
					properties: "opacity"
					duration: 50
				}
				onRunningChanged: {
					if(running === false) {
						bg.source = Quickshell.shellDir + "/images/" + CompositorService.workspacesList.get(bg.target - 1).name
						bg.target = 0
					}
				}
			},
			Transition {
				from: "hidden"
				to: "visible"
				NumberAnimation {
					properties: "opacity"
					duration: 1000
				}
			}
		]
	}

	Connections {
		target: CompositorService

		function onWorkspaceActivated(next: int) { 
			bg.target = next
		}
	}

}
