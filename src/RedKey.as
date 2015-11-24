package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class RedKey extends KeyItem
	{
		[Embed(source = "Assets/Graphics/Items & Objects/c_red_key.png")]private const KEY:Class;
		public function RedKey(X:int, Y:int) 
		{
			super(X, Y);
			graphic = new Image(KEY);
			
			type = "RedKey";
		}
		
		public function takeKey():void 
		{
			x = 212;
			y = 8;
			type = "";
			graphic.scrollX = 0;
			graphic.scrollY = 0;
		}
		
	}

}