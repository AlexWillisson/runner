package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		
		public function Player():void
		{
			//LOADING GRAPHIC
			loadGraphic(Sources.ImgPlayer, true, true, 14, 15);
			//SETTING ANIMATIONS
			addAnimation("idle"/*name of animation*/, [0]/*used frames*/);
			addAnimation("walk", [0, 1, 2, 1], 5/*frames per second*/);
			addAnimation("jump", [3]);
			acceleration.y = 300; //ADDING GRAVITY
		}
		
		override public function update():void
		{
			super.update();
			move(); //CHECK INPUT AND ANIMATE AND MOVE THE PLAYER
		}
		
		private function move():void
		{
			//MAKE PLAYER STAND FIRST
			velocity.x = 0;
			//WHAT KEYS ARE PRESSED?
			var right:Boolean = (FlxG.keys.RIGHT || FlxG.keys.D);
			var left:Boolean = (FlxG.keys.LEFT || FlxG.keys.A);
			var up:Boolean = (FlxG.keys.UP || FlxG.keys.W);
			//JUMPING
			if (touching & DOWN)//IS TOUCHING THE GROUND
			{
				if (up)
				{
					velocity.y = -150; //JUMP!
					FlxG.play(Sources.Mp3Jump, 0.5);
				}
				if (!left && !right) //NOT MOVING
				{
					play("idle");
				}
				else //WALKING
				{
					play("walk");
				}
			}
			else //IN AIR
			{
				play("jump");
			}
			//WALKING & STANDING
			if (right)
			{
				velocity.x = 75; //SET SPEED
				facing = RIGHT; //CHANGE FACING
				if (x > FlxG.width - width)
				{
					velocity.x = 0; //DON'T GET OFF THE SCREEN
				}
			}
			else if (left) //SAME AS ABOVE
			{
				velocity.x = -75;
				facing = LEFT;
				if (x < 0)
				{
					velocity.x = 0;
				}
			}
		}
	}
}