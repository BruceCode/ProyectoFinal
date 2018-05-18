import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Paraguas extends FlxSprite {

	private var script:String;
	
    public function new (X: Float = 0, Y: Float = 0, tamanio:Float = 0) {
        super(X, Y);
        loadGraphic("assets/images/paraguas.png", true, 66, 65);
        animation.add("cerrado", [0], 1, true);
		animation.add("abierto", [1], 1, true);
		animation.play("cerrado");
		
		
		//ajuste de tamaño
		if (tamanio != 0) {
			var escala = tamanio / this.height;
			scale.set(escala, escala);
			updateHitbox();
		}
		
		script = null;
    }
	
	public function setScript(palabras:String) {
		script = palabras;
	}
	
	public function getScript():String {
		return script;
	}
	
	public function abrirCerrar():Void {
		if( animation.name == "abierto") {
			animation.play("cerrado");
		}
		else {
			animation.play("abierto");
		}
	}
	
	public function factorVelocidad():Float {
		if( animation.name == "abierto") {
			return 0.25;
		}
		else {
			return 1.0;
		}
	}
	
}