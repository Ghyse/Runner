package objects.buff 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import objects.Player;
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class SpeedBoost extends Powerup
	{
		private var tiempo:Timer
		private var _player:Player
		
		public function SpeedBoost(x:int, y:int) 
		{
			super("speed", x, y)
			tiempo = new Timer(5000,1) // delay: cada cuanto / repeatcount: 
			//1000 milseg = 1 seg
			//MIL MILimetros en un metro
			
			tiempo.addEventListener(TimerEvent.TIMER_COMPLETE, finished)
		}
		
		override public function apply(player:Player):void {
			super.apply(player)
			_player = player
			tiempo.start()
			player.velocityX += 20;
			
			
		}
		
		
		private function finished(e:Event):void 
		{
			_player.velocityX -= 20;
		}
		
	}

}