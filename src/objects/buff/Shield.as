package objects.buff
{
	import objects.Player;
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class Shield extends Powerup
	{
		
		public function Shield(x:int, y:int) 
		{
			super("shield",x,y)
		}
		
		override public function apply(player:Player):void 
		{
			super.apply(player);
			player.shieldAmount = 1
			
			trace ("AGARRASTE UN POWERUP")
		}	
		
	}
	

}