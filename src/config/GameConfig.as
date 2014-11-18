package config 
{
	import com.adobe.serialization.json.JSON;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import mx.utils.Platform;
	import objects.buff.Energy;
	import objects.buff.Shield;
	import objects.buff.SpeedBoost;
	import objects.Obstacle;
	/**
	 * QUE HACE
	 * carga la configuracion de niveles
	 * 
	 * PARA QUE SE USA
	 * para obtener la informacion configurada de los niveles
	 * 
	 * COMO SE USA
	 * 1- se crea un nuevo objeto del tipo GameConfig
	 * 2- va a pedir la ruta de la configuracion dentro del constructor. 
	 * 3- Avisara cuadno termine (dispach event: "EVENT.COMPLETE"
	 * 4- Una vez cargado, los datos van a estar guardadoes en un array publico. 
	 * 5- 
	 * 
	 * @author ...
	 */
	
		 
	 
	 
	 public class GameConfig extends EventDispatcher
	{
		private var urlLoader:URLLoader;
		private var txtCargado:Boolean;
		public static const TXT_CARGADO:String = "txt_cargado"
		public var listaObjects:Array;
		private var listaItems:Array
		private var carga:int;
		private var object:Array;
		private var urlRequest:URLRequest;
		private var cargatotal:int
		
		public function GameConfig(ruta:String) 
		{
			trace ("principio")
			 listaObjects = new Array()
			
			//TXT FILE
			urlRequest = new URLRequest(ruta)
			urlLoader = new URLLoader(urlRequest)
			urlLoader.addEventListener(Event.COMPLETE, seCargoTxt)
			urlLoader.load(urlRequest);
			
			
		}
		
		private function seCargoTxt(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, seCargoTxt)
			
			var fileContent:String = urlLoader.data
			object = JSON.decode(fileContent)
		
			cargatotal = object.length
			
			trace ("array contenido object JSON: " + object)
			
			for (var i:int = 0; i < object.length; i++) {
				var worldObjectDefinition:Object = object[i]
				trace ("EL CONTENIDO DE WORLDOBJECTDEFINITIO ES " + worldObjectDefinition )
				//listaItems[i] = worldObjectDefinition["o"];
				
				switch (worldObjectDefinition["o"]) 	
				{
					case "Platform":
						listaObjects.push( new objects.Platform(worldObjectDefinition["t"], worldObjectDefinition["w"], worldObjectDefinition["h"], worldObjectDefinition["x"], worldObjectDefinition["y"]));
					break;
					
					case "Obstacle":
						listaObjects.push( new Obstacle(worldObjectDefinition["t"], worldObjectDefinition["w"], worldObjectDefinition["h"], worldObjectDefinition["x"], worldObjectDefinition["y"]));
					break;
					
					case "Shield":
						listaObjects.push( new Shield(worldObjectDefinition["x"], worldObjectDefinition["y"]));
					break;
					
					case "Energy":
						listaObjects.push( new Energy(worldObjectDefinition["x"], worldObjectDefinition["y"]));
					break;
					
					case "SpeedBoost":
						listaObjects.push( new SpeedBoost(worldObjectDefinition["x"], worldObjectDefinition["y"]));
					break;
					
				}
				
				trace (listaObjects)
				carga++
				
				
			}
			
			if (carga == cargatotal) {
					dispatchEvent(new Event(TXT_CARGADO))
			}
			
		
			
			/*if (txtCargado){
				
				dispatchEvent(new Event(TXT_CARGADO))
			}*/
			
		}
		
		
		
		
	}
	
	
	
	
	

}