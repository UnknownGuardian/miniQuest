package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Sword extends Entity
	{
		[Embed(source = "Assets/Graphics/Items & Objects/g_sword_swing.png")]private const SWORD:Class;
		private var _isSwinging:Boolean = false;
		private var _facingRight:Boolean = true;
		private var _image:Image;
		public function Sword() 
		{
			_image = new Image(SWORD);
			graphic = _image;
			_image.originX = 3;
			_image.originY = 0;
			setHitbox(26, 29, 4, 19);
			_image.visible = false;
		}
		
		public function faceRight(right:Boolean):void
		{
			if (right == _facingRight) return;
			if (_isSwinging) _image.angle += 180 - _image.angle;
			_facingRight = right;
			
			if (_facingRight)
				setHitbox(26, 29, 4, 19);
			else
				setHitbox(26, 29, 22, 19);
		}
		
		public function swing():void
		{
			if (_isSwinging) return;
			_isSwinging = true;
			_image.angle = _facingRight ? 230 : 130;
			_image.visible = true;
		}
		
		public override function update():void
		{
			if (_isSwinging) _image.angle-= _facingRight?10: -10;
			else return;
			if (_image.angle < 60 || _image.angle > 300)
			{
				_isSwinging = false;
				_image.angle = _facingRight ? 230 : 130;
				_image.visible = false;
			}
			
			
			var spitter:Entity = collide("FireSpitter", x, y);
			if (spitter != null)
			{
				(spitter as FireSpitter).takeDamage(2);
			}
			
			var skull:Entity = collide("Skull", x, y);
			if (skull != null)
			{
				(skull as Skull).takeDamage(2);
			}
			
			var boss:Entity = collide("Boss", x, y);
			if (boss != null)
			{
				(boss as Boss).takeDamage(2);
			}
		}
		
	}

}