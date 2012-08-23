package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Zachary Foley
	 */
	public class Main extends Sprite 
	{		
		static public const RADIANS_TO_DEGREES:Number = 57.2957795;
		static public const DEGREES_TO_RADIANS:Number = 0.0174532925;
		static public const EASE_AMOUNT:Number = 0.05;
		private var circle:Shape
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			// Add a label for this swf.
			var text:TextField = new TextField();
			text.text = "ROTATE SHORTEST PATH";
			text.autoSize = TextFieldAutoSize.CENTER;
			text.width = stage.stageWidth;
			addChild(text);
			// Add a circle to show it works.
			circle = new Shape();
			circle.graphics.lineStyle(1, 0, 1);
			circle.graphics.beginFill(0xFF6767, 1);
			circle.graphics.drawCircle(0, 0, 25);
			circle.graphics.moveTo(0, 0);
			circle.graphics.lineTo(-25, 0);
			addChild(circle);
			circle.x = stage.stageWidth / 2;
			circle.y = stage.stageHeight / 2;
			
			// Add a background color.
			graphics.beginFill(0x999999);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
						
			// Listen for updates
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			// Rotate towards Mouse.
			var p:Point = new Point(circle.x, circle.y);
			p.x -= this.mouseX;
			p.y -= this.mouseY;
			// If you just need to look at the target, use this.
			//circle.rotation = rotateTowards(p) * RADIANS_TO_DEGREES; // Look right at mouse.
			var originalrotation:Number = circle.rotation * DEGREES_TO_RADIANS;
			var targetrotation:Number = Math.atan2(p.y, p.x);
			var rotationdifference:Number = Math.atan2(Math.sin(targetrotation-originalrotation),Math.cos(targetrotation-originalrotation));
			// To look at it just like "Look at mouse" use this.			
			//circle.rotation += rotationdifference*RADIANS_TO_DEGREES;			
			// To ease, we apply only a percentage of the rotation needed.
			circle.rotation += rotationdifference*RADIANS_TO_DEGREES* EASE_AMOUNT;		
		}
		
		// This is the old "Look at mouse" effect.
		public function rotateTowards(point:Point):Number {						
			return Math.atan2(point.y, point.x);
		}
		
	}
	
}