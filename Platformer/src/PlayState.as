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
		private var firstleg:Limb;
		private var tileX:int;
		private var startX:int;
		private var groundIdx:int = 14;
		public var paused:Paused;
		public var allowHills:Boolean;
		
		public function PlayState():void
		{
			
		}
		
		override public function create():void
		{
			//STARTING THE GAME...
			FlxG.flash(0);
			FlxG.framerate = 60;
			FlxG.flashFramerate = 60;
			
			background = new FlxBackdrop(Sources.ImgBackground, 0.8, 0.6, true, true); //endless background
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
				map1.setTile (idx, groundIdx, 1);
			}

			for (idx = 0; idx < 40; idx++) {
				map2.setTile (idx, groundIdx, 1);
			}

			map1.setTile(21, groundIdx, 2);
			map2.setTile(21, groundIdx, 2);
			map2.setTile(4, groundIdx, 2);

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
			
			firstleg = new Limb(Sources.Leg);
			firstleg.x = FlxG.width - 50;
			firstleg.y = FlxG.height - 31;
			add(firstleg);

			paused = new Paused;	//adding pause functionality
			super.create();

		}

		override public function update():void
		{
			if (!paused.showing)
			{
				if (player.x > 320) {
					player.x = startX;

					if (current == map1) {
						remove(map1);
						add(map2);
						current = map2
					}

					current.setTile(tileX, groundIdx - 1, 0);
					tileX++;
					// current.setTile(tileX, groundIdx - 1, 2);
				}

				FlxG.collide(player, current);
				FlxG.collide(firstleg, current);

				if (FlxG.collide(player, firstleg)) {
					player.loadGraphic(Sources.OneLeg, true, true, 14, 15);
					player.leg1 = true;
					allowHills = true;
					remove(firstleg);
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
