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
	public class Menu extends Section
	{
		public static const MENU_CARGADO:String = "menu_cargado"
		private var objetos:Array = ["menuBg"] 
		private var imagenes:BitmapLoader
		private var fondo:Bitmap
		public var cargado:Boolean
		
		
		public function Menu():void 
		{
			
			
			
		}
		
		private function complete(e:Event):void 
		{
			cargado = true
			fondo = new Bitmap(imagenes.getFile("menuBg"))
			
			if (cargado) {
				addChild(fondo)
				dispatchEvent(new Event(Event.COMPLETE))
				trace ("menu imagen cargado")
				
				this.addEventListener(MouseEvent.CLICK, jugar)
			}
			
			
		}
		
		private function jugar(e:MouseEvent):void 
		{
			this.removeEventListener(MouseEvent.CLICK, jugar)
			Director.goTo("game")
			
		}
		
		override public function beginLoad():void {
			imagenes = new BitmapLoader(objetos);
			imagenes.addEventListener(BitmapLoader.TODO_CARGADO, complete)
		}
	
		
	
		
	
		
	}

}