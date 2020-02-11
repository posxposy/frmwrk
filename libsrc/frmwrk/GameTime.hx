package frmwrk;

@:allow(frmwrk.App)
final class GameTime {
	public var fps(default, null):Int = 0;
	public var stamp(get, null):Float;
	public var elapsedTime(default, null):Float = 0.0;
	public var deltaTime(default, null):Float = 0.0;

	var totalFrames:Int = 0;
	var previousTime:Float = 0.0;
	var currentTime:Float = 0.0;

	function begin():Void {
		currentTime = haxe.Timer.stamp();
		deltaTime = (currentTime - previousTime);

		elapsedTime += deltaTime;
		if (elapsedTime >= 1.0) {
			fps = totalFrames;
			totalFrames = 0;
			elapsedTime = 0;
		}
		totalFrames++;
	}

	function end():Void {
		previousTime = currentTime;
	}

	function new() {
	}

	inline function get_stamp():Float {
		return haxe.Timer.stamp();
	}
}
