package frmwrk;

@:keep
interface IApp {
	function onUpdate(gameTime:GameTime):Void;
	function onDraw(gfx:Gfx):Void;
	function onKeyDown(key:Int):Void;
	function onKeyUp(key:Int):Void;
	function onMouseDown(button:Int):Void;
	function onMouseUp(button:Int):Void;
	function onMouseMove(x:Int, y:Int):Void;
	function onMouseScroll(delta:Float):Void;
}
