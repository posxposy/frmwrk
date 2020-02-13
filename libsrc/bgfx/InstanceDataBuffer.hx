package bgfx;

import cpp.RawPointer;
import cpp.Star;
import cpp.UInt8;

@:unreflective
@:native('bgfx::InstanceDataBuffer')
@:include('bgfx/bgfx.h')
@:structAccess
extern class InstanceDataBuffer {
	public static inline function init():InstanceDataBuffer {
		return untyped __cpp__('{ 0 }');
	}

	public inline function getData():InstanceDataBufferData {
		return untyped __cpp__('(float *){0}.data', this);
	}

	public inline function increase(value:Int):Void {
		untyped __cpp__('{0}.data += {1}', this, value);
	}
}

extern abstract InstanceDataBufferData(RawPointer<Single>) {
	public inline function set(index:Int, value:Single):Void {
		untyped __cpp__('{0}[{1}] = {2}', this, index, value);
	}
}
