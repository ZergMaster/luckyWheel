package src.ui 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	public class ButtonsPanel extends Sprite
	{
		
		private var _controlledElement: iCanStartAndStop;
		
		public function ButtonsPanel(controlledElement: iCanStartAndStop)
		{
			_controlledElement = controlledElement;
			
			addButtons();
		}
		
		private function addButtons():void 
		{
			var buttonsGap: uint = 20;
			
			var butStart GameButton = new GameButton('start', startHandler);
			addChild(butStart);
			
			var butStop: GameButton = new GameButton('stop', stopHandler);
			addChild(butStop);
			
			butStop.x = butStart.x + butStart.width + buttonsGap;
		}
		
		private function startHandler(event: MouseEvent):void 
		{
			_controlledElement.start();
		}
		
		private function stopHandler(event: MouseEvent):void 
		{
			_controlledElement.stop();
		}
	}
}