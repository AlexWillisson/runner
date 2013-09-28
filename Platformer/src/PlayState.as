package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		//private var background:FlxSprite;
		private var background:FlxBackdrop
		private var map1:FlxTilemap;
		private var player:Player;
		private var firstleg:Limb;
		public var paused:Paused;
		private var i:uint = 0;
		private var j:uint = 0;
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
			map1.x = 0
			
			player = new Player(Sources.Torso); //CREATING PLAYER
			player.x = 35;
			player.y = FlxG.height - 31; //SETTING POSITION OF THE PLAYER
			add(player); //ADDING PLAYER TO THE STAGE AND MAKING HIM VISIBLE
			FlxG.camera.follow(player);
			
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
				if (player.x > 304) {
					player.x -= 300;
					map1.setTile(5, 13, i % 2);
					map1.setTile(5, 12, i / 3);
					i = (i + 1) % 4;
					map1.setTile(13, 13, j / 2);
					map1.setTile(14, 12, i%2);
					j = (j + 1) % 3;
				}
				
				FlxG.collide(player, map1);
				FlxG.collide(firstleg, map1);

				if (FlxG.collide(player, firstleg)) {
					player.loadGraphic(Sources.OneLeg, true, true, 14, 15);
					player.leg1 = true;
					allowHills = true;
					remove(firstleg);
				}

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
