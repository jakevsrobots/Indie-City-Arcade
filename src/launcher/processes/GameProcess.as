package launcher.processes 
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	/**
	 * ...
	 * @author Andy Saia
	 */
	public class GameProcess
	{
		private var _gameFile:File;
		private var _isRunning:Boolean;
		
		public function GameProcess(gamePath:String) 
		{
			_gameFile = new File (gamePath);
		}
		
		//----------------------------------
		//  getters and setters
		//----------------------------------
		
		public function get gameFile():File { return _gameFile; }
		
		public function get isRunning():Boolean { return _isRunning; }
		
		//----------------------------------
		//  public methods
		//----------------------------------
		
		public function launchGame():void
		{
			if (_gameFile.exists)
			{
				_gameFile.openWithDefaultApplication();
				_isRunning = true;
			}
			else
				trace("ERROR: File at location " + _gameFile.nativePath + " does not exists");
		}
		
		public function killGame():void
		{
			if (!_isRunning) return;
			
			var nativeStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			var args:Vector.<String> = new Vector.<String>();
			//force close
			args.push("/f");
			//find by image name
			args.push("/im");
			args.push(_gameFile.name);
			nativeStartupInfo.arguments = args;	
			nativeStartupInfo.executable = new File("C:/WINDOWS/system32/taskkill.exe");

			var nativeProcess:NativeProcess =  new NativeProcess();
			nativeProcess.addEventListener(NativeProcessExitEvent.EXIT, onExit, false, 0, true);
			nativeProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, outputData, false, 0, true);
			nativeProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, errorOutput, false, 0, true);
			
			nativeProcess.start(nativeStartupInfo);
		}
		
		//----------------------------------
		//  Event Handlers
		//----------------------------------
		
		private function onExit(e:NativeProcessExitEvent):void 
		{
			var target:NativeProcess = NativeProcess(e.currentTarget);
			target.removeEventListener(NativeProcessExitEvent.EXIT, onExit);
			target.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, outputData);
			target.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, errorOutput);
			target.closeInput();
			_isRunning = false;
		}
		
		private function outputData(e:ProgressEvent):void 
		{
			var target:NativeProcess = NativeProcess(e.target);
			trace(target.standardOutput.readUTFBytes(target.standardOutput.bytesAvailable));
		}
		
		private function errorOutput(e:ProgressEvent):void 
		{
			var target:NativeProcess = NativeProcess(e.target);
			trace(target.standardError);
		}
	}
}