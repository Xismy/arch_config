pragma Singleton
import QtQuick
import Quickshell.Io

Item {
	id: service
	property variant defaultDevice: {id:""}
	signal defaultServiceChanged()
	signal attributeUpdated(string key, string val)

	Connections {
		target: NetworkService
		function onDefaultServiceChanged() {
			pollService.running = true	
		}
	}

	Process {
		id: monitor
		running: true
		command: ["connmanctl", "monitor"]
		stdout: SplitParser {
			onRead: function(line: string) {
				let parts = line.trim().split(/ +/)

				if(parts[0].indexOf("*") !== -1) {
					defaultDevice = {
						id: parts[3]
					}

					defaultServiceChanged()
					return
				}


				if(parts[0] === "Service" && parts[1] === defaultDevice.id) {
					let key = parts[2]
					let val = parts.slice(3).join(" ")
					defaultDevice[key] = val
					attributeUpdated(key, val)
				}
			}
		}
	}

	Process {
		id: pollService
		running: false
		command: ["connmanctl", "services", service.defaultDevice.id]
		stdout: SplitParser {
			onRead: function(line: string) {
				let parts = line.trim().split(/ +/)
				let key = parts[0]
				let val = parts.slice(2).join(" ")
				defaultDevice[key] = val
				attributeUpdated(key, val)
			}
		}
	}

	Process {
		id: pollServices
		running: true
		command: ["connmanctl", "services"]
		stdout: SplitParser {
			onRead: function(line: string) {
				let parts = line.trim().split(/ +/)

				if(parts[0].indexOf("*") !== -1) {
					defaultDevice = {
						id: parts[2]
					}
					defaultServiceChanged()
					return
				}
			}
		}
	}
}
