import flixel.effects.FlxSpriteFilter;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxTween;

class EnemigoMosca extends Enemigo {

    public function new (X: Float = 0, Y: Float = 0, tamanio:Float = 0) {
        super(X, Y);
        loadGraphic("assets/images/enemigo5.png", true, 75, 36);
        
		
		setEscala(tamanio);
		animation.add("volar", [0, 1], 5, true);
		animation.play("volar");
		velocity.x = -VEL;
		
		FlxTween.tween(this, { "y" : y + 5 }, 0.2, {  type:FlxTween.PINGPONG } );
		
		
    }
	
	
	override public function update():Void {
		super.update();
		
		if ((wasTouching & FlxObject.WALL) != 0) {
			if(!flipX) {
				x++;
				flipX = true;
				velocity.x = VEL;
			}
			else {
				x--;
				flipX = false;
				velocity.x = -VEL;
			}
		}

	}
	

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

	private var VEL : Float = 30.0;
	private var ENERGIA : Int = 3;
	
}