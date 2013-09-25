package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		public var leg1:Boolean;
		
		public function Player(sprite: Class):void
		{
			loadGraphic(sprite, true, true, 14, 15);
			//SETTING ANIMATIONS
			addAnimation("idle"/*name of animation*/, [0]/*used frames*/);
			addAnimation("walk", [0, 1, 2, 1], 5/*frames per second*/);
			addAnimation("jump", [3]);
			acceleration.y = 300; //ADDING GRAVITY

			leg1 = false;
		}
		
		override public function update():void
		{
			velocity.x = 62.5; //SET SPEED
			facing = RIGHT; //CHANGE FACING
			
			//death conditions for left, right, and bottom of screen
			if ((x < 0) || (x > FlxG.width - width) || (y > FlxG.height))
			{
				FlxG.switchState(new MenuState());
			}
			
			movement();
				
			super.update();
		}

		private function movement():void
		{
			if (touching & DOWN) {
				if (leg1 && (FlxG.keys.UP || FlxG.keys.W)) {
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
