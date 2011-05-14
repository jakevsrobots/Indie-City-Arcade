package launcher 
{
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import launcher.processes.GameProcess;
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
			//path dashes have to be reversed or escaped
			var testPath:String = "C:/Users/Andy/Desktop/test.exe";
			_gameProcess = new GameProcess(testPath);
			_gameProcess.launchGame();
			
			//lauches the game then closes it after 5000 milliseconds
			var timer:Timer = new Timer(5000);
			timer.addEventListener(TimerEvent.TIMER, timerTick, false, 0, true);
			timer.start();
		}
		
		private function timerTick(e:TimerEvent):void 
		{
			var timer:Timer = Timer(e.currentTarget);
			timer.removeEventListener(TimerEvent.TIMER, timerTick);
			_gameProcess.killGame();
		}			
    }
}