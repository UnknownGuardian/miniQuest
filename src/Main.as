package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;

	/**
	 * ...
	 * @author UnknownGuardian
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine
	{

		public function Main():void 
		{
			super(640, 480, 60, false);
		}
		override public function init():void 
		{
			trace("FlashPunk has started successfully!");	
			FP.world = new MainMenu();
			FP.console.enable();
			
		}
	}

}