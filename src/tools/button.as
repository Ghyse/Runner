package tools 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import views.BitmapLoader;
	/**
	 * ...
	 * @author qtie
	 */
	public class button extends Sprite implements Cargador
	{
		public var fondo:Bitmap
		public var listaCargar:Array = ["play"]
		public var imagenes:BitmapLoader
		public var id:String
		public var cargado:Boolean
		
		
		
		public function button(_id:String) 
		{
			
			id = _id
			
				
		}
		
		/* INTERFACE Cargador */
		
		public function beginLoad():void 
		{
			imagenes = new BitmapLoader(listaCargar)
			imagenes.beginLoad()
			imagenes.addEventListener(BitmapLoader.TODO_CARGADO, complete)
		}
		
		private function complete (e:Event):void 
		{
			cargado = true
			fondo = new Bitmap(imagenes.getFile("play"))
			addChild(fondo)
			trace ("mostrar boon")
			
			this.removeEventListener(Event.COMPLETE, complete)
			dispatchEvent(new Event(Event.COMPLETE))
			this.addEventListener(MouseEvent.CLICK, action)
			
		}
		
		private function action(e:MouseEvent):void 
		{
				
			switch (id) 
				{
					case "menu":
						Director.goTo("menu")
					break
					
					case "game":
						Director.goTo("game")
					break
				
				}
			
			
		}
		
		public function get loadComplete():Boolean 
		{
			return true
		}
		
	}

}