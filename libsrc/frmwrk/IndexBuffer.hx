package frmwrk;

import bgfx.IndexBufferHandle;
import haxe.io.Bytes;
import haxe.io.BytesData;
import haxe.io.Int32Array;

@:headerCode('
	#include <bgfx/bgfx.h>
')
@:headerClassCode('
	bgfx::IndexBufferHandle ibh;
')
final class IndexBuffer {
	final data:Bytes;
	extern var ibh:IndexBufferHandle;

	public function new(data:Array<Int>) {
		this.data = Bytes.alloc(data.length * 2);
		for (i in 0...data.length) {
			this.data.setUInt16(i * 2, data[i]);
		}
		untyped __cpp__('
			{0} = bgfx::createIndexBuffer(bgfx::makeRef((const void*)&({1}[0]), {2} ));
		', ibh, this.data.getData(), this.data.length);
	}
}
