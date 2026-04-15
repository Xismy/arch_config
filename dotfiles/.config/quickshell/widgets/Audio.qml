import Quickshell.Services.Pipewire
import QtQuick
import qs.widgets.audio

Item {
	id: widget
	implicitWidth: nodes.implicitWidth
	implicitHeight: parent.height
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
		id: nodes
		spacing: 5
		height: widget.implicitHeight
		
		AudioNode {
			node: pw.source
			unmutedIcon: ""
			mutedIcon: ""
		}
		
		AudioNode {
			node: pw.sink
			unmutedIcon: ""
			mutedIcon: "󰟎"
		}

	}
}
