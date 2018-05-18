import flixel.FlxSubState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;


class Pausa extends FlxSubState
{	
	override public function create():Void
	{
		super.create();	
		var offsetX = FlxG.camera.scroll.x + 50;
		var offsetY = FlxG.camera.scroll.y + 50;
		texto = new FlxText(offsetX, offsetY, 500);
		texto.size = FlxG.height * 0.1;
		texto.color = 0x00FF00;
		texto.text = 'PAUSA';
		add(texto);
	}
	
	public override function update(): Void {
		super.update();
		texto.color = FlxRandom.color(200,255);
        if (FlxG.keys.pressed.P) {
			close();
		}
		
		/*
		if (FlxG.keys.pressed.Q) {
			FlxG.switchState(new Selector());
		}
		*/

	}

	private var texto: FlxText;
}