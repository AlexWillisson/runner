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
			text = new FlxText(0, FlxG.height / 2 - 40, FlxG.width, "Game Over!");
			text.size = 35;
			text.alignment = "center";
			add(text);
				
			text = new FlxText(0, FlxG.height / 2 + 30, FlxG.width, "Click to Restart");
			text.size = 20;
			text.alignment = "center";
			add(text);
		}
		override public function update():void
		{
			super.update();

			if (FlxG.mouse.justPressed()) {
				FlxG.switchState(new MenuState());
			}
		}
		
	}

}