pragma Singleton

import QtQuick
import Quickshell.Io
import qs.config

Item {
	Process {
		id: bgChanger
		running: false
	}

	function setBackground(img) {
		bgChanger.command = Config.backgroundClearCommand;
		bgChanger.running = true;
		bgChanger.command = Config.backgroundChangeCommand.concat(Config.backgroundDir + img);
		bgChanger.running = true;
	}
}
