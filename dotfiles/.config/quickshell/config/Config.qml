pragma Singleton
import QtQuick
import Quickshell
import qs.services

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

	property string backgroundDir: Quickshell.shellDir + "/images/";

	property var backgroundClearCommand: [
		"awww", "clear", "000000"
	]

	property var backgroundChangeCommand: [
		"awww", "img", 
		"--transition-type", "fade", 
		"--transition-duration", "2",
		"--transition-bezier", ".5,.8,.5,.5",
	]
}
