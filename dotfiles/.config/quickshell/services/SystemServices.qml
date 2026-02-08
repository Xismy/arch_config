pragma Singleton
import QtQuick
import Quickshell.Io
import qs.config

Item {
	property int pollIdx: 0
	property var services:	ListModel {}

	Process {
		id: checkCommand
		command: ["systemctl", "--user", "show", Config.services[pollIdx], "--property=ActiveState"]
		stdout: SplitParser {
			onRead: data => {
				if(services.count <= pollIdx) {
					services.append({ name: Config.services[pollIdx], state: data.trim().split("=")[1] })
				} else {
					services.setProperty(pollIdx, "state", data.trim().split("=")[1])
				}

				pollIdx = pollIdx + 1
			}
		}
		running: pollIdx < Config.services.length
	}

	Process {
		id: controlCommand
		property string selectedServiceName: ""
		property string action: ""
		running: false
		command: ["systemctl", "--user", action, selectedServiceName]
	}


	Timer {
		id: waitAndRefresh
		running: false
		repeat: false
		interval: 500
		onTriggered: {
			refresh()
		}
	}

	function refresh() {
		pollIdx = 0
	}

	function startService(name: string) {
		controlCommand.selectedServiceName = name;
		controlCommand.action = "start";
		controlCommand.running = true;
		waitAndRefresh.running = true;
	}

	function stopService(name: string) {
		controlCommand.selectedServiceName = name;
		controlCommand.action = "stop";
		controlCommand.running = true;
		waitAndRefresh.running = true;
	}
}

