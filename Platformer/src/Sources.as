package  
{
	public class Sources 
	{		
		[Embed(source = 'assets/background.png')] public static var ImgBackground:Class;
		[Embed(source = 'assets/map.png')] public static var ImgMap:Class;
		[Embed(source = 'assets/platform.png')] public static var Platform:Class;

		[Embed(source = 'assets/SpriteTorso.png')] public static var Torso:Class;
		[Embed(source = 'assets/SpriteLeg1.png')] public static var OneLeg:Class;
		[Embed(source = 'assets/SpriteLeg2.png')] public static var TwoLegs:Class;
		[Embed(source = 'assets/SpriteArm1.png')] public static var OneArm:Class;
		[Embed(source = 'assets/SpriteArm2.png')] public static var TwoArms:Class;
		[Embed(source = 'assets/SpriteHead.png')] public static var FullPlayer:Class;
		
		[Embed(source = 'assets/leg.png')] public static var Leg:Class;
		[Embed(source = 'assets/arm.png')] public static var Arm:Class;
		[Embed(source = 'assets/head.png')] public static var Head:Class;

		[Embed(source = 'assets/map.txt', mimeType = "application/octet-stream")] public static var TxtMap:Class;
		[Embed(source = 'assets/map2.txt', mimeType = "application/octet-stream")] public static var TxtMap2:Class;
		
		[Embed(source = 'assets/jumpsound.mp3')] public static var JumpSoundEffect:Class;
	}
}
