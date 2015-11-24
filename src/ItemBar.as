package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class ItemBar extends Entity 
	{
		[Embed(source = "Assets/Graphics/HUD/top_bar.png")]private const BAR:Class;
		private var _image:Image;
		public function ItemBar() 
		{
			_image = new Image(BAR);
			graphic = _image;
			
			_image.scrollX = 0;
			_image.scrollY = 0;
			
			layer = 10;
			
			x = FP.halfWidth - _image.width / 2;
		}
		
	}

}