package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	
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
			Director.stage = this.stage
			Director.goTo("menu")
			
			//game = new Game ()
			//addChild(game)
			//addChild(menu)
		 var url:URLLoader	
		}
		
	
		
		/*private function mostrar(e:Event):void 
		{
			stage.addChild(menu)
			trace (menu.cargado)
		}*/
		
	
	}
	
}