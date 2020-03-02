package frmwrk.input;

import haxe.ds.IntMap;

@:allow(frmwrk)
final class KeyBoard {
	final keys:IntMap<Bool>;

	public function isKeyDown(key:KeyCode):Bool {
		if (keys.exists(key)) {
			return keys.get(key);
		}
		return false;
	}

	function new() {
		keys = new IntMap();
	}

	function onKeyDown(key:KeyCode):Void {
		keys.set(key, true);
	}

	function onKeyUp(key:KeyCode):Void {
		keys.set(key, false);
	}
}
