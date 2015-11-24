package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class BossSpike extends Entity
	{
		[Embed(source = "Assets/Graphics/Tiles/spike_bot.png")]private const SPIKE:Class;
		private var _ySpeed:int = 0;
		private var _image:Image;
		public function BossSpike(X:int,Y:int, Velocity:int) 
		{
			super(X, Y);
			_ySpeed = Velocity;
			_image = new Image(SPIKE);
			graphic = _image;
			setHitbox(10, 8, -3, 0);
			type = "BossSpike";
			layer = 301
		}
		
		
		
		public override function update():void
		{
			if (collide("level", x, y))
			{
				world.remove(this);
				return;
			}
			y += _ySpeed;
		}
		
	}

}