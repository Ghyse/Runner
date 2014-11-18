package views {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import objects.Player;
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class Pantalla extends Bitmap
	{
		
		private var layers:Dictionary
		private var fondo:BitmapData
		private var gameScreen:BitmapData
		private var hud:BitmapData
		
		
		public function Pantalla(width:int, height:int) 
		{
			fondo = new BitmapData(width, height, true,0x00000000)
			gameScreen = new BitmapData(width, height, true, 0x00000000)
			hud = new BitmapData(width,height,true,0x00000000)
			layers = new Dictionary()
			layers["fondo"] = fondo
			layers["game"] = gameScreen
			layers["hud"] = hud
			
			super(new BitmapData(width,height,true,0x00000000))
			
		}
		
		public function draw(pos:Point, bit:BitmapData, layer:String):void {
			var layerBitmap:BitmapData = layers[layer];
			layerBitmap.copyPixels(bit,bit.rect,pos,null,null,true)
		}
		
		public function drawBitmap(pos:Point, mov:MovieClip, layer:String):void {
   
			var raster:BitmapData = new BitmapData(mov.width, mov.height, true, 0x00000000)
			raster.draw(mov)
			draw(pos,raster,layer)
		}
		
		
		
		public function clean():void {
			fondo.fillRect(fondo.rect,0x00000000)
			gameScreen.fillRect(gameScreen.rect, 0x00000000)
			hud.fillRect(hud.rect, 0x00000000)
			this.bitmapData.fillRect(this.bitmapData.rect, 0x00000000)
			
		}
		
		public function drawBuffer ():void {
			this.bitmapData.copyPixels(fondo,fondo.rect,new Point(0,0),null,null,true)
			this.bitmapData.copyPixels(gameScreen, gameScreen.rect, new Point(0, 0), null, null, true)
			this.bitmapData.copyPixels(hud, hud.rect, new Point(0, 0), null, null, true)
			
		}
		
		
		
	}

}