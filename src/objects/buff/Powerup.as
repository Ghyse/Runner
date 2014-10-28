package objects.buff 
{
	import objects.Player;
	import objects.WorldObject;
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class Powerup extends WorldObject
	{
		private const SIZE_POWER = 260
		
		
		public function Powerup(typeObstacle:String, x:int,y:int) 
		{
			super(typeObstacle, 1 , 1, x, y, SIZE_POWER)
			
			
		}
		
		public function apply (player:Player):void {
			
		}
		
		
	}
	

}