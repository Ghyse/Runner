package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import tools.button;
	import views.BitmapLoader;
	/**
	 * ...
	 * @author qtie
	 */
	public class GameOver extends PopUp
	{
		public static const GAMEOVER_CARGADO:String = "gameover_cargado"
		private var fondo:Bitmap
		private var objectos:Array =  ["gameoverBg"]
		private var imagenesCargar:BitmapLoader
		private var cargado:Boolean
		private var bg:BitmapData 
		private var container:BitmapData;
		private var containerBox:Bitmap
		private var velCont:int
		private var btn_menu:button
		
		
		public function GameOver() 
		{
			
		
			
			
		}
		
		override public function beginLoad ():void {
		
			
			btn_menu = new button("menu")
			btn_menu.beginLoad()
			
			imagenesCargar = new BitmapLoader(objectos)
			imagenesCargar.beginLoad()
			btn_menu.addEventListener(Event.COMPLETE, complete)
			dispatchEvent(new Event(Event.COMPLETE))
			imagenesCargar.addEventListener(BitmapLoader.TODO_CARGADO, complete)	
			
			
		}
		
		private function comenzar(e:Event):void 
		{
			cargado = true
			
			
			
			containerBox.y = containerBox.y + velCont
			velCont = velCont + 3
				
			if (containerBox.y >= stage.stageHeight / 50) {
				this.removeEventListener(Event.ENTER_FRAME, comenzar)	
				addChild(btn_menu)
			}
			
			
			
		}
		
		private function complete(e:Event):void 
		{
			cargado = true
			container = imagenesCargar.getFile("gameoverBg")
			
			if (cargado && btn_menu.cargado) {
				bg = new BitmapData(Director.stage.stageWidth, Director.stage.stageHeight, true, 0x88000000)
				fondo = new Bitmap(bg)
				addChild(fondo)	
			
			
				dispatchEvent(new Event(Event.COMPLETE))
			
				containerBox = new Bitmap(container)
				containerBox.y = containerBox.y - containerBox.height
				containerBox.x = 40
				addChild(containerBox)
			
			
				this.addEventListener(Event.ENTER_FRAME, comenzar)
			}
			
		}
		
		override public function destroy():void {
			objectos = null
			removeChild(fondo)
			removeChild(containerBox)
			removeChild(btn_menu)
			
		}
		
	
	}

}