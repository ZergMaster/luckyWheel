package src.ui 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	public class InfoWindow 
	{
		private static var _instance: InfoWindow;
		private static var _isConstructing: Boolean;
		
		private var _bg: Sprite;
		private var _tf: TextField;
		private var _mc: MovieClip;
		
		public function InfoWindow() 
		{
			if (!_isConstructing)
				throw new Error('Singleton, use InfoWindow.instance');
			
			_tf = new TextField();
			_tf.defaultTextFormat = new TextFormat('Verdana', 30);
			_tf.autoSize = TextFormatAlign.CENTER;
			_tf.y = 400;
			
			_bg = new Sprite();
		}
		
		public function init(mc:MovieClip): void 
		{
			_mc = mc;
			
			_bg.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(event: MouseEvent): void 
		{
			_tf.text = '';
			_mc.removeChild(_tf);
			
			_bg.graphics.clear();
			_mc.removeChild(_bg);
		}
		
		public function addMessage(message: String): void 
		{
			if (!_mc)
				throw new Error('You need make init function');
				
			_bg.graphics.clear();
			_bg.graphics.beginFill(0xffffff, 0.4);
			_bg.graphics.drawRect(0, 0, _mc.stage.stageWidth, _mc.stage.stageHeight);
			_mc.addChild(_bg);
			
			_tf.text = message;
			_tf.x = (_mc.stage.stageWidth - _tf.width) / 2;
			_mc.addChild(_tf);
		}
		
		public static function get instance(): InfoWindow {
			if (_instance == null)  
			{
				_isConstructing = true;
				_instance = new InfoWindow();
				_isConstructing = false;
			}
			
			return _instance;
		}
	}
}
