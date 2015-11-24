package  
{
	import flash.display.BitmapData;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Level extends Entity
	{
		[Embed(source = "ogmo/Master.oel", mimeType = "application/octet-stream")]private static const DEFAULT_MAP:Class;
		[Embed(source = "Assets/Graphics/SpriteSheets/tiles_SS.png")]private static const TILESHEET:Class;
		private var _levelData:XML;
		private static const SOLIDS:Array = [0, 2, 3, 5];
		public var _tiles:Tilemap;
		public var _grid:Grid;
		public function Level() 
		{
			_tiles = new Tilemap(TILESHEET, 3000, 3000, 16, 16);
			graphic = _tiles;
			layer = 400;
			
			_grid = new Grid(3000, 3000, 16, 16, 0, 0);
			mask = _grid;
			
			type = 'level';
			
			
		}
		
		public override function added():void
		{
			super.added();
			
			loadLevel(DEFAULT_MAP);
			
			
			
			/*var bmd:BitmapData = new BitmapData(640, 480, true,0x00FFFFFF);
			_tiles.render(bmd, new Point(0, 0), new Point(FP.camera.x, FP.camera.y));
			bmd.applyFilter(bmd, new Rectangle(0, 0, 640, 480), new Point(0, 0), new DropShadowFilter(9,135,0,.35,0,0)); //multiply if possible
			graphic = new Image(bmd);*/
		}
		
		private function loadLevel(xml:Class):void 
		{
			var rawData:ByteArray = new xml();
			var dataString:String = rawData.readUTFBytes(rawData.length);
			_levelData = new XML(dataString);
			var dataList:XMLList;
			var dataElement:XML;
			
			dataList = _levelData.Solids.tile;
			
			/*
			 * All solid tiles
			 */
			for each(dataElement in dataList)
			{
				_tiles.setTile(int(dataElement.@x), int(dataElement.@y), int(dataElement.@tx) );
				_grid.setTile(int(dataElement.@x), int(dataElement.@y), SOLIDS.indexOf(int(dataElement.@tx)) != -1);
			}
			
			
			
			/*
			 * All spikes
			 */
			dataList = _levelData.Spikes.tile;
			
			for each(dataElement in dataList)
			{
				var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				world.add(spike);
			}
			
			/*
			 * All Signs
			 */
			dataList = _levelData.Objects.Sign;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var sign:Sign = new Sign(int(dataElement.@x), int(dataElement.@y), dataElement.@Message);
				world.add(sign);
			}
			
			/*
			 * All Books
			 */
			dataList = _levelData.Objects.Book;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var book:Book = new Book(int(dataElement.@x), int(dataElement.@y));
				world.add(book);
			}
			
			/*
			 * All Ladders
			 */
			dataList = _levelData.Objects.Ladder;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var ladder:Ladder = new Ladder(int(dataElement.@x), int(dataElement.@y));
				world.add(ladder);
			}
			
			/*
			 * All Fire Spitters
			 */
			dataList = _levelData.Objects.FireSpitter;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var fireSpitter:FireSpitter = new FireSpitter(int(dataElement.@x), int(dataElement.@y), dataElement.@facingRight == "True");
				world.add(fireSpitter);
			}
			
			/*
			 * All Water
			 */
			dataList = _levelData.Water.tile;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var water:Water = new Water(int(dataElement.@x)*16, int(dataElement.@y)*16);
				world.add(water);
			}
			/*
			 * All Lava
			 */
			dataList = _levelData.Lava.tile;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var lava:Lava = new Lava(int(dataElement.@x)*16, int(dataElement.@y)*16);
				world.add(lava);
			}
			
			/*
			 * All Purple Orbs
			 */
			dataList = _levelData.Objects.PurpleOrb;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var purpleOrb:PurpleOrb = new PurpleOrb(int(dataElement.@x), int(dataElement.@y));
				world.add(purpleOrb);
			}
			
			/*
			 * All Yellow Orbs
			 */
			dataList = _levelData.Objects.YellowOrb;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var yellowOrb:YellowOrb = new YellowOrb(int(dataElement.@x), int(dataElement.@y));
				world.add(yellowOrb);
			}
			
			/*
			 * All Green Orbs
			 */
			dataList = _levelData.Objects.GreenOrb;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var greenOrb:GreenOrb = new GreenOrb(int(dataElement.@x), int(dataElement.@y));
				world.add(greenOrb);
			}
			
			/*
			 * All Yellow Locks
			 */
			dataList = _levelData.Objects.YellowLock;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var yellowLock:YellowLock = new YellowLock(int(dataElement.@x), int(dataElement.@y));
				world.add(yellowLock);
			}
			
			/*
			 * All Blue Locks
			 */
			dataList = _levelData.Objects.BlueLock;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var blueLock:BlueLock = new BlueLock(int(dataElement.@x), int(dataElement.@y));
				world.add(blueLock);
			}
			
			/*
			 * All Red Locks
			 */
			dataList = _levelData.Objects.RedLock;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var redLock:RedLock = new RedLock(int(dataElement.@x), int(dataElement.@y));
				world.add(redLock);
			}
			
			/*
			 * All Red Keys
			 */
			dataList = _levelData.Objects.RedKey;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var redKey:RedKey = new RedKey(int(dataElement.@x), int(dataElement.@y));
				world.add(redKey);
			}
			/*
			 * All Yellow Keys
			 */
			dataList = _levelData.Objects.YellowKey;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var yellowKey:YellowKey = new YellowKey(int(dataElement.@x), int(dataElement.@y));
				world.add(yellowKey);
			}
			/*
			 * All Blue Keys
			 */
			dataList = _levelData.Objects.BlueKey;
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				//var spike:Spike = new Spike(int(dataElement.@x) * 16, int(dataElement.@y) * 16, int(dataElement.@tx));
				var blueKey:BlueKey = new BlueKey(int(dataElement.@x), int(dataElement.@y));
				world.add(blueKey);
			}
			
			/*
			 * All Skulls
			 */
			dataList = _levelData.Objects.Skull
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				var skull:Skull = new Skull(int(dataElement.@x), int(dataElement.@y));
				world.add(skull);
			}
			
			/*
			 * All Boss
			 */
			dataList = _levelData.Objects.Boss
			//trace(dataList.toXMLString());
			for each(dataElement in dataList)
			{
				var boss:Boss = new Boss(int(dataElement.@x), int(dataElement.@y));
				world.add(boss);
			}
		}
		
		public function getPlayerLocation():Point
		{
			return new Point(int(_levelData.Objects.Player.@x), int(_levelData.Objects.Player.@y));
		}
	}

}