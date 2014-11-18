package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import views.BitmapLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class Menu extends Sprite
	{
		public static const MENU_CARGADO:String = "menu_cargado"
		private var objetos:Array = ["menuBg"] 
		private var imagenes:BitmapLoader
		private var fondo:Bitmap
		public var cargado:Boolean
		
		
		public function Menu():void 
		{
			
			imagenes = new BitmapLoader(objetos);
			imagenes.addEventListener(BitmapLoader.TODO_CARGADO, complete)
			
		}
		
		private function complete(e:Event):void 
		{
			cargado = true
			fondo = new Bitmap(imagenes.getFile("menuBg"))
			
			if (cargado) {
				addChild(fondo)
				dispatchEvent(new Event(MENU_CARGADO))
				trace ("menu imagen cargado")
				
				addEventListener(MouseEvent.CLICK, cambiar)
			}
			
			
		}
		
		private function cambiar(e:MouseEvent):void 
		{
			//stage.removeChild(Director.goTo("menu"))
			stage.addChild(Director.goTo("game"));
		}
		
	
	
	
		
	}

}