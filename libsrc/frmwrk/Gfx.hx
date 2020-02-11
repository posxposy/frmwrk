package frmwrk;

import bgfx.UniformHandle;
import frmwrk.math.Glm;
import frmwrk.math.Mat4;

@:headerCode('
	#include <bgfx/bgfx.h>
	#include <glm/glm.hpp>
	#include <glm/gtc/type_ptr.hpp>
')
@:allow(frmwrk.App)
final class Gfx {
	final viewId:Int;

	private function new(viewId:Int) {
		this.viewId = viewId;
	}

	/**
		Set view clear flags.
		@param color
	 */
	public function clearColor(color:Int):Void {
		untyped __cpp__('bgfx::setViewClear({0}, BGFX_CLEAR_COLOR | BGFX_CLEAR_DEPTH, {1}, 1.0f, 0)', viewId, color);
	}

	/**
		2D position from top-left.
		@param text
	 */
	public function debugTextPrint(column:Int, row:Int, text:String):Void {
		untyped __cpp__('bgfx::dbgTextPrintf({0}, {1}, 0x0f, {2}.c_str())', column, row, text);
	}

	public function setVertexBuffer(vb:VertexBuffer):Void {
		untyped __cpp__('bgfx::setVertexBuffer({0}, {1}->vbh)', viewId, vb);
	}

	public function setIndexBuffer(ib:IndexBuffer):Void {
		untyped __cpp__('bgfx::setIndexBuffer({0}->ibh)', ib);
	}

	public function submit(program:Program):Void {
		untyped __cpp__('bgfx::submit({0}, {1})', viewId, @:privateAccess program.program);
	}

	public function setViewTransform(view:Mat4, projection:Mat4):Void {
		untyped __cpp__('bgfx::setViewTransform({0}, {1}, {2})', viewId, Glm.valuePtr(view), Glm.valuePtr(projection));
	}

	public function setTransform(matrix:Mat4):Void {
		untyped __cpp__('bgfx::setTransform({0})', Glm.valuePtr(matrix));
	}

	public function setTexture(uniform:UniformHandle, texture:Texture2D):Void {
		untyped __cpp__('bgfx::setTexture(0, {0},  {1}->handle)', uniform, texture);
	}

	//? what is it for?
	public function setState():Void {
		untyped __cpp__('
		bgfx::setState(0
				| BGFX_STATE_WRITE_RGB
				| BGFX_STATE_WRITE_A
				| BGFX_STATE_WRITE_Z
				| BGFX_STATE_DEPTH_TEST_LESS
				)
		');
	}
}
