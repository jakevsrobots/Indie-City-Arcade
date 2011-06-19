package launcher.fileSystems 
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	/**
	 * ...
	 * @author Andy Saia
	 */
	public class GameProcess extends EventDispatcher
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
				dispatchEvent(new Event(Event.OPEN));
			}
			else
				trace("ERROR: File at location " + _gameFile.nativePath + " does not exists");
		}
		
		public function launchWithNativeProcess():void
		{
			
			if (!_gameFile.exists) return;
			
			trace("launchnative");
			var nativeStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			var args:Vector.<String> = new Vector.<String>();
			args.push(_gameFile.nativePath);
			nativeStartupInfo.arguments = args;	
			
			var executable:File = File.applicationDirectory;
			executable = executable.resolvePath("tools/dist/app_manager_pywinauto.exe");
			//trace(executable.nativePath);
			nativeStartupInfo.executable = executable;

			var nativeProcess:NativeProcess =  new NativeProcess();
			nativeProcess.addEventListener(NativeProcessExitEvent.EXIT, onExit, false, 0, true);
			nativeProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, outputData, false, 0, true);
			nativeProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, errorOutput, false, 0, true);
			
			nativeProcess.start(nativeStartupInfo);
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
			
			var executable:File = File.applicationStorageDirectory;
			//executable = executable.resolvePath("tools/dist/app_manager_pywinauto.exe");
			//nativeStartupInfo.executable = executable;
			nativeStartupInfo.executable = new File("C:/WINDOWS/system32/taskkill.exe");

			var nativeProcess:NativeProcess =  new NativeProcess();
			nativeProcess.addEventListener(NativeProcessExitEvent.EXIT, onExit, false, 0, true);
			nativeProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, outputData);
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
			
			dispatchEvent(new Event(Event.CLOSE));
		}
		
		private function outputData(e:ProgressEvent):void 
		{
			var target:NativeProcess = NativeProcess(e.target);
			var output:String = target.standardOutput.readUTFBytes(target.standardOutput.bytesAvailable);
			trace("output--event");
			trace(output);
			if (output == "APP_STARTED")
			{
				trace("app has started");
			}
			
			if (output == "APP_QUIT")
			{
				target.closeInput();
			}
		}
		
		private function errorOutput(e:ProgressEvent):void 
		{
			var target:NativeProcess = NativeProcess(e.target);
			//trace(target.standardError);
		}
	}
}