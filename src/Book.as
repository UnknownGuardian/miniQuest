package  
{
	import flash.display.BitmapData;
	import flash.text.TextField;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Book extends Entity
	{
		[Embed(source = "Assets/Graphics/Items & Objects/book_closed.png")]private const BOOK_CLOSED:Class;
		[Embed(source="Assets/Graphics/Items & Objects/book_open.png")]private const BOOK_OPEN:Class;
		private var _imageClosed:Image;
		private var _imageOpen:Image;
		public function Book(X:int,Y:int) 
		{
			super(X, Y);
			//_image = new Image(new BitmapData(27, 15, false, 0x0000FF));
			_imageClosed = new Image(BOOK_CLOSED);
			_imageOpen = new Image(BOOK_OPEN);
			_imageClosed.x = 0;
			graphic = _imageClosed;
			setHitbox(27, 15, 5, 5);
			type = "Book";
			layer = 260;
		}
		
		public function openBook():void
		{
			graphic = _imageOpen;
		}
		public function closeBook():void
		{
			graphic = _imageClosed;
		}
		public function isOpen():Boolean
		{
			return graphic == _imageOpen;
		}
		
	}

}