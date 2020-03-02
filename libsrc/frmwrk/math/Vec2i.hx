package frmwrk.math;

@:notNull
@:forward(x, y, z)
abstract Vec2i(Vec2iImpl) from Vec2iImpl {
	public inline function new(x:Int = 0, y:Int = 0) {
		this = Vec2iImpl.create(x, y);
	}

	public static inline function one():Vec2i {
		return Vec2iImpl.create(1, 1);
	}

	@:op(A + B)
	public inline function add(vec:Vec2i):Vec2i {
		return untyped __cpp__('{0} + {1}', this, vec);
	}

	@:op(A - B)
	public inline function sub(vec:Vec2i):Vec2i {
		return untyped __cpp__('{0} - {1}', this, vec);
	}

	@:op(A * B)
	public inline function mult(vec:Vec2i):Vec2i {
		return untyped __cpp__('{0} * {1}', this, vec);
	}

	@:op(A * B)
	public inline function multf(value:Int):Vec2i {
		return untyped __cpp__('{0} * (int){1}', this, value);
	}
}

@:unreflective
@:structAccess
@:include('./Vec2i.h')
@:native('glm::vec2')
extern class Vec2iImpl {
	@:native('glm::vec2') public static function create(x:Int, y:Int):Vec2iImpl;
	public var x:Int;
	public var y:Int;
}
