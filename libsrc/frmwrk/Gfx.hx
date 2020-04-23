package frmwrk;

import bgfx.BackbufferRatio;
import bgfx.FrameBufferHandle;
import bgfx.InstanceDataBuffer;
import bgfx.TextureHandle;
import bgfx.UniformHandle;
import cpp.Reference;
import cpp.Star;
import frmwrk.ClearFlags;
import frmwrk.States;
import frmwrk.math.Glm;
import frmwrk.math.Mat4;

@:headerCode('
	#include <bgfx/defines.h>
	#include <bgfx/bgfx.h>
	#include <glm/glm.hpp>
	#include <glm/gtc/type_ptr.hpp>
')
@:allow(frmwrk.Frmwrk)
final class Gfx {
	public var drawCalls(default, null):Int = 0;

	function new() {
	}

	public function frame():Void {
		untyped __cpp__('bgfx::frame()');
		drawCalls = 0;
	}

	public function touch(viewId:Int = 0):Void {
		untyped __cpp__('bgfx::touch({0})', viewId);
	}

	public function setViewRect(x:Int, y:Int, w:Int, h:Int, viewId:Int = 0):Void {
		untyped __cpp__('bgfx::setViewRect({0}, {1}, {2}, {3}, {4})', viewId, x, y, w, h);
	}

	public function setViewRectWithRatio(x:Int, y:Int, ratio:BackbufferRatio, viewId:Int = 0):Void {
		untyped __cpp__('bgfx::setViewRect({0}, {1}, {2}, {3})', viewId, x, y, ratio);
	}

	/**
		Set view clear flags.
		@param color
	 */
	public function clearColor(color:Int, flags:ClearFlags, viewId:Int = 0):Void {
		untyped __cpp__('bgfx::setViewClear({0}, {1}, {2}, 1.0f, 0)', viewId, flags, color);
	}

	/**
		2D position from top-left.
		@param text
	 */
	public function debugTextPrint(column:Int, row:Int, text:String):Void {
		untyped __cpp__('bgfx::dbgTextPrintf({0}, {1}, 0x0f, {2}.c_str())', column, row, text);
	}

	public function debugTextClear():Void {
		untyped __cpp__('bgfx::dbgTextClear()');
	}

	public function setViewFrameBuffer(handle:Reference<FrameBufferHandle>, viewId:Int):Void {
		untyped __cpp__('bgfx::setViewFrameBuffer({0}, {1})', viewId, handle);
	}

	public function setVertexBuffer(vb:VertexBuffer, viewId:Int = 0):Void {
		untyped __cpp__('bgfx::setVertexBuffer(0, {1}->vbh)', viewId, vb);
	}

	public function setIndexBuffer(ib:IndexBuffer):Void {
		untyped __cpp__('bgfx::setIndexBuffer({0}->ibh)', ib);
	}

	public function submit(program:Program, viewId:Int = 0):Void {
		untyped __cpp__('bgfx::submit({0}, {1}->program)', viewId, program);
		drawCalls++;
	}

	public function setViewTransform(view:Mat4, projection:Mat4, viewId:Int = 0):Void {
		untyped __cpp__('bgfx::setViewTransform({0}, {1}, {2})', viewId, Glm.valuePtr(view), Glm.valuePtr(projection));
	}

	public function setTransform(matrix:Mat4):Void {
		untyped __cpp__('bgfx::setTransform({0})', Glm.valuePtr(matrix));
	}

	public function setTexture(uniform:Reference<UniformHandle>, texture:Texture2D, stage:Int = 0):Void {
		inline setTextureHandle(uniform, @:privateAccess texture.handle, stage);
	}

	public function setTextureHandle(uniform:Reference<UniformHandle>, handle:Reference<TextureHandle>, stage:Int = 0):Void {
		untyped __cpp__('bgfx::setTexture({2}, {0}, {1})', uniform, handle, stage);
	}

	public function setFloat1Uniform(uniform:Reference<UniformHandle>, x:Single = 0.0):Void {
		untyped __cpp__('bgfx::setUniform({0}, &{1}, UINT16_MAX)', uniform, x);
	}

	public function setFloat2Uniform(uniform:Reference<UniformHandle>, x:Single = 0.0, y:Single = 0.0):Void {
		untyped __cpp__('
			float data[2] = { {1}, {2} };
			bgfx::setUniform({0}, &data, UINT16_MAX)
		', uniform, x, y);
	}

	public function setFloat3Uniform(uniform:Reference<UniformHandle>, x:Single = 0.0, y:Single = 0.0, z:Single = 0.0):Void {
		untyped __cpp__('
			float data[3] = { {1}, {2}, {3} };
			bgfx::setUniform({0}, &data, UINT16_MAX)
		', uniform, x, y, z);
	}

	public function setFloat4Uniform(uniform:Reference<UniformHandle>, x:Single = 0.0, y:Single = 0.0, z:Single = 0.0, w:Single = 0.0):Void {
		untyped __cpp__('
			float data[4] = { {1}, {2}, {3}, {4} };
			bgfx::setUniform({0}, &data, UINT16_MAX)
		', uniform, x, y, z, w);
	}

	public function setMat4Uniform(uniform:Reference<UniformHandle>, matrix:Mat4):Void {
		untyped __cpp__('
			bgfx::setUniform({0}, {1})
		', uniform, Glm.valuePtr(matrix));
	}

	public function setState(state:States):Void {
		untyped __cpp__('bgfx::setState({0})', state);
	}

	public function isInstancingSupported():Bool {
		return untyped __cpp__('0 != (BGFX_CAPS_INSTANCING & bgfx::getCaps()->supported)');
	}

	public function getAvailInstanceDataBuffer(count:Int, stride:Int):Int {
		return untyped __cpp__('bgfx::getAvailInstanceDataBuffer({0}, {1})', count, stride);
	}

	public function allocInstanceDataBuffer(idb:Star<InstanceDataBuffer>, count:Int, stride:Int):Void {
		untyped __cpp__('bgfx::allocInstanceDataBuffer({0}, {1}, {2})', idb, count, stride);
	}

	public function setInstanceDataBuffer(idb:Star<InstanceDataBuffer>, start:Int, count:Int) {
		untyped __cpp__('bgfx::setInstanceDataBuffer({0})', idb, start, count);
	}
}
