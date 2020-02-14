package frmwrk.math;

@:forward(x, y, z)
abstract Vec3(Vec3Impl) from Vec3Impl {
	public inline function new(x:Single = 0, y:Single = 0, z:Single = 0) {
		this = Vec3Impl.create(x, y, z);
	}

	public static inline function one():Vec3 {
		return Vec3Impl.create(1.0, 1.0, 1.0);
	}

	@:op(A + B)
	public inline function add(vec:Vec3):Vec3 {
		return untyped __cpp__('{0} + {1}', this, vec);
	}

	@:op(A - B)
	public inline function sub(vec:Vec3):Vec3 {
		return untyped __cpp__('{0} - {1}', this, vec);
	}

	@:op(A * B)
	public inline function mult(vec:Vec3):Vec3 {
		return untyped __cpp__('{0} * {1}', this, vec);
	}

	@:op(A * B)
	public inline function multf(value:Single):Vec3 {
		return untyped __cpp__('{0} * (float){1}', this, value);
	}
}

@:unreflective
@:structAccess
@:include('glm/vec3.hpp')
@:native('glm::vec3')
extern class Vec3Impl {
	@:native('glm::vec3') public static function create(x:Single, y:Single, z:Single):Vec3Impl;
	public var x:Single;
	public var y:Single;
	public var z:Single;
}
