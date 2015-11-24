package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class YellowKey extends KeyItem 
	{
		[Embed(source = "Assets/Graphics/Items & Objects/a_yellow_key.png")]private const KEY:Class;
		public function YellowKey(X:int, Y:int) 
		{
			super(X, Y);
			graphic = new Image(KEY);
			
			type = "YellowKey";
		}
		
		
		public function takeKey():void 
		{
			x = 160;
			y = 8;
			type = "";
			graphic.scrollX = 0;
			graphic.scrollY = 0;
		}
		
	}

}