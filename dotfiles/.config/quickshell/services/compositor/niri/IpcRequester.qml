import QtQuick
import Quickshell.Io

Item {
	Process {
		id: request
	}

	function switchWorkspace(id: int) {
		request.command = ["niri", "msg", "action", "focus-workspace", id.toString()]
		request.running = true;
	}
}
