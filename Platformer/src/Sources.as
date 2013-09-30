package  
{
	public class Sources 
	{		
		[Embed(source = 'background.png')] public static var ImgBackground:Class;
		[Embed(source = 'map.png')] public static var ImgMap:Class;
		[Embed(source = 'platform.png')] public static var Platform:Class;

		[Embed(source = 'SpriteTorso.png')] public static var Torso:Class;
		[Embed(source = 'SpriteLeg1.png')] public static var OneLeg:Class;
		
		[Embed(source = 'legplaceholder.png')] public static var Leg:Class;

		[Embed(source = 'map.txt', mimeType = "application/octet-stream")] public static var TxtMap:Class;
		[Embed(source = 'map2.txt', mimeType = "application/octet-stream")] public static var TxtMap2:Class;
	}
}
