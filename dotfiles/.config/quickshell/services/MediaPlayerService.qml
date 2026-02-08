pragma Singleton
import Quickshell
import QtQuick
import qs.config

Item {
	id: service
	property string state: "N/A"

	Loader {
		source: Quickshell.shellDir + "/services/media_player/Mpd.qml"
		onLoaded: {
			service.state = state
		}
	}
}
