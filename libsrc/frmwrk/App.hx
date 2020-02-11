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
	</files>

	<files id="__main__">
		<compilerflag value="-I${haxelib:frmwrk}/bgfx/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bx/include/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bx/include/compat/msvc/"/>
		<compilerflag value="-I${haxelib:frmwrk}/bimg/include/"/>

		<compilerflag value="-I${haxelib:frmwrk}/glm/"/>
	</files>

	<target id="haxe" tool="linker" toolid="exe">
		<lib name="gdi32.lib"/>
		<lib name="psapi.lib"/>

		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bgfxRelease.lib" />
		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bxRelease.lib" />
		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bimgRelease.lib" />
		<lib name="${haxelib:frmwrk}/bgfx/.build/win32_vs2019/bin/bimg_decodeRelease.lib" />
	</target>
')
@:headerCode('
	#include <Windows.h>
	#include <memory>

	#include <bx/bx.h>
	#include <bx/math.h>
	#include <bgfx/bgfx.h>
	#include <bgfx/platform.h>
')
@:headerClassCode('
	HWND m_handle;
	MSG msg;
')
@:cppFileCode('
LRESULT CALLBACK winProc (HWND handle, UINT msg, WPARAM wparam, LPARAM lparam) {
	if (msg == WM_DESTROY || msg == WM_CLOSE) {
			PostQuitMessage(0);
			return 0;
	}

	switch (msg) {
			case WM_KEYDOWN:
					if (wparam == VK_ESCAPE) {
							if (MessageBox(nullptr, "Are you sure you want to exit?", "Really?", MB_YESNO | MB_ICONQUESTION) == IDYES) {
									//Release the windows allocated memory
									DestroyWindow(handle);
							}
					}
					return 0;

			case WM_DESTROY:	//if x button in top right was pressed
					PostQuitMessage(0);
					return 0;

			case WM_SYSKEYDOWN:
			case WM_KEYUP:
			case WM_SYSKEYUP:
					//DirectX::Keyboard::ProcessMessage(msg, wparam, lparam);
					break;
			case WM_ACTIVATEAPP:
					//DirectX::Keyboard::ProcessMessage(msg, wparam, lparam);
					//DirectX::Mouse::ProcessMessage(msg, wparam, lparam);
					break;
			case WM_INPUT:
			case WM_MOUSEMOVE:
			case WM_LBUTTONDOWN:
			case WM_LBUTTONUP:
			case WM_RBUTTONDOWN:
			case WM_RBUTTONUP:
			case WM_MBUTTONDOWN:
			case WM_MBUTTONUP:
			case WM_MOUSEWHEEL:
			case WM_XBUTTONDOWN:
			case WM_XBUTTONUP:
			case WM_MOUSEHOVER:
					//DirectX::Mouse::ProcessMessage(msg, wparam, lparam);
					break;
	}

	return DefWindowProc(handle, msg, wparam, lparam);
}

bgfx::ShaderHandle loadShader(const char *FILENAME)
{

    FILE *file = fopen(FILENAME, "rb");
    fseek(file, 0, SEEK_END);
    long fileSize = ftell(file);
    fseek(file, 0, SEEK_SET);

    const bgfx::Memory *mem = bgfx::alloc(fileSize + 1);
    fread(mem->data, 1, fileSize, file);
    //mem->data[mem->size - 1] = 0;
    fclose(file);

    return bgfx::createShader(mem);
}
')
@:headerInclude('./HelpersExt.h')
final class App {
	public var showDebugStats:Bool = true;
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var renderer(default, null):RendererType;

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

		untyped __cpp__('
			std::memset(&msg, 0, sizeof(msg));

			WNDCLASS wc;
			std::memset(&wc, 0, sizeof(wc));
			wc.style = CS_OWNDC;
			wc.lpfnWndProc = winProc;
			wc.hCursor = LoadCursor(nullptr, IDC_ARROW);
			wc.lpszClassName = "frmwrk";
			RegisterClass(&wc);

			auto screenWidth = GetSystemMetrics(SM_CXSCREEN);
			auto screenHeight = GetSystemMetrics(SM_CYSCREEN);

			DWORD style = WS_POPUP | WS_CAPTION | WS_SYSMENU | WS_VISIBLE;
			RECT wnd = {0, 0, {1}, {2}};
			AdjustWindowRect(&wnd, style, FALSE);

			int w = (wnd.right - wnd.left);
			int h = (wnd.bottom - wnd.top);

			m_handle = CreateWindow (
				"frmwrk",
				{0}.c_str(),
				style,
				(screenWidth - {1}) / 2, (screenHeight - {2}) / 2,
				w,
				h,
				nullptr,
				nullptr,
				nullptr,
				nullptr
			);

			bgfx::Init init;
			init.type = {5};
			init.resolution.width = {1};
			init.resolution.height = {2};
			init.platformData.nwh = m_handle;
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

	public function run(game:Game):Void {
		untyped __cpp__('
			const bgfx::ViewId clearViewId = {0};
			bgfx::setViewRect(clearViewId, 0, 0, bgfx::BackbufferRatio::Equal);
		', @:privateAccess gfx.viewId);

		gfx.clearColor(0x443355FF);

		final counter:Int = 0;
		while (true) {
			gameTime.begin();

			untyped __cpp__('
				if (PeekMessage(&msg, nullptr, 0, 0, PM_REMOVE)) {
					if (msg.message == WM_QUIT) {
						break;
					}
					TranslateMessage(&msg);
					DispatchMessage(&msg);
				}

				bgfx::touch(clearViewId);
			');

			game.onUpdate(gameTime);

			untyped __cpp__('
				bgfx::dbgTextClear();
				counter++;
				/*const bx::Vec3 at = {0.0f, 0.0f,  0.0f};
				const bx::Vec3 eye = {0.0f, 0.0f, -5.0f};
				float view[16];
				bx::mtxLookAt(view, eye, at);
				float proj[16];
				bx::mtxProj(proj, 60.0f, 1.33f, 0.1f, 100.0f, bgfx::getCaps()->homogeneousDepth);
				bgfx::setViewTransform(0, view, proj);

				float mtx[16];
				bx::mtxRotateXY(mtx, counter * 0.01f, counter * 0.01f);
				bgfx::setTransform(mtx);*/
			');

			game.onDraw(gfx);

			untyped __cpp__('
				bgfx::setDebug({0} ? BGFX_DEBUG_STATS : BGFX_DEBUG_TEXT);
				bgfx::frame()
			', showDebugStats);

			gameTime.end();
		}

		untyped __cpp__('bgfx::shutdown()');
	}

	public inline extern function bytesToMemory(bytes:Bytes):BgfxMemory {
		return untyped __cpp__('Helpers::getMemory( (uint8_t *const)&({0}[0]), {1} )', bytes.getData(), bytes.length);
	}
}

@:unreflective
@:native('const bgfx::Memory *')
@:include('bgfx/bgfx.h')
extern class BgfxMemory {
}
