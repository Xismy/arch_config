pragma Singleton
import QtQuick

QtObject {
	property string compositor: "niri"
	property list<string> launcherCommands: [
		"fuzzel", "--anchor", "top-left", "--y-margin", "20"
	]
	property var powerCommands: {
		"poweroff": ["poweroff"],
		"reboot": ["reboot"],
		"lock": ["swaylock"],
		"logout": ["niri", "msg", "action", "quit", "--skip-confirmation"]
	}
	property var windowsIcons: {
		"kitty": "",
		"librewolf": "",
		"steam": "",
		"thunar": ""
	}
	property list<string> services: [
		"transmission-daemon",
		"mpd",
		"webvplayer"
	]
}
