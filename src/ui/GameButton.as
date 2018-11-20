package src.ui 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class GameButton extends Sprite
	{
		[Embed(source = "/assets/img/ButtonNormal.png")]
		private static var DefaultStateClass:Class;
		private var _defaultStateImg:Bitmap = new DefaultStateClass();
		
		[Embed(source = "/assets/img/ButtonOver.png")]
		private static var OverStateClass:Class;
		private var _overStateImg:Bitmap = new OverStateClass();
		
		[Embed(source = "/assets/img/ButtonPressed.png")]
		private static var PressedStateClass:Class;
		private var _pressedStateImg:Bitmap = new PressedStateClass();
		
		[Embed(source = '/assets/fonts/verdana.ttf', embedAsCFF = "false", fontName = 'myVerdana',
				mimeType = 'application/x-font-truetype', advancedAntiAliasing = 'true')]
		private static var EmbeddedFont:Class;		
				
		private static const DEFAULT_STATE:String = 'defaultState';
				
		private var _label:String;
		private var _callback:Function;
		
		public function GameButton(label:String, clickHandler:Function)
		{
			_label = label;
			_callback = clickHandler;
			
			createButton();
			createLabel();
			
			state = DEFAULT_STATE;
		}
		
		private function createButton():void
		{
			this.addChild(_defaultStateImg);
			_defaultStateImg.smoothing = true;
			
			this.addChild(_overStateImg);
			_overStateImg.smoothing = true;
			
			this.addChild(_pressedStateImg);
			_pressedStateImg.smoothing = true;
			
			this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseChildren = false;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			
			this.addEventListener(MouseEvent.CLICK, _callback);
		}
		
		private function createLabel():void 
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat('myVerdana',  48, 0xffffff);
			tf.text = _label;
			tf.embedFonts = true;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			
			tf.autoSize = TextFormatAlign.CENTER;
			tf.x = (this.width - tf.width) / 2;
			
			tf.filters = [new GlowFilter(0x333333, 0.5, 10, 10, 2, 3)];
			
			addChild(tf);
		}
		
		private function mouseHandler(event:MouseEvent):void 
		{
			state = event.type;
		}
		
		private function set state(value:String):void 
		{
			switch(value) 
			{
				case MouseEvent.MOUSE_OVER:
					_defaultStateImg.visible = false;
					_overStateImg.visible = true;
					_pressedStateImg.visible = false;
					break;
					
				case MouseEvent.MOUSE_DOWN:
					_defaultStateImg.visible = false;
					_overStateImg.visible = false;
					_pressedStateImg.visible = true;
					break;
					
				case DEFAULT_STATE:
				case MouseEvent.MOUSE_OUT:
				case MouseEvent.MOUSE_UP:
					_defaultStateImg.visible = true;
					_overStateImg.visible = false;
					_pressedStateImg.visible = false;
					break;
			}
		}
	}
}