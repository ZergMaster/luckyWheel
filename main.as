package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import src.game.GameWheel;
	import src.ui.ButtonsPanel;
	import src.ui.GameButton;
	import src.ui.InfoWindow;
	
	
	public class main extends MovieClip 
	{		
		private var _buttons: ButtonsPanel;
		private var _gameWheel: GameWheel
		
		public function main() 
		{
			InfoWindow.instanсe.init(this);
			
			_gameWheel = new GameWheel();
			_buttons = new ButtonsPanel(_gameWheel);
			
			addEventListener(Event.ADDED_TO_STAGE, addThisHandler);
			
			_gameWheel.addEventListener(GameWheel.WHEEL_STOPED, wheelStopedHandler);
		}
		
		private function wheelStopedHandler(event:Event): void 
		{
			InfoWindow.instanсe.addMessage(' Result is ' + String(_gameWheel.result));
		}
		
		private function addThisHandler(event:Event): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addThisHandler);
			
			_gameWheel.x = stage.stageWidth / 2;
			_gameWheel.y = _gameWheel.width / 2 + 58;
			addChild(_gameWheel);
			
			_buttons.x = (stage.stageWidth - _buttons.width) / 2;
			_buttons.y = 900;
			
			addChild(_buttons);
		}
	}
}
