package frmwrk;

import bgfx.RenderType;
import cpp.ConstStar;
import frmwrk.input.MouseMode;
import haxe.io.Bytes;
import sys.io.File;

typedef InitSettingsStruct = {
	title:String,
	?height:Int,
	?width:Int,
	?vsync:Bool,
	?fullscreen:Bool,
	?renderType:RendererType
}

@:buildXml('
	<files id="haxe">
		<compilerflag value="-I${haxelib:frmwrk}/bgfx/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bx/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bx/include/compat/msvc/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bimg/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/glm/"/>
		<compilerflag value="-I${haxelib:frmwrk}/glfw/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/assimp/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/assimp/build/include/"/>
	</files>

	<files id="__main__">
		<compilerflag value="-I${haxelib:frmwrk}/bgfx/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bx/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bx/include/compat/msvc/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bimg/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/glm/"/>
		<compilerflag value="-I${haxelib:frmwrk}/glfw/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/assimp/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/assimp/build/include/"/>
	</files>

	<target id="haxe" tool="linker" toolid="exe">
		<lib name="gdi32.lib"/>
		<lib name="psapi.lib"/>
		<lib name="user32.lib"/>
		<lib name="shell32.lib"/>

		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bgfxRelease.lib" />
		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bxRelease.lib" />
		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bimgRelease.lib" />
		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bimg_decodeRelease.lib" />
		<lib name="${haxelib:frmwrk}/glfw/build/src/Release/glfw3.lib" />
		<lib name="${haxelib:frmwrk}/assimp/build/code/Release/assimp-vc142-mt.lib" />
	</target>

	<compiler id="MSVC" exe="cl.exe">
		<flag value="-DGLM_FORCE_DEPTH_ZERO_TO_ONE"/>
	</compiler>
')
@:headerCode('
	#include <bx/bx.h>
	#include <bx/math.h>
	#include <bgfx/bgfx.h>
	#include <bgfx/platform.h>

	#include <GLFW/glfw3.h>
#if BX_PLATFORM_LINUX
	#define GLFW_EXPOSE_NATIVE_X11
#elif BX_PLATFORM_WINDOWS
	#define GLFW_EXPOSE_NATIVE_WIN32
#endif
	#include <GLFW/glfw3native.h>
')
@:headerClassCode('
	GLFWwindow *window = nullptr;
')
@:headerInclude('./HelpersExt.h')
final class Frmwrk {
	static var _game:IApp;

	public var showDebugStats:Bool = #if debug true #else false #end;
	public var width(default, null):Int;
	public var height(default, null):Int;

	extern var window:GLFWwindow;
	var isVsyncEnabled:Bool;

	final gfx:Gfx;
	final gameTime:GameTime;

	public function new() {
		gfx = new Gfx();
		gameTime = new GameTime();
	}

	//renderer:RendererType, title:String, isFullScreen:Bool = false, isVsyncEnabled:Bool = false, ?width:Int, ?height:Int
	public function init(o:InitSettingsStruct, renderer:RendererType):Bool {
		if (!glfwInit()) {
			return false;
		}
		final videoMode = getPrimaryMonitorVideoMode();

		this.width = o.width == null ? videoMode.width : o.width;
		this.height = o.height == null ? videoMode.height : o.height;
		this.isVsyncEnabled = o.vsync == null ? true : o.vsync;
		final isFullScreen:Bool = o.fullscreen == null ? true : o.fullscreen;
		final title = o.title;

		videoMode.delete();

		untyped __cpp__('
			glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
			window = glfwCreateWindow({1}, {2}, {0}, {3} ? glfwGetPrimaryMonitor() : nullptr, nullptr);
			if (!window) {
				return false;
			}

			bgfx::renderFrame();
			bgfx::Init init;
			init.type = {5};
			init.resolution.width = {1};
			init.resolution.height = {2};

			int _width, _height;
			glfwGetWindowSize(window, &_width, &_height);

			#if BX_PLATFORM_LINUX || BX_PLATFORM_BSD
				init.platformData.ndt = glfwGetX11Display();
				init.platformData.nwh = (void*)(uintptr_t)glfwGetX11Window(window);
			#elif BX_PLATFORM_OSX
				init.platformData.nwh = glfwGetCocoaWindow(window);
			#elif BX_PLATFORM_WINDOWS
				init.platformData.nwh = glfwGetWin32Window(window);
			#endif

			if ({3}){ //! Not supported yet by BGFX
				init.resolution.reset |= BGFX_RESET_FULLSCREEN;
			}
			if ({4}) {
				init.resolution.reset |= BGFX_RESET_VSYNC;
			}

			if (!bgfx::init(init)) {
				return false;
			}

		', title, width, height, isFullScreen, isVsyncEnabled, renderer);

		return true;
	}

	public function run(game:IApp):Void {
		_game = game;
		untyped __cpp__('
			glfwSetKeyCallback(window, [](GLFWwindow *window, int key, int scancode, int action, int mode) {
				switch (action) {
				case GLFW_PRESS:
					::frmwrk::IApp_obj::onKeyDown({0}, key);
					break;
				case GLFW_RELEASE:
					::frmwrk::IApp_obj::onKeyUp({0}, key);
					break;
				default:
					break;
				}
			});
			glfwSetScrollCallback(window, [](GLFWwindow *window, double x, double y) {
				::frmwrk::IApp_obj::onMouseScroll({0}, y);
			});
			glfwSetMouseButtonCallback(window, [](GLFWwindow *window, int button, int action, int mods) {
				switch (action) {
				case GLFW_PRESS:
					::frmwrk::IApp_obj::onMouseDown({0}, button);
					break;
				case GLFW_RELEASE:
					::frmwrk::IApp_obj::onMouseUp({0}, button);
					break;
				default:
					break;
				}
			});
		', _game);

		while (!glfwWindowShouldClose()) {
			gameTime.begin();
			untyped __cpp__('glfwPollEvents()');

			var x:cpp.Float64 = 0.0;
			var y:cpp.Float64 = 0.0;
			untyped __cpp__('glfwGetCursorPos({0}, &{1}, &{2});', window, x, y);
			game.onMouseMove(Std.int(x), Std.int(y));

			game.onUpdate(gameTime);
			game.onDraw(gfx);

			untyped __cpp__('bgfx::setDebug({0} ? BGFX_DEBUG_STATS : BGFX_DEBUG_TEXT)', showDebugStats);
			gameTime.end();
		}

		untyped __cpp__('
			bgfx::shutdown();
			glfwTerminate()
		');
	}

	public function setMouseCursorMode(mode:MouseMode):Void {
		untyped __cpp__('
			int flag = GLFW_CURSOR_NORMAL;
			if ({1} == 1) {
				flag = GLFW_CURSOR_HIDDEN;
			} else if ({1} == 2) {
				flag = GLFW_CURSOR_DISABLED;
			}
			glfwSetInputMode({0}, GLFW_CURSOR, flag)
		', window, mode);
	}

	inline extern function glfwInit():Bool {
		return untyped __cpp__('glfwInit()');
	}

	inline extern function getPrimaryMonitorVideoMode():ConstStar<GLFWvidmode> {
		return untyped __cpp__('glfwGetVideoMode(glfwGetPrimaryMonitor())');
	}

	inline function glfwWindowShouldClose():Bool {
		return untyped __cpp__('glfwWindowShouldClose({0})', window);
	}
}

@:unreflective
@:native('GLFWwindow *')
@:include('GLFW/glfw3.h')
private extern class GLFWwindow {
}

@:structAccess
@:unreflective
@:native('GLFWvidmode')
@:include('GLFW/glfw3.h')
private extern class GLFWvidmode {
	public var width:Int;
	public var height:Int;
	public var redBits:Int;
	public var greenBits:Int;
	public var blueBits:Int;
	public var refreshRate:Int;

	public inline function delete():Void {
		untyped __cpp__('delete {0}', this);
	}
}
