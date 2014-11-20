package  


{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
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
		public static var stage:Stage
		public static var section:DisplayObject
		
		public function Director() 
		{
			
		}
		
		
		public static function goTo(seccion:String): void {
			if (section) {
				section.removeEventListener(Event.COMPLETE, ready);
				stage.removeChild(section)
				section = null
			}
			
			switch (seccion) 
			{
				case "menu":
					section = new Menu()	
				break;
			
				case "game":
					section = new Game()
				break;
			}
			Section(section).beginLoad()
			section.addEventListener(Event.COMPLETE, ready)
			
			
			
		}
		
		static private function ready(e:Event):void 
		{
			stage.addChild(section)
		}
		
		
		
	
	}

}