package launcher 
{
	import launcher.worlds.DemoWorld;
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;

    [SWF(width="800", height="600", backgroundColor="#000000")];

    public class Main extends Engine 
	{
        public function Main():void 
		{
            super(800, 600);
			
        }
		
		override public function init():void 
		{
			FP.world = new DemoWorld();
			super.init();
		}
    }
}