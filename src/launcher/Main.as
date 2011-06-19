package launcher 
{
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	import launcher.data.GameData;
	import launcher.fileSystems.GameFinder;
	import launcher.fileSystems.GameProcess;
	import launcher.worlds.DemoWorld;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	

    [SWF(width="800", height="600", backgroundColor="#000000")];

    public class Main extends Engine 
	{
		private var _gameProcess:GameProcess;
		
        public function Main():void 
		{	
			stage.align = StageAlign.TOP_LEFT;
			stage.displayState = StageDisplayState.FULL_SCREEN;
            super(stage.stageWidth, stage.stageHeight);
        }
		
		override public function init():void 
		{
			stage.align = StageAlign.TOP_LEFT;
			//uncomment this to display fullscreen
			//stage.displayState = StageDisplayState.FULL_SCREEN;
			
			FP.world = new DemoWorld();
			super.init();
			
			test();
		}
		
		private function test():void
		{
			//when the program isn't installed yet the application directory is the bin/debug folder
			var gameDirectory:File = File.applicationDirectory.resolvePath("allGamesTestDir");
			var gameFinder:GameFinder = new GameFinder(gameDirectory);
			
			var allGames:Vector.<GameData> = gameFinder.getAllGamesInFolder();
			//inits a game process with the first game in the allGames Directory
			_gameProcess = new GameProcess(allGames[0].exePath);
			_gameProcess.addEventListener(Event.OPEN, gameLaunched, false, 0, true);
			_gameProcess.addEventListener(Event.CLOSE, gameClosed, false, 0, true);
			_gameProcess.launchWithNativeProcess();
		}
		
		private function gameLaunched(e:Event):void 
		{
			var gameProcess:GameProcess = GameProcess(e.currentTarget);
			gameProcess.removeEventListener(Event.OPEN, gameLaunched);
			trace("game launched");
			
			//closes the game after 5000 milliseconds
			var timer:Timer = new Timer(5000);
			timer.addEventListener(TimerEvent.TIMER, timerTick, false, 0, true);
			//timer.start();
		}
		
		private function gameClosed(e:Event):void 
		{
			var gameProcess:GameProcess = GameProcess(e.currentTarget);
			gameProcess.removeEventListener(Event.CLOSE, gameClosed);
			trace("game closed");
		}
		
		private function timerTick(e:TimerEvent):void 
		{
			var timer:Timer = Timer(e.currentTarget);
			timer.removeEventListener(TimerEvent.TIMER, timerTick);
			_gameProcess.killGame();
		}			
    }
}