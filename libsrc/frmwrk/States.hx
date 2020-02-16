package frmwrk;

import cpp.UInt64_t;

@:notNull
@:unreflective
@:include('bgfx/defines.h')
extern enum abstract States(UInt64_t) to UInt64_t from UInt64_t {
	/**
		Enable R write.
	 */
	@:native('BGFX_STATE_WRITE_R')
	var WriteR;

	/**
		Enable G write.
	 */
	@:native('BGFX_STATE_WRITE_G')
	var WriteG;

	/**
		Enable B write.
	 */
	@:native('BGFX_STATE_WRITE_B')
	var WriteB;

	/**
		Enable A write.
	 */
	@:native('BGFX_STATE_WRITE_A')
	var WriteA;

	/**
		Enable Z write.
	 */
	@:native('BGFX_STATE_WRITE_Z')
	var WriteZ;

	/**
		Enable RGB write.
	 */
	@:native('BGFX_STATE_WRITE_RGB')
	var WriteRGB;

	/**
		Write all channels mask.
	 */
	@:native('BGFX_STATE_WRITE_MASK')
	var WriteAll;

	@:native('BGFX_STATE_DEPTH_TEST_LESS')
	var DepthLess;
	@:native('BGFX_STATE_DEPTH_TEST_LEQUAL')
	var DepthLessOrEqual;
	@:native('BGFX_STATE_DEPTH_TEST_EQUAL')
	var DepthEqual;
	@:native('BGFX_STATE_DEPTH_TEST_GEQUAL')
	var DepthGreaterOrEqual;
	@:native('BGFX_STATE_DEPTH_TEST_GREATER')
	var DepthGreater;
	@:native('BGFX_STATE_DEPTH_TEST_NOTEQUAL')
	var DepthNotEqual;
	@:native('BGFX_STATE_DEPTH_TEST_ALWAYS')
	var DepthAlways;
	@:native('BGFX_STATE_CULL_CW')
	var Clockwise;
	@:native('BGFX_STATE_CULL_CCW')
	var CounterClockwise;
	@:native('BGFX_STATE_PT_TRISTRIP')
	var TriangleStrip;
	@:native('BGFX_STATE_PT_LINES')
	var Lines;
	@:native('BGFX_STATE_PT_LINESTRIP')
	var LinesStrip;
	@:native('BGFX_STATE_PT_POINTS')
	var Points;

	@:op(A | B)
	public inline function bitwiseOr(v:States):States {
		return untyped __cpp__('{0} | {1}', this, v);
	}
}
