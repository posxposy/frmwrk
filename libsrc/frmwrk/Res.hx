package frmwrk;

import assimp.AiFace;
import assimp.AiMaterial;
import assimp.AiMesh;
import assimp.AiNode;
import assimp.AiPostProcess;
import assimp.AiScene;
import assimp.AiString;
import assimp.AiTextureType;
import assimp.AssimpImporter;
import assimp.math.AiMatrix4x4;
import assimp.math.AiQuaternion;
import assimp.math.AiVector3D;
import cpp.Pointer;
import frmwrk.VertexBuffer.LayoutAttribType;
import frmwrk.graphics.Mesh;
import frmwrk.graphics.Model;
import haxe.ds.StringMap;
import haxe.io.Bytes;
import sys.io.File;

final class Res {
	public static var DEFAULT_TEX_FLAGS:TextureFlags = TextureNone | SamplerNone;
	static var tex2dCache:StringMap<Texture2D>;
	static var textsCache:StringMap<String>;
	static var importer:AssimpImporter;

	public static function loadTexture2D(file:String, flags:TextureFlags):Texture2D {
		if (tex2dCache == null) {
			tex2dCache = new StringMap();
		}
		if (tex2dCache.exists(file)) {
			return tex2dCache.get(file);
		}

		final t = new Texture2D(file, File.getBytes(file), flags);
		tex2dCache.set(file, t);
		return t;
	}

	public static function loadTextFile(file:String):String {
		if (textsCache == null) {
			textsCache = new StringMap();
		}
		if (textsCache.exists(file)) {
			return textsCache.get(file);
		}

		final f = File.getContent(file);
		textsCache.set(file, f);
		return f;
	}

	public static function loadShaderBytes(file:String):Bytes {
		return File.getBytes(file);
	}

	public static function loadModel(file:String):Model {
		final meshes:Array<Mesh> = [];
		if (importer == null) {
			importer = new AssimpImporter();
		}

		final scene = importer.readFileFromMemory(File.getBytes(file).getData(), AiPostProcess.triangulate | AiPostProcess.flipUVs);

		function processMesh(node:Pointer<AiNode>, aiMesh:Pointer<AiMesh>, index:Int):Void {
			final data:Array<Float> = [];
			final indices:Array<Int> = [];

			for (i in 0...aiMesh.ptr.numVertices) {
				data.push(aiMesh.ptr.vertices[i].x);
				data.push(aiMesh.ptr.vertices[i].y);
				data.push(aiMesh.ptr.vertices[i].z);

				var u:Float = 0;
				var v:Float = 0;
				if (aiMesh.ptr.textureCoords[0] != null) {
					u = aiMesh.ptr.textureCoords[0][i].x;
					v = aiMesh.ptr.textureCoords[0][i].y;
				}

				data.push(u);
				data.push(v);
			}

			for (i in 0...aiMesh.ptr.numFaces) {
				var aiFace:AiFace = aiMesh.ptr.faces[i];
				for (j in 0...aiFace.numIndices) {
					indices.push(aiFace.indices[j]);
				}
			}

			final mesh = new Mesh(data, indices);
			mesh.vb.begin();
			mesh.vb.add(Position, 3, LayoutAttribType.Float);
			mesh.vb.add(TexCoord0, 2, LayoutAttribType.Float);
			mesh.vb.end();

			meshes.push(mesh);
		}

		function processNode(node:Pointer<AiNode>):Void {
			for (i in 0...node.ptr.numMeshes) {
				final meshIndex = node.ptr.meshes[i];
				processMesh(node, scene.ptr.meshes[meshIndex], i);
			}
			for (i in 0...node.ptr.numChildren) {
				processNode(node.ptr.children[i]);
			}
		}

		if (scene == null || scene.ptr.flags == AiScene.AI_SCENE_FLAGS_INCOMPLETE || scene.ptr.rootNode == null) {
			throw "Model loding failded.";
		}
		else {
			processNode(scene.ptr.rootNode);
		}

		importer.freeScene();

		return new Model(meshes);
	}
}
