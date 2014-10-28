package
{
	import flash.display.MovieClip;
	import flash.net.IDynamicPropertyWriter;
	import items.Pantalla;
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
	import items.Character;
	import items.GeneradordePlataforma;
	import objects.buff.Powerup;
	import objects.buff.Energy;
	import objects.buff.Shield;
	import objects.buff.SpeedBoost;
	import objects.World;
	
	import objects.Obstacle;
	import objects.Platform;
	
	import items.ScrollingImage;
	import objects.Player;
	import objects.WorldObject;
	
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class Game extends Sprite
	{
		private var fondo:ScrollingImage;
		public var anchoLevel:int
		public var gravedad:int
		private var obstacles:GeneradordePlataforma;
		
		private var tipTile:String = "t";
		private var myPantalla:Pantalla;
		public var listaPositionPlatform:Array;
		public var listaObstacle:Array
		public var listaPlatform:Array
		public var listaPowerup:Array
		
	
	
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
			anchoLevel = 18000
			gravedad = 10
			obstacles = new GeneradordePlataforma();
			listaElementos = [new SpeedBoost(750,150), new Energy(500,200),new Shield(800, 100),new Obstacle("f", 1, 1, 750, 0), new Obstacle("v", 1, 1, 2000, 100), new Obstacle("g", 1, 1, 1200, 150),new Platform("t", 4, 1, 450,150), new Platform("t", 2, 1, 1000, 150), new Platform("t", 8, 1, 2100, 150)]
			listaElementosView = new Dictionary();
			camera = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight)
			elements = new World(gravedad, anchoLevel)
			
			for each (var item:WorldObject in listaElementos) {
				elements.addWorldObeject(item);
			}
			
			fondo = new ScrollingImage(elements.player1.velocityX)
			addChild(fondo)
			myPantalla = new Pantalla(camera.width, camera.height)
			addChild(myPantalla)
			
			obstacles.addEventListener(GeneradordePlataforma.TODO_LISTO, objectLoadComplete)
		
			
			
		
		
		}
		
		private function objectLoadComplete(e:Event):void
		{
			
			loadCompleteObstacle = true
			crearTipoClaseObjeto(elements._listaElements, listaElementosView)
			
			charView = obstacles.crearMC("testPlayer.swf")
			this.addEventListener(Event.ENTER_FRAME, correrJuego)
			stage.addEventListener(KeyboardEvent.KEY_UP, select)
		
		}
		
		private function correrJuego(e:Event):void
		{
			myPantalla.clean();
			elements.update()
			camera.x = elements.player1.x - 150
			if (elements.player1.x >= 2000) {
				//fondo.cambiarFondo(obstacles.getBitmapData("bg2"))
				fondo.hacerNoche()
			}
			
			if (elements.player1.onFloor  && charView.currentLabel != "run") {
				charView.gotoAndPlay("run")
			}
			
			if (elements.isFinish) {
				this.removeEventListener(Event.ENTER_FRAME, correrJuego)
				fondo.scrollSpeed = 0
			}
			if (elements.player1.dead) {
				this.removeEventListener(Event.ENTER_FRAME, correrJuego)
				fondo.scrollSpeed = 0
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
						
					}
					else if (elements.player1.velocityY == 0)
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
				bibliotecaObjeto[object] = obstacles.crearVista(object.type, object.objWidth)
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
		
		public function onLoadComplete(e:Event):void
		{
			this.removeEventListener(Event.COMPLETE, onLoadComplete)
		}
		
		
		
		
		public function finish (e:Event):void {
			this..removeEventListener(Event.ENTER_FRAME, correrJuego)
		}
		
	}
	
}