package frmwrk;

@:using(frmwrk.Color.ColorUtils)
enum abstract Color(Int) from Int to Int {
	var White = 0xffffffff;
	var Black = 0x000000ff;
	var Red = 0xff0000ff;
	var Green = 0x00ff00ff;
	var Blue = 0x0000ffff;
	var Orange = 0xffa500ff;
	var Transparent = 0x00000000;
}

class ColorUtils {
	static inline var invMaxChannelValue:Float = 1 / 255;

	public static inline function red(color:Color):Float {
		return (color >>> 24) * invMaxChannelValue;
	}

	public static inline function green(color:Color):Float {
		return ((color & 0x00ff0000) >>> 16) * invMaxChannelValue;
	}

	public static inline function blue(color:Color):Float {
		return ((color & 0x0000ff00) >>> 8) * invMaxChannelValue;
	}

	public static inline function alpha(color:Color):Float {
		return (color & 0x000000ff) * invMaxChannelValue;
	}
}
