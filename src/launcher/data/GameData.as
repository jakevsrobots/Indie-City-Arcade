package launcher.data 
{
	/**
	 * ...
	 * @author Andy Saia
	 */
	public class GameData
	{
		private var _title:String;
		private var _description:String;
		private var _exePath:String;
		private var _imagePath:String;
		
		public function GameData(title:String, description:String, exePath:String, imagePath:String)
		{
			_title = title;
			_description = description;
			_exePath = exePath;
			_imagePath = imagePath;
		}
		
		//----------------------------------
		//  getters and setters
		//----------------------------------
		
		public function get title():String { return _title; }
		
		public function get description():String { return _description; }
		
		public function get exePath():String { return _exePath; }
		
		public function get imagePath():String { return _imagePath; }
	}
}