package frmwrk;

import bgfx.Memory;
import bgfx.ProgramHandle;
import bgfx.ShaderHandle;
import bgfx.UniformHandle;
import cpp.Reference;
import haxe.io.Bytes;

@:headerCode('
	#include <bgfx/bgfx.h>
')
@:headerClassCode('
	bgfx::ShaderHandle vsh;
	bgfx::ShaderHandle fsh;
	bgfx::ProgramHandle program;
')
@:headerInclude('./HelpersExt.h')
final class Program {
	extern var vsh:ShaderHandle;
	extern var fsh:ShaderHandle;
	extern var program:ProgramHandle;

	public function new(vertexSource:Bytes, fragmentSource:Bytes) {
		final vshMemory = Helpers.bytesToMemory(vertexSource);
		final fshMemory = Helpers.bytesToMemory(fragmentSource);

		vsh = createShader(vshMemory);
		fsh = createShader(fshMemory);
	}

	public function createUniform(name:String):UniformHandle {
		return untyped __cpp__('bgfx::createUniform({0}.c_str(),  bgfx::UniformType::Sampler);', name);
	}

	public function setUniform():Void {
	}

	public function compile():Void {
		program = untyped __cpp__('bgfx::createProgram({0}, {1}, true)', vsh, fsh);
	}

	extern inline function createShader(memory:Memory):ShaderHandle {
		return untyped __cpp__('bgfx::createShader({0})', memory);
	}
}
