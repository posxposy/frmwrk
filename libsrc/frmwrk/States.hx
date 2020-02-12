package frmwrk;

import cpp.UInt64;

/**
	Color RGB/alpha/depth write. When it's not specified write will be disabled.
 */
@:unreflective
@:include('bgfx/defines.h')
extern enum abstract WriteState(UInt64) to UInt64 {
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
		Write all channels mask.
	 */
	@:native('BGFX_STATE_WRITE_MASK')
	var WriteAll;
}

/**
	When it's not specified depth test will be disabled.
 */
@:unreflective
@:include('bgfx/defines.h')
extern enum abstract DepthState(UInt64) to UInt64 {
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
}

/**
	When it's not specified culling will be disabled.
 */
@:unreflective
@:include('bgfx/defines.h')
extern enum abstract CullState(UInt64) to UInt64 {
	@:native('BGFX_STATE_CULL_CW')
	var Clockwise;
	@:native('BGFX_STATE_CULL_CCW')
	var CounterClockwise;
}

/**
	When it's not specified Triangle List will be enabled.
 */
@:unreflective
@:include('bgfx/defines.h')
extern enum abstract RenderState(UInt64) to UInt64 {
	@:native('BGFX_STATE_PT_TRISTRIP')
	var TriangleStrip;
	@:native('BGFX_STATE_PT_LINES')
	var Lines;
	@:native('BGFX_STATE_PT_LINESTRIP')
	var LinesStrip;
	@:native('BGFX_STATE_PT_POINTS')
	var Points;
}
