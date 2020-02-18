package frmwrk.math;

@:notNull
@:forward(x, y, z)
abstract Vec2f(Vec2fImpl) from Vec2fImpl {
	public inline function new(x:Single = 0, y:Single = 0) {
		this = Vec2fImpl.create(x, y);
	}

	public static inline function one():Vec2f {
		return Vec2fImpl.create(1.0, 1.0);
	}

	@:op(A + B)
	public inline function add(vec:Vec2f):Vec2f {
		return untyped __cpp__('{0} + {1}', this, vec);
	}

	@:op(A - B)
	public inline function sub(vec:Vec2f):Vec2f {
		return untyped __cpp__('{0} - {1}', this, vec);
	}

	@:op(A * B)
	public inline function mult(vec:Vec2f):Vec2f {
		return untyped __cpp__('{0} * {1}', this, vec);
	}

	@:op(A * B)
	public inline function multf(value:Single):Vec2f {
		return untyped __cpp__('{0} * (float){1}', this, value);
	}
}

@:unreflective
@:structAccess
@:include('./Vec2f.h')
@:native('glm::vec2')
extern class Vec2fImpl {
	@:native('glm::vec2') public static function create(x:Single, y:Single):Vec2fImpl;
	public var x:Single;
	public var y:Single;
}
