import QtQuick
import Quickshell
import Quickshell.Io
import qs.services

Socket {
	id: socket
	signal receivedWorkspaces(list<var> workspaces)
	signal workspaceActivated(int id)
	signal receivedWindows(list<var> windows)
	signal receivedWindow(var window)
	signal windowActivated(int ws, int window)
	signal windowFocused(int id)
	signal windowsPosUpdated(list<var> changes)
	signal windowClosed(int id)
	
	path: Quickshell.env("NIRI_SOCKET")
	connected: true
	
	Component.onCompleted: {
		write("\"EventStream\"\n")
	}
	
	onError: {
		console.log("Socket error:", error)
	}
	
	parser: SplitParser {
		onRead: function(data: string){
			//console.log(data);
			let message = JSON.parse(data);
			if(message.WorkspaceActivated) {
				let id = message.WorkspaceActivated.id;
				workspaceActivated(id);
			}
			else if(message.WorkspacesChanged) {
				let activeWss = [];
				let activeWindows = [];

				let ws = message.WorkspacesChanged.workspaces.map(ws => {
					if(ws.is_active) {
						activeWss.push(ws.id);
					}

					activeWindows.push({id: ws.active_window_id ?? -1, ws: ws.id})

					return { 
						id: ws.id,
						idx: ws.idx - 1,
						name: ws.name ?? "",
					};
				});
				ws.sort((a,b) => a.idx - b.idx);
				receivedWorkspaces(ws);

				for(let activeWs of activeWss) {
					workspaceActivated(activeWs);
				}

				for(let activeWindow of activeWindows) {
					windowActivated(activeWindow.ws, activeWindow.id);
				}
			}
			else if(message.WindowFocusChanged) {
				windowFocused(message.WindowFocusChanged.id);
			}
			else if(message.WorkspaceActiveWindowChanged) {
				let change = message.WorkspaceActiveWindowChanged;
				windowActivated(change.workspace_id, change.active_window_id);
			}
			else if(message.WindowsChanged) {
				let windows = message.WindowsChanged.windows.map(parseWindow);
				windows.sort(CompositorService.windowsSortingFn);
				receivedWindows(windows);
			}
			else if(message.WindowOpenedOrChanged) {
				let window = parseWindow(message.WindowOpenedOrChanged.window);
				receivedWindow(window);
			}
			else if(message.WindowLayoutsChanged) {
				let changes = message.WindowLayoutsChanged.changes.map(changes => {
					return {
						window: changes[0],
						col: changes[1].pos_in_scrolling_layout[0],
						row: changes[1].pos_in_scrolling_layout[1]
					}
				});
				windowsPosUpdated(changes);
			}
			else if(message.WindowClosed) {
				windowClosed(message.WindowClosed.id);
			}
		}
	}

	function parseWindow(window) {
		if(window.is_focused) { 
			windowFocused(window.id)
		}

		return {
			id: window.id,
			ws: window.workspace_id,
			appId: window.app_id,
			title: window.title,
			isFloating: window.is_floating,
			col: window.layout.pos_in_scrolling_layout[0],
			row: window.layout.pos_in_scrolling_layout[1]
		};
	}
}
