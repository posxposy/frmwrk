package frmwrk;

import bgfx.TextureHandle;
import bimg.ImageContainer;
import cpp.Star;
import haxe.io.Bytes;

@:headerCode('
	#include <bgfx/bgfx.h>
	#include <bx/bx.h>
	#include <bx/allocator.h>
	#include <bimg/decode.h>
')
@:headerClassCode('
	bimg::ImageContainer *container = nullptr;
	bgfx::TextureHandle handle;
')
@:cppNamespaceCode('
	void imageReleaseCb(void* _ptr, void* _userData) {
		BX_UNUSED(_ptr);
		bimg::ImageContainer* imageContainer = (bimg::ImageContainer*)_userData;
		bimg::imageFree(imageContainer);
	}
')
class Texture2D {
	public final width:Int = 10;
	public final height:Int = 10;

	extern var handle:TextureHandle;
	extern var container:Star<ImageContainer>;

	var path:String;

	@:allow(frmwrk.Res)
	function new(path:String, data:Bytes, flags:TextureFlags) {
		this.path = path;

		untyped __cpp__('
			bx::DefaultAllocator allocator;
			{2} = bimg::imageParse(&allocator, (const void*)&({0}[0]), (uint32_t){1});

			const bgfx::Memory* mem = bgfx::makeRef({2}->m_data, {2}->m_size);

			{3} = bgfx::createTexture2D(
				{2}->m_width
			, {2}->m_height
			, 1 < {2}->m_numMips
			, {2}->m_numLayers
			, bgfx::TextureFormat::Enum({2}->m_format)
			, {4}
			, mem
			)
		', data.getData(), data.length, container, handle, flags);

		width = untyped __cpp__('{0}->m_width', container);
		height = untyped __cpp__('{0}->m_height', container);
	}

	public inline extern function getHandle():TextureHandle {
		return untyped __cpp__('{0}->handle', this);
	}

	public function dispose():Void {
		@:privateAccess Res.tex2dCache.remove(path);
		untyped __cpp__('bimg::imageFree({0})', container);
	}
}
