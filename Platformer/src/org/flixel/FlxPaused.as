package org.flixel 
{

	import org.flixel.*;


	public class FlxPaused extends FlxGroup
	{


	/**
	* Background rect for the text
	*/
	private var _bg:FlxSprite;

	/**
	* The text field used to display the text
	*/
	private var _field:FlxText;

	/**
	* Use this to tell if dialog is showing on the screen or not.
	*/
	public var showing:Boolean;

	internal var _displaying:Boolean;

	/**
	 * Called when dialog is finished (optional)
	 */
	private var _finishCallback:Function;


	public function FlxPaused()
	{
		
		
			_bg = new FlxSprite(20,20).makeGraphic(280, 72, 0xff808080);
			_bg.scrollFactor.x = _bg.scrollFactor.y = 0;
			add(_bg);

			_field = new FlxText(_bg.x,_bg.y+16, 300, "Paused");
			_field.setFormat(null, 12, 0xff00FFFF, "center");
			_field.scrollFactor.x = _field.scrollFactor.y = 0;
			add(_field);
			
	}

	/**
	* Call this from your code to display some dialog
	*/
	public function showPaused():void
	{
		_displaying = true;
		showing = true;
	}

	/**
	* The meat of the class. Used to display text over time as well
	* as control which page is 'active'
	*/
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

	/**
			 * Called when the dialog is completely finished
			 */
			public function set finishCallback(val:Function):void
			{
				_finishCallback = val;
			}

	}
}