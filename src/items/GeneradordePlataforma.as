package items 
{
	import com.adobe.serialization.json.JSON;
	import flash.accessibility.AccessibilityImplementation;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.globalization.StringTools;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import objects.WorldObject;
	/**
	 * ...
	 * @author Giselle Alejandra Higa
	 */
	public class GeneradordePlataforma extends Sprite
	{
	
		
		private var plataformas:Array = ["t1", "t2", "t3", "f1", "g1", "v1", "shield1", "e1", "speed1", "bg2", "bg"];
		
		public var listaMC:Array = ["testPlayer"]
		public var loader:Loader 
		public var urlLoader:URLLoader
		public var listaItems:Array
		private var mcCargado:Boolean;
		private var txtCargado:Boolean;
		private var fondoData:BitmapData;
		private var imagenes:BitmapLoader;
		private var mc:MovieClip;
		public var cargado:Boolean;
		static public const TODO_LISTO:String = "todoListo";
		private var listaISuma:int
		
		public function GeneradordePlataforma() 
		{
			listaItems = new Array()
			
			//MOVIE CLICP FILE
			loader = new Loader() 
			var urlRequest:URLRequest = new URLRequest("asset/testPlayer.swf")
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, seCargoMC)
			loader.load(urlRequest)
			
			//TXT FILE
			var urlRequest2:URLRequest = new URLRequest("asset/itemsPosition.txt")
			urlLoader = new URLLoader()
			urlLoader.addEventListener(Event.COMPLETE, seCargoTxt)
			urlLoader.load(urlRequest2);
		
			
			imagenes = new BitmapLoader(plataformas)
			
			
			imagenes.addEventListener(BitmapLoader.TODO_CARGADO, completarCarga)
			
	
			
		}
		
		private function seCargoTxt(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, seCargoTxt)
			txtCargado = true
			var fileContent:String = urlLoader.data
			var object:Array = JSON.decode(fileContent)
			
			for (var i:int = 0; i < object.length; i++) {
				var worldObjectDefinition:Object = object[i]
				trace ("EL CONTENIDO DE WORLDOBJECTDEFINITIO ES " + worldObjectDefinition )
				listaItems[i] = worldObjectDefinition["o"];
				
				switch (worldObjectDefinition["o"]) 
				{
					case "Platform":
					
						
					break;
					
					
					
				}
				
				trace (listaItems)
				
				
				
			}
			trace (object)
			trace ("se cargo el TXT")
		}
		
		private function completarCarga(e:Event):void 
		{
			cargado = true
			if (mcCargado && txtCargado){ 
			trace ("TODO OK CON GENERADOR PLATAFORMA")
			dispatchEvent(new Event(TODO_LISTO))
			}
		}
		
		private function seCargoMC(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.COMPLETE,seCargoMC)
			mc = MovieClip(e.currentTarget.loader.content)
			trace ("cargaron todas las imagenes")	
			mcCargado = true
			if (cargado) {
				dispatchEvent(new Event(TODO_LISTO))
			}
			
		}
		
		
		
		public function crearVista (tipo:String,tiles:int):BitmapData {
			if (cargado == false) {
			throw new Error ("AUN NO SE CARGARON LAS COSAS")	
			} 
			
			if (tipo == "char") {
				return imagenes.getFile("char")
				}
			
			if (tiles == 1) {
				return createMonster(tipo);
			}
			
			var t1:BitmapData = imagenes.getFile(tipo+"1")
			var t2:BitmapData = imagenes.getFile(tipo+"2")
			var t3:BitmapData = imagenes.getFile(tipo+"3")
			var alto:int = Math.max(0, t1.height)
					alto = Math.max(alto, t2.height)
					alto = Math.max(alto, t3.height)
					
			var data:BitmapData = new BitmapData((tiles-2)*t2.width + t1.width + t3.width, alto, true,0x00000000)
			// true mergealpha para mezlcar colores con el fondo
			
			data.copyPixels(t1, t1.rect, new Point(0, 0), null, null,true)
			for (var i:int = 0; i < tiles - 2; i++) 
				{
					data.copyPixels(t2, t2.rect, new Point(t2.width*i + t1.width, 0), null, null, true)
				}
			data.copyPixels(t3,t3.rect, new Point((tiles-2)*t2.width + t1.width, 0), null,null, true)
			
			return data
		}
		
		public function createMonster (type:String):BitmapData {
			var t1:BitmapData = imagenes.getFile(type+"1")
			var data:BitmapData = new BitmapData(t1.width, t1.height, true, 0x00000000)
			
			data.copyPixels(t1, t1.rect, new Point(0, 0), null, null,true)
			return data
		}
		
		public function getBitmapData(type:String):BitmapData {
			var t1:BitmapData = imagenes.getFile(type)
			var data:BitmapData = new BitmapData(t1.width, t1.height, true, 0x00000000)
			
			data.copyPixels(t1, t1.rect, new Point(0, 0), null, null,true)
			return data
			
		}
		
		public function crearMC(type:String):MovieClip {
			return mc 
			
		}
		
		
		
		
		
		
	}
}	