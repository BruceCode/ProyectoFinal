import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.math.FlxRandom;


class Fin extends FlxState
{	
	override public function create():Void
	{
		super.create();	
		FlxG.mouse.visible = false;
		texto = new FlxText(0, 0, 800);
		
		//texto.color = 0x00FF00;
		texto.text = '\n\nGracias por jugar';
		add(texto);
		
	}
	
	public override function update(elapsed): Void {
		super.update(elapsed);
        if (FlxG.keys.pressed.ANY) {
			destroy();
		}
		/*
		texto.color = FlxRandom.color();
		texto.scale.x = texto.scale.y = FlxRandom.floatRanged(0.99, 1);
		*/
	}
	
	private var texto : FlxText;
}