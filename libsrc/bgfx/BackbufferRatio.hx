package bgfx;

@:unreflective
@:include('bgfx/bgfx.h')
extern enum abstract BackbufferRatio(BackbufferRatioImpl) {
	@:native('bgfx::BackbufferRatio::Equal')
	var Equal;
	@:native('bgfx::BackbufferRatio::Half')
	var Half;
	@:native('bgfx::BackbufferRatio::Quarter')
	var Quarter;
	@:native('bgfx::BackbufferRatio::Eighth')
	var Eighth;
	@:native('bgfx::BackbufferRatio::Sixteenth')
	var Sixteenth;
	@:native('bgfx::BackbufferRatio::Double')
	var Double;
}

@:unreflective
@:native("bgfx::BackbufferRatio::Enum")
@:include('bgfx/bgfx.h')
extern class BackbufferRatioImpl {
}
