package
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		override public function create(): void
		{
			var t: FlxText;
			t = new FlxText(0, FlxG.height/2-40, FlxG.width, "Body Runner");
			t.size = 32;
			t.alignment = "center";
			add(t);
			t = new FlxText(0, FlxG.height/2, FlxG.width, "click to start")

			t.size = 16;
			t.alignment = "center";
			add(t);

			FlxG.mouse.show();
		}

		override public function update():void
		{
			super.update();

			if (FlxG.mouse.justPressed()) {
				FlxG.switchState(new PlayState());
			}
		}
	}
}
