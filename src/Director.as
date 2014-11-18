package  
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author ...
	 * va a avisar cuando se cargo
	 * 1- la funcion goTo va a recibir un String
	 * 2- carga la seccion, mientras carga llama ala funcion cortina, la cual va a mostrar el loading. 
	 * 3- una vez cargado pone en pantalla la seccion y remueve la que se estaba mostrando en pantalla.
	 * 
	 */
	public class Director extends EventDispatcher
	{

		
		public function Director() 
		{
			
		}
		
		
		public static function goTo(seccion:String):Sprite {
			
			var object:Sprite
			switch (seccion) 
			{
				case "menu":
					var menu:Menu = new Menu()	
					menu.addEventListener(Menu.MENU_CARGADO, ready)
					object = menu
				break;
			
				case "game":
					var game:Game = new Game()
					game.addEventListener(Game.GAME_CARGADO, ready)
					object  = game
				
				break;
				
				
				
			}
			
			return object
			
			
		}
		
		static private function ready(e:Event):void 
		{
			
		}
		
	
	}

}