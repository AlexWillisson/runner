package
{
	import org.flixel.*;
	public class PlayState extends FlxState
	{
		//private var background:FlxSprite;
		private var background:FlxBackdrop
		private var map1:FlxTilemap;
		private var map2:FlxTilemap;
		private var current:FlxTilemap;
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
			
			allowHills = false;

			map1 = new FlxTilemap(); //CREATING MAP
			//map.auto = FlxTilemap.AUTO;
			map1.loadMap(new Sources.TxtMap, Sources.ImgMap, 16, 16); //LOADING MAP
			add(map1); //ADDING MAP TO THE STAGE AND MAKING IT VISIBLE
			
			map2 = new FlxTilemap();
			map2.loadMap(new Sources.TxtMap2, Sources.ImgMap, 16, 16);

			var idx:int;

			for (idx = 0; idx < 40; idx++) {
				map1.setTile (idx, groundIdx, (idx % 4) + 1);
			}

			for (idx = 0; idx < 40; idx++) {
				map2.setTile (idx, groundIdx, (idx % 4) + 1);
			}

			map1.setTile(21, groundIdx, 5);
			map2.setTile(21, groundIdx, 5);
			map2.setTile(4, groundIdx, 5);

			map1.setTile(36, groundIdx, 5);
			map2.setTile(36, groundIdx, 5);

			map1.setTile(19, groundIdx, 5);
			map2.setTile(19, groundIdx, 5);

			// map2.setTile(10, groundIdx, 0);
			// map2.setTile(11, groundIdx, 0);

			tileX = 5;
			current = map1;

			startX = 50;

			player = new Player(Sources.Torso); //CREATING PLAYER
			player.x = startX;
			// player.y = FlxG.height - 31; //SETTING POSITION OF THE PLAYER
			player.y = FlxG.height - 15;
			add(player); //ADDING PLAYER TO THE STAGE AND MAKING HIM VISIBLE
			FlxG.camera.follow(player.camTar)
			
			firstLeg = new Limb(Sources.Leg);
			firstLeg.x = 70;
			firstLeg.y = FlxG.height - 31;
			add(firstLeg);

			secondLeg = new Limb(Sources.Leg);
			secondLeg.x = 90;
			secondLeg.y = FlxG.height - 31;
			add(secondLeg);

			firstArm = new Limb(Sources.Arm);
			firstArm.x = 110
			firstArm.y = FlxG.height - 31;
			add(firstArm);

			secondArm = new Limb(Sources.Arm);
			secondArm.x = 130;
			secondArm.y = FlxG.height - 31;
			add(secondArm);

			head = new Limb(Sources.Head);
			head.x = 150;
			head.y = FlxG.height - 31;
			add(head);

			timerText = new FlxText(0, 0, 100, " ");
			timerText.size = 16;
			add(timerText); 
			timerText.scrollFactor.x = 0;
			timerText.scrollFactor.y = 0;
			
			paused = new Paused;	//adding pause functionality
			super.create();

		}
		
		override public function update():void
		{
			
			if (!paused.showing)
			{
				background.draw();
				timerNum += FlxG.elapsed;
				FlxG.timer = timerNum;
				timerText.text = "" + FlxU.floor(timerNum);
				
				if (player.x > 640) {
					player.x = startX;

					if (current == map1) {
						remove(map1);
						add(map2);
						current = map2
					}

					current.setTile(tileX, groundIdx - 1, 0);
					tileX++;
					// current.setTile(tileX, groundIdx - 1, 5);
				}

				FlxG.collide(player, current);
				FlxG.collide(firstLeg, current);
				FlxG.collide(secondLeg, current);
				FlxG.collide(firstArm, current);
				FlxG.collide(secondArm, current);
				FlxG.collide(head, current);

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

				// FlxG.camera.x = player.x
				super.update()

				if (FlxG.keys.COMMA)
				{
					FlxG.switchState(new EndScreen());
				}
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
	}
}
