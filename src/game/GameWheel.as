package src.game 
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.FrameLabelPlugin;
	import flash.display.Bitmap;
	import flash.events.Event;
	import src.ui.iCanStartAndStop;
	import flash.display.Sprite;
	
	public class GameWheel extends Sprite implements iCanStartAndStop
	{
		[Embed(source = "/assets/img/wheel.png")]
		private static var WheelImgClass:Class;
		private var _wheel:Sprite = new Sprite();
		
		
		[Embed(source = "/assets/img/arrow.png")]
		private static var ArrowImgClass:Class;
		
		public static  const WHEEL_STOPED:String = "wheelStoped";
		private static const MAX_SPEED:int = 20;
		
		private var _speedRotation:Number = 0;
		private var _result:uint = 0;
		
		private static var resultsArray:Vector.<uint>;
		
		private static var _animTween:TweenLite;
			
		public function GameWheel() 
		{
			resultsArray = new <uint>[ 0, 32, 15, 19, 4, 21, 2, 25, 17, 34, 6, 27, 13, 36, 11, 30, 8, 23, 10, 5,
									  24, 16, 33, 1, 20, 14, 31, 9, 22, 18, 29, 7, 28, 12, 35, 3, 26];
			resultsArray.reverse();
			
			addWheel();
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function addWheel():void 
		{
			var wheelImg:Bitmap = new WheelImgClass();
			
			wheelImg.smoothing = true;
			wheelImg.x = -wheelImg.width/2;
			wheelImg.y = -wheelImg.height / 2;
			_wheel.rotation = -(360 / resultsArray.length) / 2;
			
			_wheel.addChild(wheelImg);
			addChild(_wheel);
			
			var _arrowImg:Bitmap = new ArrowImgClass();
			_arrowImg.smoothing = true;
			_arrowImg.rotation = 90;
			_arrowImg.scaleX = _arrowImg.scaleY = 0.2;
			_arrowImg.x = _arrowImg.width / 2;
			_arrowImg.y = -wheelImg.height / 2 - _arrowImg.height + 10;
			addChild(_arrowImg);
		}
		
		private function enterFrameHandler(event:Event):void
		{
			_wheel.rotation += _speedRotation;
		}
		
		private function smoothSpeedChange(toSpeed:Number, callback=null):void
		{
			if (_animTween)
				_animTween.kill();
				
			var tempObj:Object = {speed: _speedRotation};
			_animTween = TweenLite.to(tempObj, 3, {speed: toSpeed, onUpdate: function () {
				_speedRotation = tempObj.speed;
				}, onComplete: callback});
		}
		
		private function stopWheeling():void 
		{
			var resultIndex:int = Math.floor(((_wheel.rotation>0)? _wheel.rotation : (360+_wheel.rotation)) / (360 / resultsArray.length));
			_result = resultsArray[resultIndex];
			
			dispatchEvent(new Event(WHEEL_STOPED));
		}
		
		public function get result():uint
		{
			return _result;
		}
		
		/* INTERFACE src.ui.iCanStartAndStop */
		
		public function start()
		{
			if(!_speedRotation)
				smoothSpeedChange(MAX_SPEED);
		}
		
		public function stop()
		{
			if(_speedRotation)
				smoothSpeedChange(0, stopWheeling);
		}
	}
}