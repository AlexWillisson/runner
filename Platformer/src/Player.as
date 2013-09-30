package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		public var leg1:Boolean;
		public var camTar:FlxObject;		

		// private var offX:int = 110;
		private var offX:int = 260;
		private var camY:int = 120;
		private var oldX:int = -1;
		private var jumpHeight:int = -200;

		public function Player(sprite: Class):void
		{
			loadGraphic(sprite, true, true, 14, 15);
			//SETTING ANIMATIONS
			addAnimation("idle"/*name of animation*/, [0]/*used frames*/);
			addAnimation("walk", [0, 1, 2, 1], 12/*frames per second*/);
			addAnimation("jump", [3]);
			acceleration.y = 600; //ADDING GRAVITY

			leg1 = false;

			camTar = new FlxObject;

			camTar.x = x + offX;
			camTar.y = camY;
		}
		
		override public function update():void
		{
			velocity.x = 100; //SET SPEED
			facing = RIGHT; //CHANGE FACING
			
			//death conditions for left, right, and bottom of screen
			if ((FlxU.floor(oldX) == FlxU.floor(x)) || (x < 0) || (y > FlxG.height)) {
				FlxG.switchState(new EndScreen());
			}
			
			if (oldX == -1)
				oldX = x;

			movement();
				
			camTar.x = x + offX;
			camTar.y = camY;

			super.update();

			oldX = x;
			
		}

		private function movement():void
		{
			if (touching & DOWN) {
				if (leg1 && (FlxG.keys.UP || FlxG.keys.W)) {
					velocity.y = jumpHeight;
				} else {
					play("walk");
				}
			} else {
				play("jump");
			}
		}
	}
}
