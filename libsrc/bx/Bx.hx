package bx;

@:headerCode('
	#include <bgfx/bgfx.h>
	#include <bx/math.h>
')
@:headerClassCode('
	float mtx[16];
')
final class Bx {
	public static function projection(mat:Mat4, fovy:Single, aspect:Single, zNear:Single = 0.1, zFar:Single = 100.0):Void {
		untyped __cpp__('
			bx::mtxProj({0}->mtx, {1}, {2}, {3}, {4}, bgfx::getCaps()->homogeneousDepth);
		', mat, fovy, aspect, zNear, zFar);
	}
}
