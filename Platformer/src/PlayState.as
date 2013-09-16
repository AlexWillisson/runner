package
{
	import org.flixel.*;
	import com.newgrounds.*;
	
	public class PlayState extends FlxState
	{
		private var background:FlxSprite;
		private var map:FlxTilemap;
		private var player:Player;
		private var trophy:FlxSprite;
		
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
			
			background = new FlxSprite(0, 0, Sources.ImgBackground); //CREATE BACKGROUND
			add(background); //ADDING BACKGROUND TO THE STAGE AND MAKING IT VISIBLE
			
			map = new FlxTilemap(); //CREATING MAP
			map.loadMap(new Sources.TxtMap, Sources.ImgMap, 16, 16); //LOADING MAP
			add(map); //ADDING MAP TO THE STAGE AND MAKING IT VISIBLE
			
			player = new Player(); //CREATING PLAYER
			player.x = FlxG.width / 2;
			player.y = FlxG.height - 31; //SETTING POSITION OF THE PLAYER
			add(player); //ADDING PLAYER TO THE STAGE AND MAKING HIM VISIBLE
			
			trophy = new FlxSprite(FlxG.width / 2, 16, Sources.ImgTrophy);
			add(trophy);
		}
		
		override public function update():void
		{
			FlxG.collide(player, map); //MAKE BOTH COLLIDE
			FlxG.overlap(player, trophy, gotTrophy);
			super.update();
		}
		
		private function gotTrophy(a:Player, b:FlxSprite):void
		{
			API.unlockMedal("The Trophy");
			FlxG.flash();
			FlxG.play(Sources.Mp3Powerup, 0.7);
			remove(trophy);
			trophy = null;
		}
	}
}