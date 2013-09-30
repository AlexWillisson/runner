package  
{
	public class Sources 
	{		
		[Embed(source = 'background.png')] public static var ImgBackground:Class;
		[Embed(source = 'map.png')] public static var ImgMap:Class;

		[Embed(source = 'SpriteTorso.png')] public static var Torso:Class;
		[Embed(source = 'SpriteLeg1.png')] public static var OneLeg:Class;
		[Embed(source = 'SpriteLeg2.png')] public static var TwoLegs:Class;
		[Embed(source = 'SpriteArm1.png')] public static var OneArm:Class;
		[Embed(source = 'SpriteArm2.png')] public static var TwoArms:Class;
		[Embed(source = 'SpriteHead.png')] public static var FullPlayer:Class;
		
		[Embed(source = 'leg.png')] public static var Leg:Class;
		[Embed(source = 'arm.png')] public static var Arm:Class;
		[Embed(source = 'head.png')] public static var Head:Class;

		[Embed(source = 'map.txt', mimeType = "application/octet-stream")] public static var TxtMap:Class;
		[Embed(source = 'map2.txt', mimeType = "application/octet-stream")] public static var TxtMap2:Class;
	}
}
