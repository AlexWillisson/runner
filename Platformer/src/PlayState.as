package
{
	import flash.automation.ActionGenerator;
	import org.flixel.*;
	public class PlayState extends FlxState
	{
		private var background:FlxBackdrop
		private var player:Player;
		private var firstLeg:Limb;
		private var secondLeg:Limb;
		private var firstArm:Limb;
		private var secondArm:Limb;
		private var head:Limb;
		private var tileX:int;
		private var startX:int;
		private var groundIdx:int = 14;
		public var paused:Paused;
		public var allowHills:Boolean;
		public var queuePlatforms:Array; 
		public var platform1:FlxSprite;
		public var platform2:FlxSprite;
		public var currentPlatform:FlxSprite;
		private var gapWidth:int = 30;
		private var jumpHeight:int = 20;
		
		public var timerNum:Number = 0;
		public var timerText:FlxText;
		public function PlayState():void
		{
			
		}
		
		override public function create():void
		{
			//STARTING THE GAME...
			FlxG.play(Sources.BackgroundMusic,1,true);
			
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
			
			firstLeg = new Limb(Sources.Leg);
			firstLeg.x = 90;
			firstLeg.y = FlxG.height - 31;
			add(firstLeg);

			secondLeg = new Limb(Sources.Leg);
			secondLeg.x = 110;
			secondLeg.y = FlxG.height - 31;
			add(secondLeg);

			firstArm = new Limb(Sources.Arm);
			firstArm.x = 130
			firstArm.y = FlxG.height - 31;
			add(firstArm);

			secondArm = new Limb(Sources.Arm);
			secondArm.x = 150;
			secondArm.y = FlxG.height - 31;
			add(secondArm);

			head = new Limb(Sources.Head);
			head.x = 170;
			head.y = FlxG.height - 31;
			add(head);

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
				
				FlxG.collide(player, platform1);
				FlxG.collide(firstLeg, platform1);
				FlxG.collide(secondLeg, platform1);
				FlxG.collide(firstArm, platform1);
				FlxG.collide(secondArm, platform1);
				FlxG.collide(head, platform1);
				FlxG.collide(player, platform2);
				FlxG.collide(firstLeg, platform2);
				FlxG.collide(secondLeg, platform2);
				FlxG.collide(firstArm, platform2);
				FlxG.collide(secondArm, platform2);
				FlxG.collide(head, platform2);

				if (!player.leg1 && FlxG.collide(player, firstLeg)) {
					player.loadGraphic(Sources.OneLeg, true, true, 14, 15);
					player.leg1 = true;
					allowHills = true;
					remove(firstLeg);
				}

				if (!player.leg2 && FlxG.collide(player, secondLeg)) {
					player.loadGraphic(Sources.TwoLegs, true, true, 14, 15);
					player.leg2 = true;
					remove(secondLeg);
				}

				if (!player.arm1 && FlxG.collide(player, firstArm)) {
					player.loadGraphic(Sources.OneArm, true, true, 14, 15);
					player.arm1 = true;
					remove(firstArm);
				}

				if (!player.arm2 && FlxG.collide(player, secondArm)) {
					player.loadGraphic(Sources.TwoArms, true, true, 14, 15);
					player.arm2 = true;
					remove(secondArm);
				}

				if (!player.head && FlxG.collide(player, head)) {
					player.loadGraphic(Sources.FullPlayer, true, true, 14, 15);
					player.head = true;
					remove(head);
				}
				
				if (!currentPlatform.onScreen()) 
				{
					currentPlatform = queuePlatforms[1]; 
					
					var temp:FlxSprite = queuePlatforms[0];
					queuePlatforms.splice(0, 1);
					temp.x = randomNum(1.5, currentPlatform.x + currentPlatform.width, gapWidth);
					var randHeight:Number = randomNum(1.5, currentPlatform.y, jumpHeight);
					while (randHeight > FlxG.height || randHeight < 0)
					{
						randHeight = randomNum(1.5, currentPlatform.y, jumpHeight);
					}
					temp.y = randHeight;
					queuePlatforms.push(temp);
					
				}
				super.update()
				//death screen 
				if (FlxG.keys.COMMA)
				{
					FlxG.music.stop();
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
		
		function randomNum(interval:Number, base:Number, multiplier:int):Number
		{
			var coinFlip:int; 
			if (Math.random() > 0.8) 
			{
				coinFlip = 1; 
			} else
			{
				coinFlip = -1; 
			}
			var rand:Number = Math.random() * interval;
			return base + multiplier * rand * coinFlip ;
		}
	}
}
