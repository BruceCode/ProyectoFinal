import flixel.FlxSprite;
import flixel.tweens.FlxTween;

class Energia extends FlxSprite {

    public function new (X: Float = 0, Y: Float = 0, tamanio:Float = 0) {
        super(X, Y);
        loadGraphic("assets/images/alienGreenEnergia.png", true, 47, 47);
        animation.add("on", [0], 1, true);
		animation.play("on");
		
		//ajuste de tamaño
		if (tamanio != 0) {
			var escala = tamanio / this.width;
			scale.set(escala, escala);
		}
    }
	
	public function lastimar() {
		this.allowCollisions = 0;
		var tween = FlxTween.tween(this, { "alpha" :0 }, 0.5, {  onComplete:tweenKill } );
	}
	
/**
 * asd 
 * @autor JoseHernan
 * @param	tween 	el objeto tween a matar
 * @return 	nada
 */
	public function tweenKill(tween: FlxTween) {
		kill();
	}
	
}