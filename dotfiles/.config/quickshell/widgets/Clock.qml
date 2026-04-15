import QtQuick
import Quickshell
import qs.components

Widget {
	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}

	Menu {
		id: menu
		closedText: Qt.formatDateTime(clock.date, "hh:mm")

		Calendar {
			id: popup

			onDateCopied: {
				menu.opened = false
			}	
		}
	}
}
