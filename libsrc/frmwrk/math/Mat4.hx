package frmwrk.math;

abstract Mat4(Mat4Impl) from Mat4Impl {
	public inline function new(val:Mat4Impl) {
		this = val;
	}

	public static inline function indent():Mat4 {
		return new Mat4(Mat4Impl.create(1.0));
	}
}

@:unreflective
@:structAccess
@:include('glm/matrix.hpp')
@:native('glm::mat4')
extern class Mat4Impl {
	@:native('glm::mat4') public static function create(initValue:Single):Mat4Impl;
	public static inline function multMat(a:Mat4, b:Mat4):Mat4 {
		return untyped __cpp__('{0} * {1}', a, b);
	}
}
