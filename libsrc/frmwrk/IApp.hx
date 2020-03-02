package frmwrk;

import frmwrk.input.KeyCode;

@:keep
interface IApp {
	function onUpdate(gameTime:GameTime):Void;
	function onDraw(gfx:Gfx):Void;
	function onKeyDown(key:KeyCode):Void;
	function onKeyUp(key:KeyCode):Void;
	function onMouseDown(button:Int):Void;
	function onMouseUp(button:Int):Void;
	function onMouseMove(x:Int, y:Int):Void;
	function onMouseScroll(delta:Int):Void;
}
