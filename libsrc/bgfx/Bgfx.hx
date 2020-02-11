package bgfx;

@:include('bgfx/bgfx.h')
@:unreflective
extern class Bgfx {
	public static inline function init():Bool {
		return untyped __cpp__('
			bgfx::init(init)
		');
	}
}

/*

	typedef InitOptions = {
	type = bgfx.RendererType.OpenGL, vendorId = (ushort)
	bgfx.PciIdFlags.None.GetHashCode
	(), platformData = new bgfx.PlatformData
	{
		nwh = window.Hwnd.ToPointer() //Native.GetWin32Window(window).ToPointer()
	},
	resolution = {
		width = (uint) w, height = (uint) h, reset = (uint) bgfx.ResetFlags.Vsync.GetHashCode()
	},
	limits = new bgfx.Init.Limits()
	{
		maxEncoders = 1
	}
	}
 */
@:unreflective
@:structAccess
@:native("bgfx::Init")
@:include('bgfx/bgfx.h')
extern class BgfxInitOptions {
	public static inline function create():BgfxInitOptions {
		return untyped __cpp__('0');
	}
}
