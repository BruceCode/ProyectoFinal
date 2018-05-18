package;


import flixel.FlxState;
import flixel.FlxG;


class Intro extends FlxState
{
	private var texto : flixel.text.FlxText;

	override public function create():Void
	{
		super.create();	
		flixel.FlxG.mouse.visible = false;
		texto = new flixel.text.FlxText(0, 0, 800);
		texto.size = Math.round(flixel.FlxG.height * 0.05);
		//texto.color = 0x00FF00;
		texto.text = 'Proyecto Final: Prototipo\n\nMovimiento con A, D o Flechas\nBarra espaciadora para saltar\n\nPresione una tecla para iniciar';
		add(texto);	


FlxG.log.add(" --- ");
			FlxG.log.add("FlxG " + FlxG.width + " " + FlxG.height );
			FlxG.log.add("camera " + FlxG.camera.x + " " + FlxG.camera.y + " - " + FlxG.camera.width + " " + FlxG.camera.height);

	}

	public override function update(delta) : Void {
		super.update(delta);
        if (flixel.FlxG.keys.pressed.ANY) {
			flixel.FlxG.switchState(new PlayState());
		}
		/*
		texto.color = FlxRandom.color();
		texto.scale.x = texto.scale.y = FlxRandom.floatRanged(0.99, 1);
		*/
	}

}