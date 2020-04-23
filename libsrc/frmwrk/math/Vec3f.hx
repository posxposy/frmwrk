package frmwrk.math;

@:notNull
@:forward(x, y, z)
abstract Vec3f(Vec3fImpl) from Vec3fImpl {
	public inline function new(x:Single = 0, y:Single = 0, z:Single = 0) {
		this = Vec3fImpl.create(x, y, z);
	}

	public static inline function one():Vec3f {
		return Vec3fImpl.create(1.0, 1.0, 1.0);
	}

	@:op(A + B)
	public inline function add(vec:Vec3f):Vec3f {
		return untyped __cpp__('{0} + {1}', this, vec);
	}

	@:op(A - B)
	public inline function sub(vec:Vec3f):Vec3f {
		return untyped __cpp__('{0} - {1}', this, vec);
	}

	@:op(A * B)
	public inline function mult(vec:Vec3f):Vec3f {
		return untyped __cpp__('{0} * {1}', this, vec);
	}

	@:op(A * B)
	public inline function multf(value:Single):Vec3f {
		return untyped __cpp__('{0} * (float){1}', this, value);
	}

	public inline function clone():Vec3f {
		return new Vec3f(this.x, this.y, this.z);
	}

	public inline function toString():String {
		return 'Vec3f(${this.x}, ${this.y}, ${this.z})';
	}
}

@:unreflective
@:structAccess
@:include('./Vec3f.h')
@:native('glm::vec3')
extern class Vec3fImpl {
	@:native('glm::vec3') public static function create(x:Single, y:Single, z:Single):Vec3fImpl;
	public var x:Single;
	public var y:Single;
	public var z:Single;
}
