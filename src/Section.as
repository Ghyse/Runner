package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class Section extends Sprite implements Cargador
	{
		
		public function Section() 
		{
			
		}
		
		
		
		public function destroy():void {
			
		}
		
		/* INTERFACE Cargador */
		
		public function beginLoad():void 
		{
			
		}
		
		public function get loadComplete():Boolean 
		{
			return true
		}
		
	}

}