package
{
	import org.flixel.*;
	
	public class Limb extends FlxSprite
	{
		
		public function Limb(sprite: Class):void
		{
			loadGraphic(sprite, true, true, 14, 15);
			addAnimation("idle", [0]);
			acceleration.y = 300;
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}
