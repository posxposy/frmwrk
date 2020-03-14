package frmwrk.math;

@:notNull
abstract Mat4(Mat4Impl) from Mat4Impl {
	public inline function new(val:Mat4Impl) {
		this = val;
	}

	public static inline function indent():Mat4 {
		return new Mat4(Mat4Impl.create(1.0));
	}

	@:op(A * B)
	public inline function mult(vec:Mat4):Mat4 {
		return untyped __cpp__('{0} * {1}', this, vec);
	}

	@:op(A * B)
	public inline function multvec(vec:Vec4f):Vec4f {
		return untyped __cpp__('{0} * {1}', this, vec);
	}

	public inline function getValue(i:Int, j:Int):Single {
		return untyped __cpp__('{0}[{1}][{2}]', this, i, j);
	}

	public inline function setValue(i:Int, j:Int, value:Single):Single {
		return untyped __cpp__('{0}[{1}][{2}] = {3}', this, i, j, value);
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
