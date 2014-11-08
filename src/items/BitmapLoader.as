package items 
{
	import flash.desktop.ClipboardFormats;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class BitmapLoader extends Sprite
	{
		public static const TODO_CARGADO:String = "todo_cargado"  // static para qe la constante sea para toda la clase
		private var contadorCarga:int
		private var cargaTotal:int
		private var listaBitmapData:Dictionary
		private var listaLoader:Dictionary
		private var nombre:String
		private var listaName:Array
		
		
		public function BitmapLoader(lista:Array) 
		{
			listaName = new Array()
			listaLoader = new Dictionary()
			listaBitmapData = new Dictionary()
			cargaTotal = lista.length
			loadFiles(lista)
		
		}
		
		
		private function loadFiles (lista:Array):void {
			for (var i:int = 0; i < lista.length; i++) {
				var img:Loader = new Loader
				var imgUrl:URLRequest = new URLRequest("asset/" + lista[i] + ".png")
				crearLoaderNombre(lista[i], img)
				img.contentLoaderInfo.addEventListener(Event.COMPLETE, cargado)
				img.load(imgUrl)
				trace ("esta cargando")
				
			} 
			
			
		
		}
		
		private function cargado(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, cargado)
			var nombre:String = listaLoader[e.currentTarget.loader]
			var bmp:BitmapData = extraerBitmapDataDeLoader(e.currentTarget.loader)
			guardarBitmap(nombre, bmp)
			contadorCarga++
			trace ("cargado")
			
			if (contadorCarga == cargaTotal) {
				dispatchEvent(new Event(TODO_CARGADO))
			trace ("cargaron todas las imagenes")	
			}
		}
		
		private function extraerBitmapDataDeLoader (loader:Loader): BitmapData {
			trace ("extraer bitmapData")
			return Bitmap(loader.content).bitmapData
			
		}
		
		public function getFile (nombre:String):BitmapData {
			if (contadorCarga != cargaTotal) {
				throw new Error ( "no se termino la carga de imagenes") // accion + razon para mostrar
			}	
			if (!listaBitmapData[nombre]) {
				throw new Error ( nombre + " no esta en la lista de imagenes")
			}
			return listaBitmapData[nombre]
		}
		
		private function crearLoaderNombre(nombre:String, loader:Loader):void {
			listaLoader[loader] = nombre
		}
		
		private function guardarBitmap(nombre:String, btm:BitmapData):void {
			listaBitmapData[nombre] = btm	
			
		}
		
		
		
		
		
		
		
		
		
		
	}

}