import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

class Enemigo extends FlxSprite {

    public function new (X: Float = 0, Y: Float = 0) {
        super(X, Y);
    }
	
	
	public function resuelve() {

	}
	
	public function setEscala(tamanio:Float) {
		var escala = tamanio / this.width;
		scale.set(escala * scale.x, escala * scale.y);
		updateHitbox();
		y = y - height;
	}
	
	override public function update(elapsed):Void {
		if ( this.isOnScreen(FlxG.camera) ) {
			super.update(elapsed);
		}
	}

	
	public function lastimar() {
	
	}


	public function setDialogoAtacado(dialogo:String) {
		dialogoAtacado = dialogo;
	}

	public function setDialogoAtaque(dialogo:String) {
		dialogoAtaque = dialogo;
	}

	public function getDialogoAtacado() {
		return dialogoAtacado;
	}

	public function getDialogoAtaque() {
		return dialogoAtaque;
	}

	public function setVelocidad(v:Float) {
		velocidad = v;
	}
	
	public function setVidas(v:Int) {
		vidas = v;
	}
	
	
	public var velocidad : Float = 50;
	private var dialogoAtaque: String = "";
	private var dialogoAtacado: String = "";
	private var vidas: Int;

}