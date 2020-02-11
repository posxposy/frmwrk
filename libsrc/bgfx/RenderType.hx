package bgfx;

@:unreflective
@:include('bgfx/bgfx.h')
extern enum abstract RendererType(RendererTypeEnum) {
	@:native('bgfx::RendererType::Noop')
	var Noop;
	@:native('bgfx::RendererType::Direct3D9')
	var Direct3D9;
	@:native('bgfx::RendererType::Direct3D11')
	var Direct3D11;
	@:native('bgfx::RendererType::Direct3D12')
	var Direct3D12;
	@:native('bgfx::RendererType::Gnm')
	var Gnm;
	@:native('bgfx::RendererType::Metal')
	var Metal;
	@:native('bgfx::RendererType::Nvn')
	var Nvn;
	@:native('bgfx::RendererType::OpenGLES')
	var OpenGLES;
	@:native('bgfx::RendererType::OpenGL')
	var OpenGL;
	@:native('bgfx::RendererType::Vulkan')
	var Vulkan;
}

@:unreflective
@:native("bgfx::RendererType::Enum")
private extern class RendererTypeEnum {
}
