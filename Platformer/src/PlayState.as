package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		//private var background:FlxSprite;
		private var background:FlxBackdrop
		private var map1:FlxTilemap;
		private var player:Player;
		private var trophy:FlxSprite;
		private var map2:FlxTilemap;
		
		public function PlayState():void
		{
		
		}
		
		override public function create():void
		{
			//STARTING THE GAME...
			FlxG.flash(0);
			FlxG.playMusic(Sources.Mp3Soundtrack, 0.7);
			FlxG.music.fadeIn(3);
			FlxG.framerate = 60;
			FlxG.flashFramerate = 60;
			
			//background = new FlxSprite(0, 0, Sources.ImgBackground); //CREATE BACKGROUND
			background = new FlxBackdrop(Sources.ImgBackground, 0.8, 0.6, true, true); //endless background
			add(background); //ADDING BACKGROUND TO THE STAGE AND MAKING IT VISIBLE
			
			map1 = new FlxTilemap(); //CREATING MAP
			//map.auto = FlxTilemap.AUTO;
			map1.loadMap(new Sources.TxtMap, Sources.ImgMap, 16, 16); //LOADING MAP
			add(map1); //ADDING MAP TO THE STAGE AND MAKING IT VISIBLE
			map1.x = 0
			
			map2 = new FlxTilemap();
			map2.loadMap(new Sources.TxtMap, Sources.ImgMap, 16, 16);
			map2.x = 12
			
			player = new Player(); //CREATING PLAYER
			player.x = FlxG.width / 2;
			player.y = FlxG.height - 31; //SETTING POSITION OF THE PLAYER
			add(player); //ADDING PLAYER TO THE STAGE AND MAKING HIM VISIBLE

			super.create();

		}
		var i:uint = 2;
		override public function update():void
		{
			FlxG.camera.scroll.x += 1;
			player.x += 1;
			//map1.setTile(i++, 13, 1);
			FlxG.collide(player, map1); //MAKE BOTH COLLIDE
			FlxG.collide(player, map2);
			super.update();
		}
		
	}
}