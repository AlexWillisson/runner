package  
{
	public class Sources 
	{		
		//IMPORTING GRAPHICS (.PNG)
		[Embed(source = 'org/flixel/data/private/graphics/background.png')] public static var ImgBackground:Class;
		[Embed(source = 'org/flixel/data/private/graphics/map.png')] public static var ImgMap:Class;
		[Embed(source = 'org/flixel/data/private/graphics/player.png')] public static var ImgPlayer:Class;
		[Embed(source = 'org/flixel/data/private/graphics/trophy.png')] public static var ImgTrophy:Class;
		
		//IMPORTING SOUNDS AND MUSIC (.MP3)
		[Embed(source = 'org/flixel/data/private/sounds/soundtrack.mp3')] public static var Mp3Soundtrack:Class;
		[Embed(source = 'org/flixel/data/private/sounds/jump.mp3')] public static var Mp3Jump:Class;
		[Embed(source = 'org/flixel/data/private/sounds/powerup.mp3')] public static var Mp3Powerup:Class;
		
		//IMPORTING TEXTS (.TXT)
		[Embed(source = 'org/flixel/data/private/texts/map.txt', mimeType = "application/octet-stream")] public static var TxtMap:Class;
	}
}