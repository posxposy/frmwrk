package bgfx;

@:unreflective
@:include('bgfx/bgfx.h')
extern enum abstract TextureFormat(TextureFormatEnum) {
	@:native('bgfx::TextureFormat::BC1')
	var BC1;
	@:native('bgfx::TextureFormat::BC2')
	var BC2;
	@:native('bgfx::TextureFormat::BC3')
	var BC3;
	@:native('bgfx::TextureFormat::BC4')
	var BC4;
	@:native('bgfx::TextureFormat::BC5')
	var BC5;
	@:native('bgfx::TextureFormat::BC6H')
	var BC6H;
	@:native('bgfx::TextureFormat::BC7')
	var BC7;
	@:native('bgfx::TextureFormat::ETC1')
	var ETC1;
	@:native('bgfx::TextureFormat::ETC2')
	var ETC2;
	@:native('bgfx::TextureFormat::ETC2A')
	var ETC2A;
	@:native('bgfx::TextureFormat::ETC2A1')
	var ETC2A1;
	@:native('bgfx::TextureFormat::PTC12')
	var PTC12;
	@:native('bgfx::TextureFormat::PTC14')
	var PTC14;
	@:native('bgfx::TextureFormat::PTC12A')
	var PTC12A;
	@:native('bgfx::TextureFormat::PTC14A')
	var PTC14A;
	@:native('bgfx::TextureFormat::PTC22')
	var PTC22;
	@:native('bgfx::TextureFormat::PTC24')
	var PTC24;
	@:native('bgfx::TextureFormat::ATC')
	var ATC;
	@:native('bgfx::TextureFormat::ATCE')
	var ATCE;
	@:native('bgfx::TextureFormat::ATCI')
	var ATCI;
	@:native('bgfx::TextureFormat::ASTC4x4')
	var ASTC4x4;
	@:native('bgfx::TextureFormat::ASTC5x5')
	var ASTC5x5;
	@:native('bgfx::TextureFormat::ASTC6x6')
	var ASTC6x6;
	@:native('bgfx::TextureFormat::ASTC8x5')
	var ASTC8x5;
	@:native('bgfx::TextureFormat::ASTC8x6')
	var ASTC8x6;
	@:native('bgfx::TextureFormat::ASTC10x5')
	var ASTC10x5;
	@:native('bgfx::TextureFormat::Unknown')
	var Unknown;
	@:native('bgfx::TextureFormat::R1')
	var R1;
	@:native('bgfx::TextureFormat::A8')
	var A8;
	@:native('bgfx::TextureFormat::R8')
	var R8;
	@:native('bgfx::TextureFormat::R8I')
	var R8I;
	@:native('bgfx::TextureFormat::R8U')
	var R8U;
	@:native('bgfx::TextureFormat::R8S')
	var R8S;
	@:native('bgfx::TextureFormat::R16')
	var R16;
	@:native('bgfx::TextureFormat::R16I')
	var R16I;
	@:native('bgfx::TextureFormat::R16U')
	var R16U;
	@:native('bgfx::TextureFormat::R16F')
	var R16F;
	@:native('bgfx::TextureFormat::R16S')
	var R16S;
	@:native('bgfx::TextureFormat::R32I')
	var R32I;
	@:native('bgfx::TextureFormat::R32U')
	var R32U;
	@:native('bgfx::TextureFormat::R32F')
	var R32F;
	@:native('bgfx::TextureFormat::RG8')
	var RG8;
	@:native('bgfx::TextureFormat::RG8I')
	var RG8I;
	@:native('bgfx::TextureFormat::RG8U')
	var RG8U;
	@:native('bgfx::TextureFormat::RG8S')
	var RG8S;
	@:native('bgfx::TextureFormat::RG16')
	var RG16;
	@:native('bgfx::TextureFormat::RG16I')
	var RG16I;
	@:native('bgfx::TextureFormat::RG16U')
	var RG16U;
	@:native('bgfx::TextureFormat::RG16F')
	var RG16F;
	@:native('bgfx::TextureFormat::RG16S')
	var RG16S;
	@:native('bgfx::TextureFormat::RG32I')
	var RG32I;
	@:native('bgfx::TextureFormat::RG32U')
	var RG32U;
	@:native('bgfx::TextureFormat::RG32F')
	var RG32F;
	@:native('bgfx::TextureFormat::RGB8')
	var RGB8;
	@:native('bgfx::TextureFormat::RGB8I')
	var RGB8I;
	@:native('bgfx::TextureFormat::RGB8U')
	var RGB8U;
	@:native('bgfx::TextureFormat::RGB8S')
	var RGB8S;
	@:native('bgfx::TextureFormat::RGB9E5F')
	var RGB9E5F;
	@:native('bgfx::TextureFormat::BGRA8')
	var BGRA8;
	@:native('bgfx::TextureFormat::RGBA8')
	var RGBA8;
	@:native('bgfx::TextureFormat::RGBA8I')
	var RGBA8I;
	@:native('bgfx::TextureFormat::RGBA8U')
	var RGBA8U;
	@:native('bgfx::TextureFormat::RGBA8S')
	var RGBA8S;
	@:native('bgfx::TextureFormat::RGBA16')
	var RGBA16;
	@:native('bgfx::TextureFormat::RGBA16I')
	var RGBA16I;
	@:native('bgfx::TextureFormat::RGBA16U')
	var RGBA16U;
	@:native('bgfx::TextureFormat::RGBA16F')
	var RGBA16F;
	@:native('bgfx::TextureFormat::RGBA16S')
	var RGBA16S;
	@:native('bgfx::TextureFormat::RGBA32I')
	var RGBA32I;
	@:native('bgfx::TextureFormat::RGBA32U')
	var RGBA32U;
	@:native('bgfx::TextureFormat::RGBA32F')
	var RGBA32F;
	@:native('bgfx::TextureFormat::R5G6B5')
	var R5G6B5;
	@:native('bgfx::TextureFormat::RGBA4')
	var RGBA4;
	@:native('bgfx::TextureFormat::RGB5A1')
	var RGB5A1;
	@:native('bgfx::TextureFormat::RGB10A2')
	var RGB10A2;
	@:native('bgfx::TextureFormat::RG11B10F')
	var RG11B10F;
	@:native('bgfx::TextureFormat::UnknownDepth')
	var UnknownDepth;
	@:native('bgfx::TextureFormat::D16')
	var D16;
	@:native('bgfx::TextureFormat::D24')
	var D24;
	@:native('bgfx::TextureFormat::D24S8')
	var D24S8;
	@:native('bgfx::TextureFormat::D32')
	var D32;
	@:native('bgfx::TextureFormat::D16F')
	var D16F;
	@:native('bgfx::TextureFormat::D24F')
	var D24F;
	@:native('bgfx::TextureFormat::D32F')
	var D32F;
	@:native('bgfx::TextureFormat::D0S8')
	var D0S8;
}

@:unreflective
@:native("bgfx::TextureFormat::Enum")
private extern class TextureFormatEnum {
}
