import Quickshell.Services.Pipewire
import QtQuick
import qs.components

Item {
	implicitWidth: buttons.implicitWidth
	implicitHeight: buttons.implicitHeight
	property string sourceIcon: pw.source && !pw.source.audio.muted? "" : ""
	property string sinkIcon: pw.sink && !pw.sink.audio.muted? "" : "󰟎"

	PwObjectTracker {
		property var source: !Pipewire.defaultAudioSource?.isSink? Pipewire.defaultAudioSource : null  
		property var sink: Pipewire.defaultAudioSink?.isSink? Pipewire.defaultAudioSink : null
		id: pw
		objects: [
			Pipewire.defaultAudioSource,
			Pipewire.defaultAudioSink,
			Pipewire.preferredDefaultAudioSource,
			Pipewire.preferredDefaultAudioSink
		]
	}

	Row {
		id: buttons
		spacing: 5

		Button {
			anchors.verticalCenter: parent.verticalCenter
			property string value: pw.source ? (pw.source.audio.volume * 100).toFixed(0) : ""
			id: sourceButton
			text: value + sourceIcon
			onClicked: {
				if(pw.source) {
					pw.source.audio.muted = !pw.source.audio.muted
				}
			}
		}

		Button {
			anchors.verticalCenter: parent.verticalCenter
			property string value: pw.sink ? (pw.sink.audio.volume * 100).toFixed(0) : ""
			id: sinkButton
			text: value + sinkIcon
			onClicked: {
				if(pw.sink) {
					pw.sink.audio.muted = !pw.sink.audio.muted
				}
			}
		}

		Menu {
			anchors.verticalCenter: parent.verticalCenter
			id: menu
			closedText: ""
			openedText: ""

			Column {
				spacing: 12

				Slider {
					id: sourceSlider
					width: 200
					text: sourceIcon
					visible: pw.source != null
					value: pw.source ? pw.source.audio.volume : 0
					onValueChanged: {
						if(pw.source) {
							pw.source.audio.volume = value
						}
					}
				}

				Slider {
					id: sinkSlider
					width: 200
					text: sinkIcon
					visible: pw.sink != null
					value: pw.sink ? pw.sink.audio.volume : 0
					onValueChanged: {
						if(pw.sink) {
							pw.sink.audio.volume = value
						}
					}
				}
			}
		}
	}
}
