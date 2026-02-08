import Quickshell
import Quickshell.Widgets
import QtQuick
import qs.widgets
import qs.theme

PanelWindow {
	default property alias content: contentLoader.sourceComponent
	property bool autoHide: true
	property bool flashing: false
	id: panel
	exclusionMode: autoHide ? ExclusionMode.Ignore : ExclusionMode.Auto
	implicitWidth: shape.implicitWidth
	implicitHeight: shape.implicitHeight + shape.y
	color: "transparent"

	MouseArea {
		property bool hovered: false
		property bool hasExpandedSubmenu: false
		id: panelArea
		anchors.fill: parent

		hoverEnabled: true

		onEntered: {
			hovered = true
		}

		onExited: {
			hovered = false
		}

		Rectangle {
			id: shape
			color: Colors.background
			border.color: Colors.foreground
			border.width: 3
			radius: Math.min(implicitWidth, implicitHeight) / 2
			topLeftRadius: panel.anchors.top || panel.anchors.left? 0 : radius
			topRightRadius: panel.anchors.top || panel.anchors.right? 0 : radius
			bottomLeftRadius: panel.anchors.bottom || panel.anchors.left? 0 : radius
			bottomRightRadius: panel.anchors.bottom || panel.anchors.right? 0 : radius

			Loader {
				id: contentLoader	
				anchors.centerIn: parent
			}

			states: [
				State {
					name: "expanded"
					when: panelArea.hovered || !panel.autoHide || panelArea.hasExpandedSubmenu || panel.flashing
					PropertyChanges {
						target: shape 
						x: panel.anchors.left? -shape.border.width : panel.anchors.right? shape.border.width : 0
						y: panel.anchors.top? -shape.border.width : panel.anchors.bottom? shape.border.width : 0
						implicitWidth: panel.anchors.right || panel.anchors.left? contentLoader.implicitWidth - shape.border.width : contentLoader.implicitWidth
						implicitHeight: panel.anchors.top || panel.anchors.bottom? contentLoader.implicitHeight - shape.border.width : contentLoader.implicitHeight
					}
				},
				State {
					name: "collapsed"
					when: !panelArea.hovered && panel.autoHide && !panelArea.hasExpandedSubmenu && !panel.flashing
					PropertyChanges {
						target: shape
						x: panel.anchors.left? -contentLoader.implicitWidth + border.width : 0
						y: panel.anchors.top? -contentLoader.implicitHeight + border.width : 0
						implicitWidth: panel.anchors.right || panel.anchors.left? shape.border.width : contentLoader.implicitWidth
						implicitHeight: panel.anchors.top || panel.anchors.bottom? shape.border.width : contentLoader.implicitHeight
					}
				}
			]

			transitions: [
				Transition {
					NumberAnimation {
						properties: "x,y,implicitWidth,implicitHeight"
						duration: 200
						easing.type: Easing.InOutQuad
					}
				}
			]
		}
	}

	Timer {
		id: flashHide
		interval: 800
		repeat: false
		onTriggered: {
			panel.flashing = false
		}
	}

	onFlashingChanged: {
		if(flashing) {
			flashHide.running = true
		}
	}
}
