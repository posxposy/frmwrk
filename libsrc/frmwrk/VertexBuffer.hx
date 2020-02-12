package frmwrk;

import bgfx.Attrib;
import bgfx.AttribType;
import bgfx.VertexBufferHandle;
import bgfx.VertexLayout;
import haxe.io.Bytes;
import haxe.io.BytesData;
import haxe.io.Float32Array;

extern enum abstract LayoutAttrib(Attrib) {
	@:native('bgfx::Attrib::Position')
	var Position;
	@:native('bgfx::Attrib::Color0')
	var Color0;
	@:native('bgfx::Attrib::TexCoord0')
	var TexCoord0;
}

extern enum abstract LayoutAttribType(AttribType) {
	@:native('bgfx::AttribType::Float')
	var Float;
	@:native('bgfx::AttribType::Uint8')
	var Uint8;
}

@:headerCode('
	#include <bgfx/bgfx.h>
')
@:headerClassCode('
	bgfx::VertexLayout layout;
	bgfx::VertexBufferHandle vbh;
')
final class VertexBuffer {
	final data:Bytes;
	extern var layout:VertexLayout;
	extern var vbh:VertexBufferHandle;

	public function new(data:Array<Float>) {
		final size = data.length * 4;
		this.data = Bytes.alloc(size);
		for (i in 0...data.length) {
			this.data.setFloat(i * 4, data[i]);
		}
	}

	public function begin():Void {
		untyped __cpp__('{0}.begin()', layout);
	}

	/**
		Must be called between begin/end.
		@param attrib Attribute semantics
		@param num Number of elements 1, 2, 3 or 4.
		@param type Element type
		@param normalized When using fixed point `LayoutAttribType` (f.e. `Uint8`) value will be normalized for vertex shader usage. When normalized is set to true, `LayoutAttribType.Uint8` value in range 0-255 will be in range 0.0-1.0 in vertex shader.
	 */
	public function add(attrib:LayoutAttrib, num:Int, type:LayoutAttribType, normalized:Bool = false):Void {
		untyped __cpp__('{0}.add({1}, {2}, {3}, {4})', layout, attrib, num, type, normalized);
	}

	public function end():Void {
		untyped __cpp__('
			{0}.end();
			{1} = bgfx::createVertexBuffer(bgfx::makeRef((const void*)&({2}[0]), {3}), {0});
		', layout, vbh, data.getData(), data.length);
	}

	public function dispose():Void {
		untyped __cpp__('
			bgfx::destroy({0});
			bgfx::destroy({1})
		', vbh, layout);
	}
}
