import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;

class BossGelatina extends FlxSprite {

    public function new (X: Float = 0, Y: Float = 0) {
        super(X, Y);
        loadGraphic("assets/images/enemigo4.png", true, 51, 28);
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
	
	public function setEscala(tamanio:Float) {
		var escala = tamanio / this.width;
		scale.set(escala, escala);
		updateHitbox();
	}
	
	public function setTarget() {
		var ps:PlayState = cast( FlxG.state, PlayState);
		TARGET = ps.heroe;
	}
	
	override public function update():Void {
		
		if( this.isOnScreen(FlxG.camera) ){
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
				
		}// isOnScreen
		
	}// update

	public function lastimar() {
		ENERGIA--;
		if(ENERGIA == 0) {
			kill();
		}
		
	}
	
	private var VEL : Float = 200.0;
	private var ENERGIA : Int = 3;
	private var TARGET: FlxSprite;
	
}