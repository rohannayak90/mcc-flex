package com.murari.screens
{
	import com.murari.data.M2NModel;
	import com.murari.interfaces.IM2NScreen;
	import com.murari.service.M2NServiceManager;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;
	
	import starling.events.Event;
	
	
	public class M2NScreenTemplates extends Screen implements IM2NScreen
	{
		public static const SCREEN_NAME:String = "templates-screen";
		
		private var _model:M2NModel = M2NModel.getInstance();
		
		private var _buttonProceed:Button;
		private var _listCustomersView:List;
		private var _usersCollection:ListCollection;
		
		public function M2NScreenTemplates()
		{
			super();
		}
		
		public function initializeView():void
		{
			_createChildren();
			_loadData();
		}
		
		private function _createChildren():void
		{
			_buttonProceed = new Button();
			_buttonProceed.label = "PROCEED";
			_buttonProceed.addEventListener(Event.TRIGGERED, _onButtonTriggered);
			addChild(_buttonProceed);
			
			var __listLayout:TiledRowsLayout = new TiledRowsLayout();
			__listLayout.horizontalGap = 10;//M2NCommonFunctions.getScaledValue(10);
			__listLayout.verticalGap = 10;//M2NCommonFunctions.getScaledValue(10);
			__listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_JUSTIFY;
			__listLayout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			__listLayout.useSquareTiles = false;
			__listLayout.requestedColumnCount = 3;
			//__listLayout.paddingTop = M2NCommonFunctions.getScaledValue(300);
			
			/// The List View
			_listCustomersView = new List();
			//_listCustomersView.layout = __listLayout;
			_listCustomersView.itemRendererFactory = 
				function():IListItemRenderer
				{
					var __renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
					__renderer.labelField = "name";
					//__renderer.accessoryLabelField = "description";
					
					/*var __renderer:M2NTiledUserListRenderer = new M2NTiledUserListRenderer();
					__renderer.infoMain = "barName";
					__renderer.info1 = "city";
					__renderer.info1PreString = "City";
					__renderer.info2 = "accountNumber";
					__renderer.info2PreString = "Account No.";
					__renderer.info3 = "userName";
					__renderer.info3PreString = "Customer name";
					__renderer.addEventListener(Event.SELECT, _onListItemRendererSelected);
					__renderer.backgroundSkin = new Scale9Image(M2NCarlsbergTheme.backTexture9);*/
					return __renderer;
				};
			///_listCustomersView.addEventListener(Event.CHANGE, _onListItemSelected);
			addChildAt(_listCustomersView, 0);
			_listCustomersView.backgroundSkin = _listCustomersView.backgroundDisabledSkin = null;
		}
		
		private function _loadData():void
		{
			M2NServiceManager.requestVariables = new Array("template_id=0");
			M2NServiceManager.addEventListener(Event.COMPLETE, _onTemplatesFetched);
			M2NServiceManager.executeService(M2NServiceManager.SERVICE_GET_TEMPLATE);	
		}
		
		private function _onTemplatesFetched(event:Event):void
		{
			trace (event.data);
			var __i:int = 0;
			var __count:int = 0;
			var __item:Object;
			
			_usersCollection = new ListCollection();
			
			for (__i = 0, __count = event.data.templates.length; __i < __count; __i++)
			{
				__item = event.data.templates[__i];
				trace(__item);
				_usersCollection.push(__item);
			}
			
			_listCustomersView.dataProvider = _usersCollection;
		}
		
		private function _onButtonTriggered(event:Event):void
		{
			trace ("Button Triggered");
			
			_loadData();
		}
		
		override protected function draw():void
		{
			super.draw();
			
			if (_listCustomersView)
			{
				_listCustomersView.width = _model.applicationWidth;
				_listCustomersView.height = 500;
				_listCustomersView.validate();
			}
			if (_buttonProceed)
			{
				_buttonProceed.validate();
				_buttonProceed.x = _model.applicationWidth - _buttonProceed.width;
				_buttonProceed.y = _model.applicationHeight - _buttonProceed.height;
			}
		}
	}
}