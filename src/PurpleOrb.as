package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class PurpleOrb extends Entity 
	{
		[Embed(source = "Assets/Graphics/SpriteSheets/purple_orb_SS.png")]private const ORB:Class;
		public var orb:Spritemap = new Spritemap(ORB, 25, 25);
		public function PurpleOrb(X:int, Y:int ) 
		{
			super(X, Y);
			graphic = orb;
			orb.play();
			type = "PurpleOrb";
			setHitbox(25, 25);
			layer = 8;
		}
		
		public override function update():void
		{
			orb.frame++;
		}
		
		public function takeOrb():void
		{
			type = "";
			x = 407;
			y = 4;
			graphic.scrollX = 0;
			graphic.scrollY = 0;
		}
		
	}

}