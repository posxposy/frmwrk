package bx;

@:headerCode('
	#include <bgfx/bgfx.h>
	#include <bx/math.h>
')
@:headerClassCode('
	float mtx[16];
')
final class Mat4 {
	public function new(isIndent:Bool = true) {
		untyped __cpp__('{0}->mtx = {1} ? { 1.0 } : { 0.0 }', this, isIndent);
	}

	public function projection(fovy:Single, aspect:Single, zNear:Single = 0.1, zFar:Single = 100.0):Void {
		untyped __cpp__('
			bx::mtxProj({0}->mtx, {1}, {2}, {3}, {4}, bgfx::getCaps()->homogeneousDepth);
		', this, fovy, aspect, zNear, zFar);
	}
}
