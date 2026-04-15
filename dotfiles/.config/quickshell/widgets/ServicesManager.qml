import QtQuick
import qs.components
import qs.services
import qs.theme

Widget {
	Menu {
		text: ""

		Column {
			anchors.centerIn: parent
			spacing: 10

			Button {
				text: ""
				fontColor: Colors.blue
				onClicked: {
					SystemServices.refresh()
				}
			}

			Repeater {
				model: SystemServices.services

				Row {
					spacing: 10

					Button {
						text: ""
						fontColor: model.state === "active" ? Colors.green : Colors.red
						hoverText: model.state === "active" ? "" : ""
						onClicked: {
							if (model.state === "active") {
								SystemServices.stopService(model.name)
							} else {
								SystemServices.startService(model.name)
							}
						}
					}

					Label {
						anchors.verticalCenter: parent.verticalCenter
						text: model.name
					}
				}
			}
		}
	}
}
