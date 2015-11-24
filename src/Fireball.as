package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Fireball extends Entity 
	{
		[Embed(source = "Assets/Graphics/Enemies/fireball.png")]private const FIREBALL:Class;
		private var _xSpeed:int = 0;
		private var _image:Image;
		public function Fireball(X:int,Y:int, Velocity:int) 
		{
			super(X+4, Y + 6);
			_image = new Image(FIREBALL);
			graphic = _image;
			_xSpeed = Velocity;
			
			setHitbox(8, 8, 0, 0);
			
			type = "Fireball";
		}
		
		public override function update():void
		{
			x += _xSpeed;
			if (collide("level", x, y))
			{
				world.remove(this);
			}
		}
		
	}

}