package views {
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class Character extends Sprite
	{
		var img:Shape;
		
		public function Character(width:int, height:int) 
		{
			
			img = new Shape()
			img.graphics.beginFill(0x88ffff, 1)
			img.graphics.drawRect(0,0,width, height)
			img.graphics.endFill()		
			this.addChild(img)
		}
		
	}

}