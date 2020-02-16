package frmwrk;

import bgfx.RenderType;
import haxe.io.Bytes;
import sys.io.File;

@:buildXml('
	<files id="haxe">
		<compilerflag value="-I${haxelib:frmwrk}/bgfx/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bx/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bx/include/compat/msvc/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bimg/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/glm/"/>
		<compilerflag value="-I${haxelib:frmwrk}/glfw/include/"/>
	</files>

	<files id="__main__">
		<compilerflag value="-I${haxelib:frmwrk}/bgfx/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bx/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bx/include/compat/msvc/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bimg/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/glm/"/>
		<compilerflag value="-I${haxelib:frmwrk}/glfw/include/"/>
	</files>

	<target id="haxe" tool="linker" toolid="exe">
		<lib name="gdi32.lib"/>
		<lib name="psapi.lib"/>

		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bgfxRelease.lib" />
		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bxRelease.lib" />
		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bimgRelease.lib" />
		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bimg_decodeRelease.lib" />
		<lib name="${haxelib:frmwrk}/glfw/lib/glfw3dll.lib" />
	</target>
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
	public var showDebugStats:Bool = true;
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var renderer(default, null):RendererType;

	extern var window:GLFWwindow;
	var isVsyncEnabled:Bool;

	final gfx:Gfx;
	final gameTime:GameTime;

	public function new() {
		gfx = new Gfx(0);
		gameTime = new GameTime();
	}

	public function init(renderer:RendererType, title:String, width:Int, height:Int, isFullScreen:Bool = false, isVsyncEnabled:Bool = false):Bool {
		this.width = width;
		this.height = height;
		this.renderer = renderer;
		this.isVsyncEnabled = isVsyncEnabled;

		untyped __cpp__('
			if (!glfwInit()) {
				return false;
			}
			glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
			window = glfwCreateWindow({1}, {2}, "helloworld", {3} ? glfwGetPrimaryMonitor() : nullptr, nullptr);
			if (!window) {
				return false;
			}

			//bgfx::renderFrame();
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

	static var _game:IApp;

	public function run(game:IApp):Void {
		_game = game;
		untyped __cpp__('
			glfwSetKeyCallback(window, [](GLFWwindow *window, int key, int scancode, int action, int mode) {
				switch (action) {
				case GLFW_PRESS:
					::frmwrk::IApp_obj::onKeyDown({1}, key);
					break;
				case GLFW_RELEASE:
					::frmwrk::IApp_obj::onKeyUp({1}, key);
					break;
				default:
					break;
				}
			});

			glfwSetCursorPosCallback(window, [](GLFWwindow *window, double x, double y) {
				::frmwrk::IApp_obj::onMouseMove({1}, x, y);
			});
			glfwSetScrollCallback(window, [](GLFWwindow *window, double x, double y) {
				::frmwrk::IApp_obj::onMouseScroll({1}, y);
			});
			glfwSetMouseButtonCallback(window, [](GLFWwindow *window, int button, int action, int mods) {
				switch (action) {
				case GLFW_PRESS:
					::frmwrk::IApp_obj::onMouseDown({1}, button);
					break;
				case GLFW_RELEASE:
					::frmwrk::IApp_obj::onMouseUp({1}, button);
					break;
				default:
					break;
				}
			});

			const bgfx::ViewId clearViewId = {0};
			bgfx::setViewRect(clearViewId, 0, 0, bgfx::BackbufferRatio::Equal);
		', @:privateAccess gfx.viewId, _game);

		gfx.clearColor(0x443355FF);
		while (!glfwWindowShouldClose(window)) {
			gameTime.begin();

			untyped __cpp__('
				glfwPollEvents();
				bgfx::touch(clearViewId);
			', width, height, window, isVsyncEnabled);

			game.onUpdate(gameTime);
			game.onDraw(gfx);

			untyped __cpp__('
				bgfx::setDebug({0} ? BGFX_DEBUG_STATS : BGFX_DEBUG_TEXT);
				bgfx::frame()
			', showDebugStats);

			gameTime.end();
		}

		untyped __cpp__('
			bgfx::shutdown();
			glfwTerminate()
		');
	}

	public inline extern function bytesToMemory(bytes:Bytes):BgfxMemory {
		return untyped __cpp__('Helpers::getMemory( (uint8_t *const)&({0}[0]), {1} )', bytes.getData(), bytes.length);
	}

	public inline extern function glfwWindowShouldClose(window:GLFWwindow):Bool {
		return untyped __cpp__('glfwWindowShouldClose({0})', window);
	}
}

@:unreflective
@:native('const bgfx::Memory *')
@:include('bgfx/bgfx.h')
extern class BgfxMemory {
}

@:unreflective
@:native('GLFWwindow *')
@:include('GLFW/glfw3.h')
extern class GLFWwindow {
}
