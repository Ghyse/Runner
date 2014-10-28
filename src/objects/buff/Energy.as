package objects.buff 
{
	import objects.Player;
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class Energy extends Powerup
	{
		
		public function Energy(x:int,y:int) 
		{
			super("e",x,y)
		
			
		}
		
		override public function apply(player:Player):void 
		{
			super.apply(player);
			player.energyAmount += 1
			
			if (player.energyAmount == 50) {
				
			
			}
			
			trace ("AGARRASTE UN POWERUP")
		}	
		
		
		
	}

}