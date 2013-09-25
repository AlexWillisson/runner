package
{

	import org.flixel.*;


	public class Paused extends FlxGroup
	{
		private var _bg:FlxSprite;
		private var _field:FlxText;
		private var _unpause:FlxText;
		public var showing:Boolean;

		internal var _displaying:Boolean;

		private var _finishCallback:Function;

		public function Paused()
		{
			_bg = new FlxSprite(20,20).makeGraphic(280, 72, 0xff808080);
			_bg.scrollFactor.x = _bg.scrollFactor.y = 0;
			add(_bg);

			_field = new FlxText(_bg.x,_bg.y+16, 300, "Paused");
			_field.setFormat(null, 12, 0xff00FFFF, "center");
			_field.scrollFactor.x = _field.scrollFactor.y = 0;
			add(_field);
			
			_unpause = new FlxText(_bg.x,_bg.y+32, 300,
				"Press space to unpause");
			_unpause.setFormat(null, 10, 0xff00FFFF, "center");
			_unpause.scrollFactor.x = _unpause.scrollFactor.y = 0;
			add(_unpause);
		}

		public function showPaused():void
		{
			_displaying = true;
			showing = true;
		}

		override public function update():void
		{
			if (_displaying)
			{
				{
					_field.text = "Paused";
				}
				if(FlxG.keys.SPACE)
				{
					this.kill();
					this.exists = false;
					showing = false;
					_displaying = false;
					if (_finishCallback != null) _finishCallback();
					
				}
				else
				{
					
					showing = true;
					_displaying = true;
					
				}
				
				super.update();
			}
		}

		public function set finishCallback(val:Function):void
		{
			_finishCallback = val;
		}

	}
}