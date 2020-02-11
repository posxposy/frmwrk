package bgfx;

@:unreflective
@:include('bgfx/bgfx.h')
extern enum abstract UniformType(UniformTypeEnum) {
	@:native('bgfx::UniformType::Sampler')
	var Sampler;
	@:native('bgfx::UniformType::Vec4')
	var Vec4;
	@:native('bgfx::UniformType::Mat3')
	var Mat3;
	@:native('bgfx::UniformType::Mat4')
	var Mat4;
}

@:unreflective
@:native("bgfx::UniformType::Enum")
private extern class UniformTypeEnum {
}
