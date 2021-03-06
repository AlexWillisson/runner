package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		public var camTar:FlxObject;
		public var leg1:Boolean = false;
		public var leg2:Boolean = false;
		public var arm1:Boolean = false;
		public var arm2:Boolean = false;
		public var head:Boolean = false;

		private var offX:int = 110;
		// private var offX:int = 260;
		private var camY:int = 120;
		private var oldX:int = -1;
		public var doubleJumped:Boolean = false;
		private var jumpHeight:int = -200;

		public function Player(sprite: Class):void
		{
			loadGraphic(sprite, true, true, 14, 15);
			//SETTING ANIMATIONS
			addAnimation("idle"/*name of animation*/, [0]/*used frames*/);
			addAnimation("walk", [0, 1, 2, 1], 12/*frames per second*/);
			addAnimation("jump", [3]);
			acceleration.y = 600; //ADDING GRAVITY

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
			var justJumped:Boolean = false

			if (FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W")) {
				if (leg1 && (touching & DOWN)) {
					velocity.y = jumpHeight;
					justJumped = true;
					play("jump");
					FlxG.play(Sources.JumpSoundEffect,0.25);
				} else if (leg2 && !doubleJumped) {
					if (velocity.y > 0) {
						velocity.y = 0;
					}
					velocity.y += jumpHeight;
					justJumped = true;
					doubleJumped = true;
					FlxG.play(Sources.JumpSoundEffect,0.25);
				}
			} else if (touching & DOWN) {
				doubleJumped = false;
				play("walk");
			}
		}
	}
}
