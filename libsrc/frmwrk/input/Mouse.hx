package frmwrk.input;

@:allow(frmwrk)
final class Mouse {
	public var x(default, null):Int;
	public var y(default, null):Int;
	public var scroll(default, null):Int;
	public var isLeftButtonDown(default, null):Bool;
	public var isRightButtonDown(default, null):Bool;

	function new() {
		this.x = this.y = this.scroll = 0;
		this.isLeftButtonDown = this.isRightButtonDown = false;
	}

	function onMouseDown(button:Int):Void {
		switch button {
			case 0: isLeftButtonDown = true;
			case 1: isRightButtonDown = true;
		}
	}

	function onMouseUp(button:Int):Void {
		switch button {
			case 0: isLeftButtonDown = false;
			case 1: isRightButtonDown = false;
		}
	}

	function onMouseMove(x:Int, y:Int):Void {
		this.x = x;
		this.y = y;
	}

	function onMouseScroll(delta:Int):Void {
		scroll += delta;
	}
}
