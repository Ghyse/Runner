package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import views.BitmapLoader;
	/**
	 * ...
	 * @author qtie
	 */
	public class PopUp extends Sprite implements Cargador
	{
		
		
		public function PopUp() 
		{
	
		}
		
		public function destroy ():void {
			
			
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