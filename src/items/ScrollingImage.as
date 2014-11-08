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
		private var cycles:int=0;
		private var vueltaTiritas:int;
		private var arrancar:Boolean;
		public var scrollSpeed:int;
		
		
		public function ScrollingImage(vel:int, image:BitmapData) {
			
			scrollSpeed = vel
			bmp1 = image
			buffer = new BitmapData(bmp1.width, bmp1.height,true, 0x00000000)
			buffer.copyPixels(bmp1,bmp1.rect,new Point(0,0),null,null,true)
			addChild(new Bitmap(buffer))
		
		}
	
		
		public function update():void {
			var recaCambiar:Rectangle = new Rectangle(scrollSpeed * numeroTiritaActual  , 0, scrollSpeed, bmp1.height)
			var rectALimpiar:Rectangle= new Rectangle (bmp1.width - scrollSpeed,0,recaCambiar.width, recaCambiar.height)
			//agarra un pedazo q se va de la pantalla, se lo pone del otro lado. Haciendolo infinito. 
			
			var cantTiritas:int = bmp1.width/scrollSpeed
			
			// se esta comiendo la primer tira lo cual hace q se vea cortado la primera pasada)
			clean(rectALimpiar) // rectangulo a cambiar + posicion del copy pixels (x,y)
			buffer.copyPixels(bmp1, recaCambiar, new Point(bmp1.width - scrollSpeed, 0),null,null,true)
			buffer.scroll( -1 * scrollSpeed, 0)
			
			numeroTiritaActual++
			
			
			if (numeroTiritaActual >= cantTiritas) {
				numeroTiritaActual = 0
			}
			
		}
		
		public function cambiarFondo(bmd:BitmapData):void {
			bmp1.copyPixels(bmd, bmd.rect, new Point(0,0),null,null,true)
		}
		
		public function hacerNoche():void {
		 //bmp1.applyFilter
			var colorChange:ColorTransform
			if (cycles < 60) {
				colorChange = new ColorTransform(1, 1, 1, 1, -1, -2, -1)   // valor * MULT + offset
				bmp1.colorTransform(bmp1.rect, colorChange)
			}
			if (cycles > 60 && cycles <= 100) {
				colorChange = new ColorTransform(1, 1, 1, 1, -1, -1, -1)
				bmp1.colorTransform(bmp1.rect, colorChange)
			}
			cycles++
		}
		
		public function clean(rect:Rectangle):void {
			buffer.fillRect(rect, 0x00000000)
			//bmp1.fillRect(bmp1.rect,0x00000000)
			
		}
			
		
	}
}