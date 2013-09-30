package
{
	import flash.automation.ActionGenerator;
	import org.flixel.*;
	public class PlayState extends FlxState
	{
		private var background:FlxBackdrop
		private var map1:FlxTilemap;
		private var map2:FlxTilemap;
		private var current:FlxTilemap;
		private var player:Player;
		private var firstleg:Limb;
		private var tileX:int;
		private var startX:int;
		private var groundIdx:int = 14;
		public var paused:Paused;
		public var allowHills:Boolean;
		public var queuePlatforms:Array; 
		public var platform1:FlxSprite;
		public var platform2:FlxSprite;
		public var currentPlatform:FlxSprite;
		private var gapWidth:int = 20;
		private var jumpHeight:int = 40;
		
		public var timerNum:Number = 0;
		public var timerText:FlxText;
		public function PlayState():void
		{
			
		}
		
		override public function create():void
		{
			//STARTING THE GAME...
			FlxG.flash(0);
			FlxG.framerate = 60;
			FlxG.flashFramerate = 60;
			
			background = new FlxBackdrop(Sources.ImgBackground, -0.54, 0, true, false); //endless background
			add(background); //ADDING BACKGROUND TO THE STAGE AND MAKING IT VISIBLE
			
			startX = 50;

			player = new Player(Sources.Torso); //CREATING PLAYER
			player.x = startX;
			// player.y = FlxG.height - 31; //SETTING POSITION OF THE PLAYER
			player.y = FlxG.height - 50;
			add(player); //ADDING PLAYER TO THE STAGE AND MAKING HIM VISIBLE
			FlxG.camera.follow(player.camTar)
			
			firstleg = new Limb(Sources.Leg);
			firstleg.x = FlxG.width - 100;
			firstleg.y = FlxG.height - 31;
			add(firstleg);

			timerText = new FlxText(0, 0, 100, " ");
			timerText.size = 16;
			add(timerText); 
			timerText.scrollFactor.x = 0;
			timerText.scrollFactor.y = 0;
			
			paused = new Paused;	//adding pause functionality
			
			queuePlatforms = new Array();
			platform1 = new FlxSprite(0, FlxG.height, Sources.Platform);
			platform1.y = FlxG.height - platform1.height;
			platform1.immovable = true;
			add(platform1);
			queuePlatforms.push(platform1); 
			
			platform2 = new FlxSprite(platform1.x + platform1.width + gapWidth, FlxG.height-jumpHeight, Sources.Platform);
			platform2.immovable = true;
			add(platform2);
			queuePlatforms.push(platform2); 
			
			currentPlatform = platform1; 
			
			super.create();

		}
		
		override public function update():void
		{
			
			if (!paused.showing)
			{
				FlxG.worldBounds.x += 1; 
				FlxG.worldBounds.width += 1;
				background.draw();
				timerNum += FlxG.elapsed;
				FlxG.timer = timerNum;
				timerText.text = "" + FlxU.floor(timerNum);
				
				//if (player.x > 640)
					//player.x = startX;

				FlxG.collide(player, platform2);
				FlxG.collide(player, platform1);
				FlxG.collide(firstleg, platform1);

				if (FlxG.collide(player, firstleg)) {
					player.loadGraphic(Sources.OneLeg, true, true, 14, 15);
					player.leg1 = true;
					allowHills = true;
					remove(firstleg);
				}
				
				if (!currentPlatform.onScreen()) 
				{
					currentPlatform = queuePlatforms[1]; 
					
					var temp:FlxSprite = queuePlatforms[0];
					queuePlatforms.splice(0, 1);
					temp.x = currentPlatform.x + currentPlatform.width + gapWidth * randomNum(1.5, currentPlatform.x, gapWidth, FlxG.width);
					temp.y = currentPlatform.y - jumpHeight * randomNum(1.5, currentPlatform.y, jumpHeight, FlxG.height);
					queuePlatforms.push(temp);
					
				}
				super.update()
				//death screen 
				if (FlxG.keys.COMMA)
				{
					FlxG.switchState(new EndScreen());
				}
				
				//pause screen 
				if (FlxG.keys.P)
				{
					paused = new Paused;			
					paused.showPaused();
					add(paused);
				}
				
				
			} else
			{
				paused.update();
			}
		}
		
		function randomNum(interval:Number, base:Number, multiplier:int, limit:Number):Number
		{
			var coinFlip:int; 
			if (Math.random() > 0.5) 
			{
				coinFlip = 1; 
			} else
			{
				coinFlip = -1; 
			}
			var rand:Number = Math.random() * interval;
			rand = rand * coinFlip;
			
			if (base + multiplier * rand > limit) 
			{
				//return randomNum(interval, base, multiplier, limit);
			}
			trace(rand);
			return rand;
		}
	}
}
