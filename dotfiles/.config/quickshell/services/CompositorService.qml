pragma Singleton
import Quickshell
import QtQuick
import qs.config

Item {
	property int activeWorkspaceId: -1
	property int activeWindowId: -1
	property list<int> activeWindows_: []
	property var workspacesList: ListModel {
		function fromArray(arr: var) { return toListModel(workspacesList, arr); }
		function findById(id: int) : int { return findInListModel(workspacesList, ws => ws.id === id ); }	
	}
	property var windowsList: ListModel {
		function fromArray(arr: var) { return toListModel(windowsList, arr); }
		function findById(id: int) : int { return findInListModel(windowsList, w => w.id === id ); }	

		function insertSorted(window: var) { 
			windowsList.insert(findInListModel(windowsList, w => (windowsSortingFn(window, w) <= 0)), window);
		}
		
		function removeById(id: int) { 
			let idx = findInListModel(windowsList, w => w.id === id ); 
			if(idx !== windowsList.count) {
				windowsList.remove(idx);
			}
			return undefined;
		}	

	}

	signal workspaceActivated(int id)

	function toListModel(model, arr) {
		model.clear();
		for(let obj of arr) {
			model.append(obj);
		}
	}

	function findInListModel(model, fn) {
		for(let i = 0; i < model.count; ++i) {
			if(fn(model.get(i))) {
				return i;
			}
		}
		return model.count;
	}

	function windowsSortingFn(w1, w2) {
		if(w1.col === w2.col) {
			return w1.row - w2.row;
		}
		return w1.col - w2.col;
	}

	Loader {
		source: Quickshell.shellDir + "/services/compositor/" + Config.compositor + "/IpcListener.qml"

		onLoaded: {
			item.receivedWorkspaces.connect(ws => {
				workspacesList.fromArray(ws);
				activeWindows_ = new Array(ws.length).fill(-1);
			});
			
			item.workspaceActivated.connect(id => {
				activeWorkspaceId = id;
				let idx = workspacesList.findById(id);
				activeWindowId = activeWindows_[idx];
				workspaceActivated(id);
			});

			item.receivedWindows.connect(windowsList.fromArray);
			
			item.receivedWindow.connect(window => {
				windowsList.removeById(window.id);
				windowsList.insertSorted(window);
			});

			item.windowsPosUpdated.connect((changes) => {
				for(let change of changes) {
					let idx = windowsList.findById(change.window);
					if(!idx === windowsList.count) return;
					let window = JSON.parse(JSON.stringify(windowsList.get(idx)));
					windowsList.remove(idx);
					window.col = change.col;
					window.row = change.row;
					windowsList.insertSorted(window);
				}
			});

			item.windowClosed.connect(windowsList.removeById);	

			item.windowActivated.connect((wsId, windowId) => {
				let wsIdx = workspacesList.findById(wsId);
				activeWindows_[wsIdx] = windowId;
				if(wsId === activeWorkspaceId) {
					activeWindowId = windowId;
				}
			});
		}
	}

	Loader {
		id: requesterImpl
		source: Quickshell.shellDir + "/services/compositor/" + Config.compositor + "/IpcRequester.qml"
	}

	function switchWorkspace(id: int) {
		requesterImpl.item.switchWorkspace(id);
	}
}
