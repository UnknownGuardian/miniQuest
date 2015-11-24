package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Player extends Entity 
	{
		[Embed(source = "Assets/Graphics/Characters/main_21x22.png")]private static const ANIM:Class;
		public var anim:Spritemap = new Spritemap(ANIM, 21, 22);
		
		private var _v:Point;
		private static const GRAVITY:Number = .70;
		private static const FRICTION:Number = .80;
		
		private const maxXSpeed:Number = 7.2;
		private var numJumpsLeft:Number = 0;
		
		private var _bootsEquipped:Boolean = false;
		
		private var lastSavedLoc:Point = new Point();
		
		private var _sword:Sword;
		public function Player(p:Point) 
		{
			anim.setFrame(1);
			x = p.x;
			y = p.y;
			_v = new Point();
			lastSavedLoc = p.clone();
			//graphic = anim;
			graphic = new Image(new BitmapData(16,16,false,0x00FF00));
			setHitbox(16, 16, 0, 0);
			type = "player";
			
			layer = 201;
			
			_sword = new Sword();
		}
		override public function added():void
		{
			super.added();
			world.add(_sword);
		}
		
		override public function update():void
		{
			updateMovement();
			updateCollision();
			updateSword();
			super.update();
		}
		
		private function updateMovement():void
		{
			if ((Input.pressed(Key.Z)) && numJumpsLeft > 0)
			{
				_v.y = -8;
				numJumpsLeft--;
			}
			else if (_v.y > 16) _v.y = 16;
			if (Input.check(Key.DOWN) || Input.check(Key.S)) _v.y = .2;
			if (Input.check(Key.LEFT) || Input.check(Key.A))
			{
				_v.x += -.5;
			}
			else if (Input.check(Key.RIGHT) || Input.check(Key.D))
			{
				_v.x += .5;
			}
		}
		
		private function updateCollision():void
		{
			var spike:Entity = collide("Spike", x, y);
			if (spike != null)
			{
				var tomb:Tomb = new Tomb(this, spike);
				world.add(tomb);
				respawn();
				return;
			}
			
			var fireball:Entity = collide("Fireball", x, y);
			if (fireball != null)
			{
				var tomb2:Tomb = new Tomb(this, fireball);
				world.add(tomb2);
				world.remove(fireball);
				respawn();
				return;
			}
			
			var bossSpike:Entity = collide("BossSpike", x, y);
			if (bossSpike != null)
			{
				var tomb3:Tomb = new Tomb(this, bossSpike);
				world.add(tomb3);
				world.remove(bossSpike);
				respawn();
				return;
			}
			
			var sign:Entity = collide("Sign", x, y);
			if (sign != null)
			{
				//trace("collided");
				(world as MainMenu).getMessageBox().showMessage((sign as Sign).message);
			}
			
			var book:Entity = collide("Book", x, y);
			if (book != null)
			{
				lastSavedLoc.x = book.x;
				lastSavedLoc.y = book.y;
				
				var books:Vector.<Book> = new Vector.<Book>();
				world.getType("Book", books);
				for (var i:int = 0; i < books.length; i++)
				{
					if (books[i].isOpen() && books[i] != book) books[i].closeBook();
				}
				
				if (!(book as Book).isOpen())
				{
					(world as MainMenu).getMessageBox().showMessage("Spawn Point Saved!");
					(book as Book).openBook();
				}
			}
			
			var orb:Entity = collide("PurpleOrb", x, y);
			if (orb != null)
			{
				(orb as PurpleOrb).takeOrb();
				(world as MainMenu).getMessageBox().showMessage("Power echos inside...");	
			}
			orb = collide("YellowOrb", x, y);
			if (orb != null)
			{
				(orb as YellowOrb).takeOrb();
				(world as MainMenu).getMessageBox().showMessage("Power echos inside...");
			}
			orb = collide("GreenOrb", x, y);
			if (orb != null)
			{
				(orb as YellowOrb).takeOrb();
				(world as MainMenu).getMessageBox().showMessage("Power echos inside...");
			}
			
			var key:Entity = collide("BlueKey", x, y);
			if (key != null)
			{
				(key as BlueKey).takeKey();
			}
			key = collide("RedKey", x, y);
			if (key != null)
			{
				(key as RedKey).takeKey();
			}
			key = collide("YellowKey", x, y);
			if (key != null)
			{
				(key as YellowKey).takeKey();
			}
			
			
			if (_v.x > maxXSpeed) _v.x = maxXSpeed;
			else if (_v.x < -maxXSpeed) _v.x = -maxXSpeed;
			if (collide("Water", x, y))
			{
				_v.x *= .9;
				_v.y *= .95;
			}
			if (collide("Lava", x, y))
			{
				if (_bootsEquipped)
				{
					_v.x *= .98;
					_v.y *= .99;
				}
				else
				{
					respawn();
					return;
				}
			}
			_v.x *= FRICTION;
			x += _v.x;
			
			if (collide("level", x, y) || collide("FireSpitter",x,y))
			{
				//Handle Collision here.
				if (FP.sign(_v.x) > 0)
				{
					//moving to the right
					_v.x = 0;
					x = Math.floor(x / 16) * 16 + 16 - width;
				}
				else
				{
					_v.x = 0;
					x = Math.floor(x/16) * 16 + 16
				}
			}
			//else//  x = int(x);
			
			
			
			
			
			
			
			
			
			
			if (collide("Ladder", x, y))
			{
				if (Input.check(Key.W) || Input.check(Key.UP))
				{
					_v.y = -2;
				}
				else if (Input.check(Key.S) || Input.check(Key.DOWN))
				{
					_v.y = 2;
				}
				else
				{
					_v.y =0
				}
			}
			else //not touching a ladder
			{
				_v.y += GRAVITY;
			}
			y += _v.y;
			if (collide("level", x, y) || collide("FireSpitter",x,y))
			{
				//Handle Collision here.
				if (FP.sign(_v.y) > 0)
				{
					//moving to the ground
					y = Math.floor((y) / 16) * 16 + 16 - height;
					_v.y = 0;
					numJumpsLeft = 2;
				}
				else
				{
					//moving to the ceiling
					y = Math.floor((y) / 16) * 16 + 16
					_v.y = 0;
				}
			}
			//if (Input.check(Key.SPACE))
			{
				FP.camera.x = int(FP.lerp(FP.camera.x, x - 320, 0.2));
				FP.camera.y = int(FP.lerp(FP.camera.y, y - 240, 0.2));
			}
		}
		
		
		
		private function updateSword():void 
		{
			_sword.x = x + 8;
			_sword.y = y + 8;
			if (_v.x < 0 ) _sword.faceRight(false);
			else if (_v.x > 0 )_sword.faceRight(true);
			
			if (Input.check(Key.X))
			{
				_sword.swing();
			}
			
			
		}
		
		public function respawn():void
		{
			x = lastSavedLoc.x;
			y = lastSavedLoc.y;
			_v.x = 0;
			_v.y = 0;
		}
		
	}

}