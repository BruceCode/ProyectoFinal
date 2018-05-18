import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;

class EnemigoBossGelatina extends Enemigo {

    public function new (X: Float = 0, Y: Float = 0, tamanio: Float = 0) {
        super(X, Y);
        loadGraphic("assets/images/enemigo4.png", true, 51, 28);
		setEscala(tamanio);
        animation.add("caminar", [0, 1], 10, true);
		animation.play("caminar");
		
		//Esto es para que caiga y se acomode al nivel
		velocity.y = VEL * 5;
		//Empieza en sentido izquierdo
		//velocity.x = -VEL;
		acceleration.x = -VEL / 3;
		maxVelocity.x = VEL;
		drag.x = 50;

		
		setTarget();
    }
	
	public function setTarget() {
		var ps:PlayState = cast( FlxG.state, PlayState);
		TARGET = ps.heroe;
	}
	
	override public function update():Void {
			super.update();
			velocity.y = VEL;
			if(TARGET.getMidpoint().x > getMidpoint().x) {
				//velocity.x = VEL;
				acceleration.x = VEL / 3;
				flipX = true;
			}
			else {
				//velocity.x = -VEL;
				acceleration.x = -VEL / 4;
				flipX = false;
			}
	}// update

	
	private var VEL : Float = 200.0;
	private var ENERGIA : Int = 3;
	private var TARGET: FlxSprite;
	
}