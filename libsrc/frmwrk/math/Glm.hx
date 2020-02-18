package frmwrk.math;

import cpp.ConstCharStar;
import cpp.Star;
import cpp.Void;

@:unreflective
@:include('./GlmHeaders.h')
@:native('glm')
extern class Glm {
	@:native('glm::cross') public static function crossVec3(v1:Vec3, v2:Vec3):Vec3;
	@:native('glm::normalize') public static function normalizeVec3(v:Vec3):Vec3;
	@:native('glm::radians') public static function radians(degrees:Single):Single;
	@:native('glm::perspective') public static function perspective(fovy:Single, aspect:Single, zNear:Single, zFar:Single):Mat4;
	@:native('glm::lookAt') public static function lookAt(eye:Vec3, center:Vec3, up:Vec3):Mat4;
	@:native('glm::scale') public static function scale(m:Mat4, v:Vec3):Mat4;
	@:native('glm::translate') public static function translate(m:Mat4, v:Vec3):Mat4;
	@:native('glm::rotate') public static function rotate(m:Mat4, radians:Single, v:Vec3):Mat4;
	@:native('glm::value_ptr') public static function valuePtr(m:Mat4):Star<Void>;
	@:native('glm::pi<float>') public static function pi():Single;

	public static inline function matToString(m:Mat4):String {
		final chars:ConstCharStar = untyped __cpp__('glm::to_string({0}).c_str()', m);
		return chars.toString();
	}
}
