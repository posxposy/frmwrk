package frmwrk.math;

@:notNull
@:forward(x, y, z, w)
abstract Quat(QuatImpl) from QuatImpl {
	public inline function new(x:Single = 0, y:Single = 0, z:Single = 0, w:Single = 0) {
		this = QuatImpl.create(x, y, z, w);
	}

	public static inline function one():Quat {
		return QuatImpl.create(1.0, 1.0, 1.0, 1.0);
	}

	@:op(A + B)
	public inline function add(quat:Quat):Quat {
		return untyped __cpp__('{0} + {1}', this, quat);
	}

	@:op(A - B)
	public inline function sub(quat:Quat):Quat {
		return untyped __cpp__('{0} - {1}', this, quat);
	}

	@:op(A * B)
	public inline function mult(quat:Quat):Quat {
		return untyped __cpp__('{0} * {1}', this, quat);
	}
}

@:unreflective
@:structAccess
@:include('./Quat.h')
@:native('glm::quat')
extern class QuatImpl {
	@:native('glm::quat') public static function create(x:Single, y:Single, z:Single, w:Single):QuatImpl;
	public var x:Single;
	public var y:Single;
	public var z:Single;
	public var w:Single;
}
