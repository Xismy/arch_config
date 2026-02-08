import QtQuick
import QtQuick.Controls
import qs.components
import qs.theme

Item {
	id: widget
	signal dateCopied(string dateString)
	property int yearShown: new Date().getFullYear()
	property int year: new Date().getFullYear()
	property int month: new Date().getMonth()
	property int day: new Date().getDate()

	implicitWidth: calendar.implicitWidth
	implicitHeight: calendar.implicitHeight + yearSelector.implicitHeight + 20

	Row{
		anchors.horizontalCenter: parent.horizontalCenter

		Button {
			text: "<"
			font.pixelSize: 24
			onClicked: {
				widget.yearShown -= 1
			}
		}

		Label {
			id: yearSelector
			text: yearShown
			color: Colors.primary
			font.pixelSize: 24
		}

		Button {
			text: ">"
			font.pixelSize: 24
			onClicked: {
				widget.yearShown += 1
			}
		}

		Button {
			text: "󰃶"
			font.pixelSize: 24
			onClicked: {
				let today = new Date()
				widget.yearShown = today.getFullYear()
				widget.year = today.getFullYear()
				widget.month = today.getMonth()
				widget.day = today.getDate()
			}
		}

		Button {
			text: ""
			font.pixelSize: 24
			onClicked: {
				dateCopied(Qt.formatDate(new Date(widget.year, widget.month, widget.day), "dd/MM/yyyy"))
			}
		}
	}

	Grid {
		y: yearSelector.implicitHeight + 10
		id: calendar
		anchors.left: parent.left
		anchors.right: parent.right
		columns: 3
		rows: 4
		padding: 10
		spacing: 10

		Repeater {
			model: 12

			Rectangle {
				implicitWidth: monthCell.implicitWidth
				implicitHeight: monthCell.implicitHeight
				color: Colors.background
				border.color: Colors.foreground
				border.width: 2
				radius: 10

				Column {
					id: monthCell
					padding: 10
					Label {
						anchors.horizontalCenter: parent.horizontalCenter
						text: Qt.formatDate(new Date(0, index, 1), "MMMM")
						font.pixelSize: 20
						color: Colors.secondary
					}

					MonthGrid {
						id: monthGrid
						month: index
						year: widget.yearShown
						anchors.horizontalCenter: parent.horizontalCenter
						delegate: Label {
							property bool selected_: widget.day === model.day && widget.month === monthGrid.month && widget.year === monthGrid.year
							property bool weekend_: index % 7 >= 5
							text: model.day
							opacity: model.month === monthGrid.month? 1.0 : 0
							color: selected_ && model.today? Colors.primary : weekend_? Colors.red : Colors.foreground
							font {
								bold: true
								pixelSize: 16
							}
							background: Rectangle {
								color: selected_? Colors.secondary : model.today? Colors.primary : Colors.background
								radius: 5
							}
						}

						onClicked: function(date) {
							widget.day = date.getDate()
							widget.month = date.getMonth()
							widget.year = date.getFullYear()
						}
					}
				}
			}
		}
	}
}
