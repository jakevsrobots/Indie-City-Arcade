package launcher.worlds 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Andy Saia
	 */
	public class DemoWorld extends World
	{
		public function DemoWorld() 
		{
			var text:Text = new Text("hella whirled", 0, 0, 300, 100);
			text.size = 40;
			var entity:Entity = new Entity(0, 0, text);
			add(entity);
		}
	}
}