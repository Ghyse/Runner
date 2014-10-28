package objects 
{
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class Obstacle extends WorldObject
	{
		public const OBST_SIZE:int = 100
		/*public var type:String
		
		public var obstWidth:int
		public var obstHeight:int*/
		
		public function Obstacle(typeObstacle:String, tileWidth:int, tileHeight:int, x:int,y:int) 
		{
			super(typeObstacle, tileWidth, tileHeight, x, y, OBST_SIZE)
			
		}
		
		public function destroy():void {
			
			
		}
		
	}

}