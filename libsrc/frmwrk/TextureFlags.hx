package frmwrk;

import cpp.UInt64_t;

@:unreflective
@:include('bgfx/defines.h')
extern enum abstract TextureFlags(UInt64_t) to UInt64_t from UInt64_t {
	@:native('BGFX_TEXTURE_NONE')
	var TextureNone;

	/**
		Texture will be used for MSAA sampling.
	 */
	@:native('BGFX_TEXTURE_MSAA_SAMPLE')
	var TextureMsaaSampling;

	/**
		Render target no MSAA.
	 */
	@:native('BGFX_TEXTURE_RT')
	var TextureRenderTarget;

	/**
		Texture will be used for compute write.
	 */
	@:native('BGFX_TEXTURE_COMPUTE_WRITE')
	var TextureComputeWrite;

	/**
		Sample texture as sRGB.
	 */
	@:native('BGFX_TEXTURE_SRGB')
	var TextureSRGB;

	@:native('BGFX_TEXTURE_BLIT_DST')
	var TextureBlitDestination;
	@:native('BGFX_TEXTURE_READ_BACK')
	var TextureReadBack;
	@:native('BGFX_TEXTURE_RT_MSAA_X2')
	var TextureRenderTargetMsaa2;
	@:native('BGFX_TEXTURE_RT_MSAA_X4')
	var TextureRenderTargetMsaa4;
	@:native('BGFX_TEXTURE_RT_MSAA_X8')
	var TextureRenderTargetMsaa8;
	@:native('BGFX_TEXTURE_RT_MSAA_X16')
	var TextureRenderTargetMsaa16;

	/**
		Render target will be used for writing
	 */
	@:native('BGFX_TEXTURE_RT_WRITE_ONLY')
	var TextureRenderTargeWriteOnly;

	@:native('BGFX_SAMPLER_NONE')
	var SamplerNone;
	@:native('BGFX_SAMPLER_POINT')
	var SamplerPoint;
	@:native('BGFX_SAMPLER_U_MIRROR')
	var SamplerUMirror;
	@:native('BGFX_SAMPLER_U_CLAMP')
	var SamplerUClamp;
	@:native('BGFX_SAMPLER_U_BORDER')
	var SamplerUBorder;
	@:native('BGFX_SAMPLER_V_MIRROR')
	var SamplerVMirror;
	@:native('BGFX_SAMPLER_V_CLAMP')
	var SamplerVClamp;
	@:native('BGFX_SAMPLER_V_BORDER')
	var SamplerVBorder;
	@:native('BGFX_SAMPLER_W_MIRROR')
	var SamplerWMirror;
	@:native('BGFX_SAMPLER_W_CLAMP')
	var SamplerWClamp;
	@:native('BGFX_SAMPLER_W_BORDER')
	var SamplerWBorder;
	@:native('BGFX_SAMPLER_MIN_POINT')
	var SamplerMinPoint;
	@:native('BGFX_SAMPLER_MIN_ANISOTROPIC')
	var SamplerMinAnisotropic;
	@:native('BGFX_SAMPLER_MAG_POINT')
	var SamplerMagPoint;
	@:native('BGFX_SAMPLER_MAG_ANISOTROPIC')
	var SamplerMagAnisotropic;
	@:native('BGFX_SAMPLER_MIP_POINT')
	var SamplerMipPoint;

	@:op(A | B)
	public inline function bitwiseOr(v:TextureFlags):TextureFlags {
		return untyped __cpp__('{0} | {1}', this, v);
	}
}
