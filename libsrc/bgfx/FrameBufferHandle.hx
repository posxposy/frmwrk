package bgfx;

import cpp.Reference;

@:unreflective
@:native('bgfx::FrameBufferHandle')
@:include('bgfx/bgfx.h')
@:structAccess
extern class FrameBufferHandle {
	public static inline function invalid():FrameBufferHandle {
		return untyped __cpp__('BGFX_INVALID_HANDLE');
	}

	public static inline function create(ratio:BackbufferRatio):FrameBufferHandle {
		return untyped __cpp__('bgfx::createFrameBuffer({0}, bgfx::TextureFormat::RGBA32F)', ratio);
	}

	public static inline function createFixedSize(width:Int, height:Int):FrameBufferHandle {
		return untyped __cpp__('bgfx::createFrameBuffer({0}, {1}, bgfx::TextureFormat::RGBA32F)', width, height);
	}

	public inline function getTextureHandle(index:Int = 0):TextureHandle {
		return untyped __cpp__('bgfx::getTexture({0}, {1})', this, index);
	}
}
