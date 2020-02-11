package frmwrk;

import haxe.ds.StringMap;
import sys.io.File;

final class Res {
	private static var tex2dCache:StringMap<Texture2D>;

	public static function loadTexture2D(file:String):Texture2D {
		if (tex2dCache == null) {
			tex2dCache = new StringMap();
		}
		if (tex2dCache.exists(file)) {
			return tex2dCache.get(file);
		}

		final t = new Texture2D(File.getBytes(file));
		tex2dCache.set(file, t);
		return t;
	}
}
