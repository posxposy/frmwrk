package frmwrk;

import haxe.ds.StringMap;
import haxe.io.Bytes;
import sys.io.File;

final class Res {
	public static var DEFAULT_TEX_FLAGS:TextureFlags = TextureNone | SamplerNone;
	static var tex2dCache:StringMap<Texture2D>;
	static var textsCache:StringMap<String>;

	public static function loadTexture2D(file:String, flags:TextureFlags):Texture2D {
		if (tex2dCache == null) {
			tex2dCache = new StringMap();
		}
		if (tex2dCache.exists(file)) {
			return tex2dCache.get(file);
		}

		final t = new Texture2D(file, File.getBytes(file), flags);
		tex2dCache.set(file, t);
		return t;
	}

	public static function loadTextFile(file:String):String {
		if (textsCache == null) {
			textsCache = new StringMap();
		}
		if (textsCache.exists(file)) {
			return textsCache.get(file);
		}

		final f = File.getContent(file);
		textsCache.set(file, f);
		return f;
	}

	public static function loadShaderBytes(file:String):Bytes {
		return File.getBytes(file);
	}
}
