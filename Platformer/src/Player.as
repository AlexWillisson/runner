package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		
		public function Player(sprite: Class):void
		{
			loadGraphic(sprite, true, true, 14, 15);
			//SETTING ANIMATIONS
			addAnimation("idle"/*name of animation*/, [0]/*used frames*/);
			addAnimation("walk", [0, 1, 2, 1], 5/*frames per second*/);
			addAnimation("jump", [3]);
			acceleration.y = 300; //ADDING GRAVITY
		}
		
		override public function update():void
		{
			velocity.x = 62.5; //SET SPEED
			facing = RIGHT; //CHANGE FACING

			movement();
				
			super.update();
		}

		private function movement():void
		{
			if (touching & DOWN) {
				if (FlxG.keys.UP || FlxG.keys.W) {
					velocity.y = -150;
				} else {
					play("walk");
				}
			} else {
				play("jump");
			}
		}
	}
}
