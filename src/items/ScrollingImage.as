package items
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	// COPIAR EL SEGUNDO FONDO, AVERIGUAR COMO SABER SI ESTA EL FONDO1 YA CARGADO/FINALIZADO Y QUE EMPIEZE A MOSTRAR EL SEGUNDO FONDO
	
	/**
	 * ...
	 * @author Santiago.J.Elizalde
	 */
	public class ScrollingImage extends Sprite {
		private var buffer:BitmapData;
		private var bmp1:BitmapData
		private var numeroTiritaActual:int;
		public var scrollSpeed:int;
		
		
		public function ScrollingImage(vel:int) {
	
			scrollSpeed = vel
			var loader:Loader = new Loader()
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(new URLRequest("asset/bg.png"));
		}
		
		private function onLoadComplete(e:Event):void {
			
			var loader = e.currentTarget.loader;
			
			
			bmp1 = loader.content.bitmapData as BitmapData;
			buffer = new BitmapData(bmp1.width, bmp1.height, true, 0x00000000)
			addChild(new Bitmap(buffer))
			stage.addEventListener(Event.ENTER_FRAME, onEF)
			
			
		}
		
		private function onEF(e:Event):void {
			//agarra un pedazo q se va de la pantalla, se lo pone del otro lado. Haciendolo infinito. 
			var cantTiritas:int = bmp1.width/scrollSpeed
			
			buffer.copyPixels(bmp1, new Rectangle(scrollSpeed*numeroTiritaActual  ,0, scrollSpeed, bmp1.height), new Point(bmp1.width - scrollSpeed, 0), null, null, true)
			buffer.scroll( -1 * scrollSpeed, 0)
			numeroTiritaActual++
			
			if (numeroTiritaActual > cantTiritas) {
				numeroTiritaActual = 0
			}
			trace ("velocidadX = " + scrollSpeed)
			
			if (scrollSpeed == 0) {
			stage.removeEventListener(Event.ENTER_FRAME, onEF)	
			}
			
		}
		
		public function cambiarFondo(bmd:BitmapData) {
			bmp1.copyPixels(bmd, bmd.rect, new Point(0,0),null, null,true)
		}
		
		public function hacerNoche():void {
		 //bmp1.applyFilter
			var colorChange:ColorTransform = new ColorTransform(0.2, 0.2, 0.5, 0.9)
			bmp1.colorTransform(bmp1.rect, colorChange)
			
			}
			
		
	}
}