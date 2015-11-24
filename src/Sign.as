package  
{
	import flash.text.TextField;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Sign extends Entity
	{
		[Embed(source="Assets/Graphics/Items & Objects/n_sign.png")]private const SIGN:Class;
		private var _image:Image;
		public var message:String = "";
		public function Sign(X:int,Y:int, Info:String) 
		{
			super(X, Y);
			_image = new Image(SIGN);
			graphic = _image;
			message = Info;
			setHitbox(26, 26, 5, 5);
			type = "Sign";
			layer = 270
		}
		
	}

}