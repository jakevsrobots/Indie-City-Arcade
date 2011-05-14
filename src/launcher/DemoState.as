package launcher {
    import org.flixel.*;
    
    public class DemoState extends FlxState {
        override public function create():void {
            var title:FlxText = new FlxText(64, 64, FlxG.width, "hella whirled");
            title.size = 32
            title.color = 0xffff00;
            add(title);
        }
    }
}