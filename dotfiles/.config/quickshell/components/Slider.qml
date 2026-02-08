import QtQuick.Controls
import QtQuick
import QtQuick.Effects
import qs.components
import qs.theme

Row {
	property alias text: label.text
	property alias value: control.value
	width: 100

	Label {
		id: label
	}

	Slider {
		id: control
		implicitWidth: parent.width - label.implicitWidth
		implicitHeight: label.implicitHeight

		background: Rectangle {
			id: bar
			x: control.leftPadding
			y: control.topPadding
			implicitWidth: control.availableWidth - control.leftPadding - control.rightPadding
			implicitHeight: control.availableHeight - control.topPadding - control.bottomPadding
			radius: height / 2
			border {
				width: 2
				color: Colors.foreground
			}
			color: Colors.background

			Item {
				id: fillingBar
				height: parent.height
				width: parent.width
				visible: false
				layer.enabled: true

				Rectangle {
					x: control.visualPosition * width - width
					height: parent.height
					width: parent.width
					color: Colors.primary
					topRightRadius: width / 2
					bottomRightRadius: width / 2
				}
			}

			Rectangle {
				id: mask
				height: parent.height
				width: parent.width
				color: "black"
				radius: height / 2
				layer.enabled: true
				visible: false
			}

			MultiEffect {
				source: fillingBar
				x: bar.border.width
				y: bar.border.width
				width: fillingBar.width - bar.border.width * 2
				height: fillingBar.height - bar.border.width * 2
				maskEnabled: true
				maskSource: mask
			}

		}

		handle: Rectangle {
			visible: false
		}
	}
}
