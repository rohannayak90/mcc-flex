package
{
	import com.murari.Main;
	import com.murari.data.M2NModel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	public class mCreativeCustomizer extends Sprite
	{
		private var _model:M2NModel = M2NModel.getInstance();
		
		private var _starling:Starling;
		
		public function mCreativeCustomizer()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			stage.addEventListener(Event.RESIZE, _onStageResize);
		}
		
		protected function _onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			
			//trace ("Application has been added to stage");
			_starling = new Starling(Main, stage);
			_starling.stage.stageWidth = _model.applicationWidth;
			_starling.stage.stageHeight = _model.applicationHeight;
			_starling.start();
		}
		
		protected function _onStageResize(event:Event):void
		{
			trace (stage.stageWidth + " - " + stage.stageHeight);
			_model.applicationWidth = stage.stageWidth;
			_model.applicationHeight = stage.stageHeight;
		}
	}
}