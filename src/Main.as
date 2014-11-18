package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * chau!
	 * ...
	 * @author Giselle Higa
	 */
	public class Main extends Sprite 
	{
		private var game:Game;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.addChild(Director.goTo("menu"))
			
			//game = new Game ()
			//addChild(game)
			//addChild(menu)
			
		}
		
	
		
		/*private function mostrar(e:Event):void 
		{
			stage.addChild(menu)
			trace (menu.cargado)
		}*/
		
	
	}
	
}