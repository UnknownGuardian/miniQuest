package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Spike extends Entity 
	{
		public var anim:Spritemap = new Spritemap(TILES, 16, 16);
		[Embed(source = "Assets/Graphics/SpriteSheets/tiles_SS.png")]private static const TILES:Class;
		public function Spike(X:int,Y:int, frameNum:int) 
		{
			super(X, Y);
			anim.setFrame(frameNum);
			graphic = anim;
			
			type = "Spike";
			
			if(frameNum == 8)
				setHitbox(10, 8, -3, -8);
			else if(frameNum == 7)
				setHitbox(8, 10, 0, -3);
			else if(frameNum == 6)
				setHitbox(8, 10, -8, -3);
			else if(frameNum == 4)
				setHitbox(10, 8, -3, 0);
			layer = 280;
		}
		
	}

}