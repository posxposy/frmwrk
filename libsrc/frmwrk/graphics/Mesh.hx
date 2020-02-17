package frmwrk.graphics;

import frmwrk.IndexBuffer;
import frmwrk.VertexBuffer;

class Mesh {
	public final ib:IndexBuffer;
	public final vb:VertexBuffer;

	public function new(vertexData:Array<Float>, indices:Array<Int>) {
		vb = new VertexBuffer(vertexData);
		ib = new IndexBuffer(indices);
	}
}
