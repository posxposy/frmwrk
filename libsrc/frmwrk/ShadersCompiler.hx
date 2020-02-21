package frmwrk;

import haxe.ds.StringMap;
import haxe.io.Path;
import haxe.macro.Compiler;
import haxe.macro.Context;
import sys.FileSystem;
import sys.io.Process;

final class ShadersCompiler {
	public static function run(input:String = "shaders", output:String = "assets"):Void {
		#if autocompl
		return;
		#end
		final shaders = FileSystem.readDirectory('./$input');
		final groups:StringMap<Group> = new StringMap();
		final cwd:String = Path.normalize(Sys.getCwd());

		inline function addItemToGroup(g:Group, ext:String, path:String) {
			switch ext {
				case "def": g.def = path;
				case "frag": g.frag = path;
				case "vert": g.vert = path;
			}
		}

		while (shaders.length > 0) {
			final s = shaders.pop();
			final name = Path.withoutExtension(s);
			final ext = Path.extension(s);

			if (groups.exists(name)) {
				final g:Group = groups.get(name);
				addItemToGroup(g, ext, s);
			}
			else {
				final g:Group = {};
				addItemToGroup(g, ext, s);
				groups.set(name, g);
			}
		}

		inline function constructArgs(p:String -> Int, isFrag:Bool, source:String, def:String, name:String, shaderType:ShaderType):Void {
			p('-f');
			p('$cwd/$input/${source}');

			p('-o');
			final outExt = isFrag ? 'frag' : 'vert';
			final outPath = shaderType == Glsl ? 'glsl' : 'hlsl';
			p('$cwd/$output/$outPath/${name}.${outExt}');

			p('--varyingdef');
			p('$cwd/$input/$def');

			p('--type');
			p(isFrag ? 'f' : 'v');

			if (shaderType == Hlsl) {
				p('-p');
				p(isFrag ? 'ps_5_0' : 'vs_5_0');
				p('-O');
				p('3');
			}

			p('--platform');
			p('windows');

			final includesStr = Context.definedValue('SHADERS_INCLUDES');
			if (includesStr != null) {
				final includes = includesStr.split(";");
				for (path in includes) {
					p('-i');
					p(path);
				}
			}

			//includ bgfx default shaders
			final cp = Context.getClassPath();
			for (s in cp) {
				if (s.indexOf('frmwrk') > -1) {
					final libPath = Path.normalize(s.substr(0, s.lastIndexOf('libsrc')));
					p('-i');
					p('$libPath/bgfx/src');
					p('-i');
					p('$libPath/bgfx/examples/common');
				}
			}
		}

		inline function exec(args:Array<String>, name:String):Void {
			//Context.info('\nCompile shader: $name > ' + args.join(" "), Context.currentPos());
			if (Sys.command('./tools/shadercRelease.exe', args) != 0) {
				Context.fatalError('Probems with $name shader', Context.currentPos());
			}
		}

		for (i in 0...2) {
			for (name => group in groups) {
				final t = i == 0 ? Glsl : Hlsl;
				var args:Array<String> = [];
				//frag
				constructArgs(args.push, true, group.frag, group.def, name, t);
				exec(args, name);

				args = [];
				//vert
				constructArgs(args.push, false, group.vert, group.def, name, t);
				exec(args, name);
			}
		}
	}
}

private typedef Group = {
	?def:String,
	?frag:String,
	?vert:String
}

private enum ShaderType {
	Hlsl;
	Glsl;
}
