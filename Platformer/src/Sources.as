package  
{
	public class Sources 
	{		
		//IMPORTING GRAPHICS (.PNG)
		[Embed(source = 'org/flixel/data/private/graphics/background.png')] public static var ImgBackground:Class;
		[Embed(source = 'org/flixel/data/private/graphics/map.png')] public static var ImgMap:Class;
		[Embed(source = 'SpriteTorso.png')] public static var Torso:Class;
		[Embed(source = 'SpriteLeg1.png')] public static var OneLeg:Class;
		[Embed(source = 'org/flixel/data/private/graphics/trophy.png')] public static var ImgTrophy:Class;
		
		//IMPORTING TEXTS (.TXT)
		[Embed(source = 'org/flixel/data/private/texts/map.txt', mimeType = "application/octet-stream")] public static var TxtMap:Class;
	}
}