package objects 
{
	import flash.geom.Rectangle;
	import objects.buff.Powerup;
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class World 
	{
	
		public var player1:Player
		
		public static const FINALIZO:String = "finalizo"
		private var _gravedad:int;
		private var _anchoLv:int;
		public var _listaElements:Array;
		
		public function World( gravedad:int, anchoLv:int) 
		{
		
			_listaElements = new Array()
			
			_anchoLv = anchoLv
			_gravedad = gravedad
			
			player1 = new Player(0, 500)
				
			
			
			
		}
		
		public function update():void {
			player1.x += player1.velocityX
			player1.y += player1.velocityY
		
			
			if (player1.y > 0)
			{
				player1.velocityY -= _gravedad
			}
			
			if (player1.y <= 0)
			{
				player1.velocityY = 0
				player1.y = 0
				player1.onFloor = true
				
			}
			
			for each (var item:WorldObject in _listaElements) {
				if (item is Powerup) {
					if (player1.intersects(item)){
						Powerup(item).apply(player1)
						trace (player1.shieldAmount)
						removeWorldObject(item)
						continue
					}
				}
				
				
				if (item is Obstacle) {
					
					if (player1.intersects(item)){
						if ( player1.shieldAmount <= 0){
							player1.dead = true
							trace (player1.velocityX)
							trace("Game Over, Collision at: " + player1.x)
						
						} else {
							player1.shieldAmount -= 1
							removeWorldObject(item);
							continue
						}
					}
				}

				
				if (item is Platform) {
				// punto (char.y) el eje se toma desde el abajo (coordenadas del mundo/modelo)
					if (player1.intersects(item))
					{
					
						var colision:Rectangle = player1.intersection(item)
					
					// checkear top
						if (colision.y > item.y && colision.y + colision.height == item.y + item.height && colision.x > item.x && colision.x < item.x + item.width && player1.velocityY < 0 && player1.y >= item.y)
						{
							player1.y = (item.y + item.height) - 1
							player1.velocityY = 0
							player1.y = player1.y - 25
							player1.onFloor = true
						}
					
					// chekear bot
						if (colision.y == item.y && colision.y + colision.height < item.y + item.height && colision.y < item.x + item.width && colision.x > item.x && player1.velocityY && player1.y < item.y)
						{
							player1.y = (item.y - player1.height)
							player1.velocityY -= _gravedad
							player1.y += 25
						}
					
					// chekear laterl izquierdo
						if (colision.x == item.x && colision.x + colision.width < item.x + item.height && player1.y < item.height)
						{
							player1.x = item.x - player1.width
						}
					}
					
				}
				
				
			
			}
			
			
			
		}
		
		public function get isFinish(): Boolean {
			return (player1.x >= _anchoLv)
		}
		
		public function get isDead():Boolean {
			return (player1.dead)
		}
		
		public function removeWorldObject (object:WorldObject):void {
			for (var i:int = 0; i < _listaElements.length; i++) {
				if (_listaElements[i] ==  object) {
					_listaElements.splice(i, 1) // removiendo elemento de la lista
					//delete listaElementosView[object] 
					break;
				}
			}
		}
		
		public function addWorldObeject (object:WorldObject):void {
			_listaElements.push(object);
		}
		
	}

}