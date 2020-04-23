package frmwrk;

import cpp.UInt64_t;

@:notNull
@:unreflective
@:include('bgfx/defines.h')
extern enum abstract ClearFlags(UInt64_t) to UInt64_t from UInt64_t {
	@:native('BGFX_CLEAR_NONE')
	var None;
	@:native('BGFX_CLEAR_COLOR')
	var Color;
	@:native('BGFX_CLEAR_DEPTH')
	var Depth;
	@:native('BGFX_CLEAR_STENCIL')
	var Stencil;

	@:op(A | B)
	public inline function bitwiseOr(v:ClearFlags):ClearFlags {
		return untyped __cpp__('{0} | {1}', this, v);
	}
}
