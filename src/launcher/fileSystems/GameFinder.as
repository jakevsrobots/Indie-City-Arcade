package launcher.fileSystems 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import launcher.data.GameData;
	/**
	 * ...
	 * @author Andy Saia
	 */
	public class GameFinder
	{	
		private var _folder:File;
		
		public function GameFinder(folder:File) 
		{
			_folder = folder;
		}
		
		public function getAllGamesInFolder():Vector.<GameData>
		{
			var allGameData:Vector.<GameData> = new Vector.<GameData>();
			var allFolderInDir:Array = _folder.getDirectoryListing();
			for each (var file:File in allFolderInDir) 
			{
				var xmlFile:File = file.resolvePath("config.xml");
				if (xmlFile.exists)
				{
					var gameData:GameData = parseXML(readXMLFile(xmlFile), file);
					allGameData.push(gameData);
				}
			}
			
			return allGameData;
		}
		
		private function readXMLFile(file:File):XML
		{
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			var xml:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
			fileStream.close();
			return XML(xml);
		}
				
		private function parseXML(xml:XML, rootFile:File):GameData
		{
			var title:String = xml.title;
			var description:String = xml.description;
			var exePath:String = rootFile.resolvePath(xml.exePath).nativePath;
			var imagePath:String = rootFile.resolvePath(xml.imagePath).nativePath;
			
			return new GameData(title, description, exePath, imagePath);
		}
	}
}