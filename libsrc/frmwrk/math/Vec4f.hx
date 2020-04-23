package frmwrk.math;

@:notNull
@:forward(x, y, z, w)
abstract Vec4f(Vec4fImpl) from Vec4fImpl {
	public inline function new(x:Single = 0, y:Single = 0, z:Single = 0, w:Single = 0) {
		this = Vec4fImpl.create(x, y, z, w);
	}

	public static inline function one():Vec4f {
		return Vec4fImpl.create(1.0, 1.0, 1.0, 1.0);
	}

	@:op(A + B)
	public inline function add(vec:Vec4f):Vec4f {
		return untyped __cpp__('{0} + {1}', this, vec);
	}

	@:op(A - B)
	public inline function sub(vec:Vec4f):Vec4f {
		return untyped __cpp__('{0} - {1}', this, vec);
	}

	@:op(A * B)
	public inline function mult(vec:Vec4f):Vec4f {
		return untyped __cpp__('{0} * {1}', this, vec);
	}

	@:op(A * B)
	public inline function multf(value:Single):Vec4f {
		return untyped __cpp__('{0} * (float){1}', this, value);
	}

	public inline function clone():Vec4f {
		return new Vec4f(this.x, this.y, this.z, this.w);
	}

	public inline function toString():String {
		return 'Vec4f(${this.x}, ${this.y}, ${this.z}, ${this.w})';
	}
}

@:unreflective
@:structAccess
@:include('./Vec4f.h')
@:native('glm::vec4')
extern class Vec4fImpl {
	@:native('glm::vec4') public static function create(x:Single, y:Single, z:Single, w:Single):Vec4fImpl;
	public var x:Single;
	public var y:Single;
	public var z:Single;
	public var w:Single;
}
