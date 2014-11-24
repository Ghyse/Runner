package
{
	import com.adobe.serialization.json.JSON;
	import config.GameConfig;
	import flash.display.MovieClip;
	import flash.net.IDynamicPropertyWriter;
	import views.GeneradorDeVista;
	import views.Pantalla;
	import objects.buff.Energy;
	import objects.buff.Powerup;
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.GestureEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.engine.BreakOpportunity;
	import flash.utils.Dictionary;
	import views.Character;
	import objects.buff.Powerup;
	import objects.buff.Energy;
	import objects.buff.Shield;
	import objects.buff.SpeedBoost;
	import objects.World;
	
	import objects.Obstacle;
	import objects.Platform;
	
	import views.ScrollingImage;
	import objects.Player;
	import objects.WorldObject;
	
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class Game extends Section
	{
		public var gameReady:Boolean
		public static const GAME_CARGADO:String = "game_cargado"
		private var fondo:ScrollingImage;
		private var fondo2:ScrollingImage
		private var fondo1:ScrollingImage
		
		public var anchoLevel:int
		public var gravedad:int
		private var itemsVista:GeneradorDeVista;
		
		private var tipTile:String = "t";
		private var myPantalla:Pantalla;
		public var listaPositionPlatform:Array;
		public var listaObstacle:Array
		public var listaPlatform:Array
		public var listaPowerup:Array
		public var levelDesign:GameConfig
	
	
		public var camera:Rectangle
		
		
		public var charView:MovieClip
		
	
		public var test:Rectangle
		public var testVies:Obstacle
		
		public var imgBiblio:Dictionary;
	
		public var character:Array = ["run"]
		public var canTiles:Array
		public var loadCompletePlatform:Boolean;
		public var loadCompleteObstacle:Boolean;
		public var loadCompletePowerup:Boolean;
	
		public var listaElementos:Array
		public var listaElementosView:Dictionary;
		public var elements:World
		
		public function Game()
		{
			levelDesign= new GameConfig("asset/itemsPosition.txt")
			//aaaaatrace ("lista de  objetos game config" + testing.listaObjects)
			
			
			
			
		
		}
		
		private function txtComplete (e:Event):void {
			
			anchoLevel = 18000
			gravedad = 10
			itemsVista = new GeneradorDeVista(); //"x":10  "lista"
			itemsVista.beginLoad()
			listaElementos = levelDesign.listaObjects
			listaElementosView = new Dictionary();
			camera = new Rectangle(0, 0, Director.stage.stageWidth, Director.stage.stageHeight)
			elements = new World(gravedad, anchoLevel)
			
			for each (var item:WorldObject in listaElementos) {
				elements.addWorldObeject(item);
			}
			
			itemsVista.addEventListener(GeneradorDeVista.TODO_LISTO, objectLoadComplete)
			
		}
		
		private function objectLoadComplete(e:Event):void
		{
			
			gameReady = true
			loadCompleteObstacle = true
			fondo = new ScrollingImage(elements.player1.velocityX,itemsVista.getBitmapData("bg"))
			fondo2 = new ScrollingImage(elements.player1.velocityX - 9, itemsVista.getBitmapData("bg2"))
			fondo1 = new ScrollingImage(elements.player1.velocityX - 3, itemsVista.getBitmapData("bg1"))
			addChild(fondo2)
			addChild(fondo1)
			addChild(fondo)
			myPantalla = new Pantalla(camera.width, camera.height)
			addChild(myPantalla)
			crearTipoClaseObjeto(elements._listaElements, listaElementosView)
			charView = itemsVista.crearMC("testPlayer.swf")
			
			
			dispatchEvent(new Event(Event.COMPLETE));
			this.addEventListener(Event.ENTER_FRAME, correrJuego)
			stage.addEventListener(KeyboardEvent.KEY_UP, select)
		
		}
		
		private function correrJuego(e:Event):void
		{
			myPantalla.clean();
			//fondo.clean();
			elements.update();
			fondo.update()
			fondo1.update()
			fondo2.update()
			camera.x = elements.player1.x - 150
			if (elements.player1.x >= 2000) {
				//fondo.cambiarFondo(itemsVista.getBitmapData("bg2"))
				//fondo2.hacerNoche()
				//fondo.hacerNoche()
			}
			
			if (elements.player1.onFloor  && charView.currentLabel != "run") {
				charView.gotoAndPlay("run")
			}
			
			if (elements.isFinish) {
				this.removeEventListener(Event.ENTER_FRAME, correrJuego)
				fondo.scrollSpeed = 0
				Director.openPopUp("gameover")
				
			}
			if (elements.player1.dead) {
				this.removeEventListener(Event.ENTER_FRAME, correrJuego)
				fondo.scrollSpeed = 0
				Director.openPopUp("gameover")
			}
		
			
			for each (var item:WorldObject in elements._listaElements){
				fromWorldToScreen(item, listaElementosView[item], "game")
			}
			
			fromWorldToScreenMC(elements.player1, charView, "game")
			myPantalla.drawBuffer();
			
		}
		
		private function select(e:KeyboardEvent):void
		{
			switch (String.fromCharCode(e.charCode))
			{
				
				case "a": 
					//salto normal mientras esta en la tierra
					if (elements.player1.jumpAmount < 2)
					{
						elements.player1.jump()
						elements.player1.jumpAmount++
						charView.gotoAndPlay("jump")
						trace("presionaste saltar")
						trace ("cantidad de saltos: " + elements.player1.jumpAmount)
					}
					
					
					else if (elements.player1.onFloor)
					{
						elements.player1.jumpAmount = 0
					}
					break
				
					
			}
		}
		
		public function crearTipoClaseObjeto(listaRectangulo:Array, bibliotecaObjeto:Dictionary):void
		{
			for each (var object:WorldObject in listaRectangulo)
			{
				bibliotecaObjeto[object] = itemsVista.crearVista(object.type, object.objWidth)
			}
			
			
		}
		
		public function fromWorldToScreen(modelo:WorldObject, vista:BitmapData, layer:String):void
		{
			
			var position:Point = new Point();
			position.x = modelo.x - camera.x
			position.y = (camera.y + camera.height) - (modelo.y + modelo.height)
			myPantalla.draw(position, vista, layer)
	
		}
		
		public function fromWorldToScreenMC(modelo:WorldObject, vista:MovieClip, layer:String):void
		{
			
			var position:Point = new Point();
			position.x = modelo.x - camera.x
			position.y = (camera.y + camera.height) - (modelo.y + modelo.height)
			myPantalla.drawBitmap(position,vista,layer)
		}

		/*public function finish (e:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, correrJuego)
		}*/
		
		override public function beginLoad():void {
			levelDesign.beginLoad();
			levelDesign.addEventListener(GameConfig.TXT_CARGADO, txtComplete)
			
			
		}
		
		override public function destroy ():void {
			levelDesign = null
			this.removeEventListener(Event.ENTER_FRAME,correrJuego)
			
		}
		
		
	}
	
}