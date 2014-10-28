package objects  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class Platform extends WorldObject
	{
		public const TILE_SIZE:int = 100
		/*public var type:String
		
		public var tileWidth:int
		public var tileHeight:int */
		
		public function Platform(typeObstacle:String, tileWidth:int, tileHeight:int, x:int,y:int) 
		{
			super(typeObstacle, tileWidth, tileHeight, x, y, TILE_SIZE)
			
		}
		
	}

}