import QtQuick
import Quickshell
import Quickshell.Io

Socket {
	property string state: ""
	property int ellapsed: 0
	property int updateTs: 0
	property int duration: 0
	property int songId: 0
	property string artist: ""
	property string title: ""
	property string album: ""

	id: socket

	path: Quickshell.env("XDG_RUNTIME_DIR") + "/mpd/socket"
	//path: "/tmp/test_socket"
	connected: true
	

	Component.onCompleted: {
		write("status\n");
	}
	
	parser: SplitParser {
		onRead: function(data) {socket.parseKeyVal(data)}

	}

	function parseKeyVal(line: string) {
		console.log(line);
		if(line.startsWith("OK")) {
			if(state === "") {
				console.log("Requesting status update");
				write("status\n");
			}
			else if(state !== "stop" && songId === 0) {
				console.log("Requesting current song info");
				write("currentsong\n");
			}
			else {
				console.log("Requesting idle");
				write("idle");
			}
			return;
		}

		if(line.startsWith("ACK")) {
			console.log("MPD Error:", line);
			return;
		}

		let [key, value] = line.split(": ");
		switch(key) {
			case "state":
				state = value;
				break;
			case "ellapsed":
				ellapsed = Math.floor(parseFloat(value) * 1000);
				updateTs = Date.now();
				break;
			case "duration":
				duration = Math.floor(parseFloat(value) * 1000);
				break;
			case "Id":
				if(parseInt(value) != songId) {
					songId = 0
				}
				break;
			case "Artist":
				artist = value;
				break;
			case "Title":
				title = value;
				break;
			case "Album":
				album = value;
				break;
			case "changed":
				state = "";
				break;	
			}
	}
}
