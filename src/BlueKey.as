package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class BlueKey extends KeyItem
	{
		[Embed(source = "Assets/Graphics/Items & Objects/b_blue_key.png")]private const KEY:Class;
		public function BlueKey(X:int, Y:int) 
		{
			super(X, Y);
			graphic = new Image(KEY);
			
			type = "BlueKey";
		}
		
		public function takeKey():void 
		{
			x = 187;
			y = 8;
			type = "";
			graphic.scrollX = 0;
			graphic.scrollY = 0;
		}
		
	}

}