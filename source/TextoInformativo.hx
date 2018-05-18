import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class TextoInformativo {
	
    public function new () {
		texto = new FlxText(0, 0, FlxG.width, "");
		texto.setFormat(null, 8, FlxColor.BLACK, "center");
		texto.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.WHITE, 4);
		texto.alpha = 0.75;
		
		texto.scrollFactor.x = 0;
		texto.scrollFactor.y = 0;
		
		FlxG.state.add(texto);
	}
	
	public function setTexto(t:String) {
		texto.text = t;
		//texto.visible = true;
		texto.alpha = 1;

		
		if(tween != null)
			if(tween.active)
				tween.cancel();
		tween = FlxTween.tween(texto, { "alpha" : 0 }, 3, {  onComplete:tweenCompleto } );	
	}
	
	private function tweenCompleto(tween: FlxTween) {
		//texto.visible = false;
	}
	
	/**
	 * Ajusta la posicion del texto
	 * NOTA: de paso aprendo a documentar =P
	 * 
	 * @param	equis	x.
	 * @param	yGirega		y.
	 */
	
	public function setPosition(equis: Float = 0.0,  yGriega: Float = 0.0, tamanio: Float = 8) {
		texto.x = equis;
		texto.y = yGriega;
		texto.size = Math.round(tamanio);
	}
	
	private var texto : FlxText;
	private var tween : FlxTween;
}