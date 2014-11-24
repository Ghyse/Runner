package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import tools.button;
	import views.BitmapLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class Menu extends Section
	{
		public static const MENU_CARGADO:String = "menu_cargado"
		private var objetos:Array = ["menuBg"] 
		private var imagenes:BitmapLoader
		private var fondo:Bitmap
		public var cargado:Boolean
		private var btn_game:button
		
		
		public function Menu():void 
		{
			
			
			
		}
		
		private function complete(e:Event):void 
		{
			cargado = true
			fondo = new Bitmap(imagenes.getFile("menuBg"))
			
			if (cargado && btn_game.cargado) {
				addChild(fondo)
				addChild(btn_game)
				dispatchEvent(new Event(Event.COMPLETE))
				trace ("menu imagen cargado")
				
				this.addEventListener(MouseEvent.CLICK, jugar)
			}
			
			
		}
		
		private function jugar(e:MouseEvent):void 
		{
			this.removeEventListener(MouseEvent.CLICK, jugar)
		
		
			
		}
		
		override public function beginLoad():void {
			btn_game = new button("game")
			btn_game.beginLoad()
			imagenes = new BitmapLoader(objetos);
			imagenes.beginLoad()
			btn_game.addEventListener(Event.COMPLETE, complete)
			imagenes.addEventListener(BitmapLoader.TODO_CARGADO, complete)
		}
	
		override public function destroy():void {
			removeChild(btn_game)
			imagenes = null	
		
		}
	
		
	
		
	}

}