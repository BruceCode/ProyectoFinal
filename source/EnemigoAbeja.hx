import flixel.effects.FlxSpriteFilter;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.util.FlxMath;
import openfl.filters.GlowFilter;

class EnemigoAbeja extends Enemigo {

    public function new (X: Float = 0, Y: Float = 0, tamanio:Float = 0) {
        super(X, Y);
        loadGraphic("assets/images/enemigo6.png", true, 61, 48);
		setEscala(tamanio);
		
        animation.add("volar", [0, 1], 10, true);
		animation.add("morir", [2], 1, true);
		animation.play("volar");

		velocity.x = -VEL;
		
		FILTER = new GlowFilter (0xFF0000, 0.9, 20, 20, 2, 1);
		sprFilter = new FlxSpriteFilter(this);
		sprFilter.addFilter(FILTER);
	
		setTarget();
    }

	
	/**
	 * Asignar el target al cual seguir, pero sin parámetros
	 */
	public function setTarget() {
		var ps:PlayState = cast( FlxG.state, PlayState);
		TARGET = ps.getHeroe();
	}
	
	
	override public function update():Void {
		super.update();

		if(DISTANCIA == 0) {
			DISTANCIA = FlxMath.roundDecimal(FlxMath.getDistance(this.getMidpoint(), TARGET.getMidpoint()) / 100, 2);
		}
		
		if(TARGET.getMidpoint().x > getMidpoint().x) {
			flipX = true;
			velocity.x = VEL;
		}
		else {
			flipX = false;
			velocity.x = -VEL;
		}
		
		if(TARGET.getMidpoint().y > getMidpoint().y) {
			velocity.y = VEL;
		}
		else {
			velocity.y = -VEL;
		}
		
		var d : Float = FlxMath.roundDecimal(FlxMath.getDistance(this.getMidpoint(), TARGET.getMidpoint()) / 100, 2); 
		
		if( (d / DISTANCIA) < 1 ) {
			FILTER.alpha = ( 1 - (d/DISTANCIA) );	
		}
		else {
			FILTER.alpha = 0;
		}
		sprFilter.applyFilters();
	}// update

	override public function lastimar() {
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
	

	
	private var VEL : Float = 70.0;
	private var ENERGIA : Int = 3;
	private var TARGET: FlxSprite;
	private var FILTER: GlowFilter;
	private var sprFilter : FlxSpriteFilter;
	private var DISTANCIA : Float = 0;

}