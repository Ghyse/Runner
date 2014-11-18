package objects 
{
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class Player extends WorldObject 
	{
		public var onFloor:Boolean
		public var dead:Boolean
		public var velocityX:int
		public var velocityY:int
		public var jumpAmount:int
		public var shieldAmount:int
		public var energyAmount:int
		 
		
		public function Player (x,y) 
		{
			super("normal",116,150,x,y,1)
			
			this.velocityX = 10
			
			
		}
		
		public function jump():void {
			velocityY = 50	
		
			this.onFloor = false
			
		}
		
	}

}