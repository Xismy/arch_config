import QtQuick
import qs.services
import qs.components

Button {
	id: network
	property string graph: "󰌙"
	property string name: ""
	text: name + graph

	Connections {
		target: NetworkService

		function onDefaultDeviceChanged() {
			graph = "󰌙"
			name = ""
		}

		function onAttributeUpdated(key: string, val: string) { 
			switch(key) {
				case "Name":
				name = val
				break
				case "Type":
				graph = val === "wifi"? "" : "󰈀"
				break
			}
		}
	}
}
