package frmwrk;

import bgfx.InstanceDataBuffer;
import bgfx.UniformHandle;
import cpp.Star;
import cpp.UInt64;
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
		untyped __cpp__('bgfx::submit({0}, {1}->program)', viewId, program);
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

	public function setFloat1Uniform(uniform:UniformHandle, x:Single = 0.0):Void {
		untyped __cpp__('bgfx::setUniform({0}, &{1}, 1)', uniform, x);
	}

	public function setFloat2Uniform(uniform:UniformHandle, x:Single = 0.0, y:Single = 0.0):Void {
		untyped __cpp__('
			float data[2] = { {1}, {2} };
			bgfx::setUniform({0}, &data, 2)
		', uniform, x, y);
	}

	public function setFloat3Uniform(uniform:UniformHandle, x:Single = 0.0, y:Single = 0.0, z:Single = 0.0):Void {
		untyped __cpp__('
			float data[3] = { {1}, {2}, {3} };
			bgfx::setUniform({0}, &data, 3)
		', uniform, x, y, z);
	}

	public function setFloat4Uniform(uniform:UniformHandle, x:Single = 0.0, y:Single = 0.0, z:Single = 0.0, w:Single = 0.0):Void {
		untyped __cpp__('
			float data[4] = { {1}, {2}, {3}, {4} };
			bgfx::setUniform({0}, &data, 4)
		', uniform, x, y, z, w);
	}

	public function setState(state:UInt64 = -1):Void {
		final mask = state == -1 ? untyped BGFX_STATE_DEFAULT : state;
		untyped __cpp__('bgfx::setState(0 | {0})', mask);
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
