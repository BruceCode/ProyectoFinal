import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class IndicadorVidas {
	
    public function new () {
		energia = new Energia(0,0);
		energia.alpha = 0.75;
		
		texto = new FlxText(16, 0, 0, "");
		texto.setFormat(null, 8, FlxColor.BLACK, "center");
		texto.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.WHITE, 4);
		texto.alpha = 0.75;

		
		energia.scrollFactor.x = 0;
		energia.scrollFactor.y = 0;
		texto.scrollFactor.x = 0;
		texto.scrollFactor.y = 0;
		
		FlxG.state.add(energia);
		FlxG.state.add(texto);
	}
	
	public function setEscala(tamanio:Float) {
		var escala = tamanio / energia.width;
		energia.scale.set(escala, escala);
		energia.updateHitbox();
		texto.size = Math.round(tamanio / 2);
		texto.x = tamanio;
		texto.y = tamanio / 4;
	}
	
	public function setTexto(t:String) {
		texto.text = t;
	}
	
	private var energia : Energia;
	private var texto : FlxText;
}