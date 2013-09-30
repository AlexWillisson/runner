package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class EndScreen extends FlxState
	{
		
		override public function create(): void
		{
			var text: FlxText;
			text = new FlxText(40, FlxG.height / 2 - 40, FlxG.width, "Game Over!");
			text.size = 35;
			text.alignment = "left";
			add(text);
				
			text = new FlxText(30, FlxG.height / 2 + 30, FlxG.width, "Press Space to Restart");
			text.size = 20;
			text.alignment = "left";
			add(text);
		}
		override public function update():void
		{
			super.update();

			if (FlxG.keys.SPACE) {
				FlxG.switchState(new MenuState());
			}
		}
		
	}

}