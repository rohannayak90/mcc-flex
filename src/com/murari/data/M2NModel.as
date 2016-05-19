package com.murari.data
{
	public class M2NModel
	{
		public function M2NModel(argument:SingletonEnforcer)
		{
			
		}
		
		private static var _instance:M2NModel;
		
		public static function getInstance():M2NModel
		{
			if (_instance == null)
				_instance = new M2NModel(new SingletonEnforcer());
			
			return _instance;
				
		}
		
		public var applicationWidth:Number;
		public var applicationHeight:Number;
	}
}

class SingletonEnforcer{}