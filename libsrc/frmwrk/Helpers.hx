package frmwrk;

import bgfx.Memory;
import haxe.io.Bytes;

@:headerCode('
	#include <bx/bx.h>
')
@:cppFileCode('

')
@:cppNamespaceCode('

')
@:headerInclude('./HelpersExt.h')
class Helpers {
	public static inline function bytesToMemory(bytes:Bytes):Memory {
		return untyped __cpp__('HelpersExt::getMemory( (uint8_t *const)&({0}[0]), {1} )', bytes.getData(), bytes.length);
	}
}
