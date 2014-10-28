package objects
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Giselle Higa
	 */
	public class WorldObject extends Rectangle
	{
		public var type:String
		public var objWidth:int
		public var objHeight:int
		public var sizePixel:int
		
		
		public function WorldObject(_type:String,_objWidth:int, _objHeight:int, _x:int, _y:int, _size:int) 
		{
			super(_x, _y, _objWidth * _size, _objHeight * _size)
			type = _type
			objWidth = _objWidth
			objHeight = _objHeight
			sizePixel = _size
			
		}
		
	}

}