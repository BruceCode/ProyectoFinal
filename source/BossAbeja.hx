import flixel.effects.FlxSpriteFilter;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.util.FlxMath;
import openfl.filters.GlowFilter;

class BossAbeja extends FlxSprite {

    public function new (X: Float = 0, Y: Float = 0) {
        super(X, Y);
        loadGraphic("assets/images/bossAbeja.png", true, 21, 15);
        animation.add("volar", [0, 1], 10, true);
		animation.add("morir", [2], 1, true);
		animation.play("volar");

	//	FILTER = new GlowFilter (0xFF0000, 0.9, 20, 20, 2, 1);
	//	sprFilter = new FlxSpriteFilter(this);
	//	sprFilter.addFilter(FILTER);
    }
	
	public function setEscala(tamanio:Float) {
		var escala = tamanio / this.width;
		scale.set(escala, escala);
		updateHitbox();
	}
	
	public function setTarget(t:FlxSprite) {
		TARGET = t;
	}
	
	override public function update():Void {
		
		if( this.isOnScreen(FlxG.camera) ){
			super.update();
			if(TARGET != null) {
				if(TARGET.getMidpoint().y > getMidpoint().y) {
					velocity.y = VEL;
				}
				else {
					velocity.y = -VEL;
				}
			}
		}// isOnScreen
		
	}// update

	public function lastimar() {
		ENERGIA--;
		if(ENERGIA == 0) {
			kill();
		}
		else {
			var tween = FlxTween.tween(this, { "alpha" :0 }, 0.25, {  complete:tweenCompleto } );
		}
	}
	
	public function tweenCompleto(tween: FlxTween) {
		alpha = 1;
	}

	
	public function Kamikaze() {
		allowCollisions = 0;
		var tween = FlxTween.tween(this, { "alpha" :0 }, 0.5, {  complete:morir } );
	}
	
	public function morir(tween: FlxTween) {
		kill();
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
	
	private var VEL : Float = 70.0;
	private var ENERGIA : Int = 3;
	private var TARGET: FlxSprite;
	private var FILTER: GlowFilter;
	private var sprFilter : FlxSpriteFilter;
	private var DISTANCIA : Float = 0;
	
	
	private var dialogoAtaque: String = "";
	private var dialogoAtacado: String = "";
}