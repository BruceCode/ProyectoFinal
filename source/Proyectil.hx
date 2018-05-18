import flixel.FlxSprite;
import flixel.tweens.FlxTween;

class Proyectil extends FlxSprite {

    public function new (X: Float = 0, Y: Float = 0) {
        super(X, Y);
		loadGraphic("assets/images/proyectil.png", true, 6, 6);
		
		animation.add("mega", [0], 1);
		
		FlxTween.tween(this, { "alpha" :0.5 }, 0.1, {  type:FlxTween.PINGPONG } );
		
		updateHitbox();
		centerOffsets(true);
	}
	
		
	public override function update(elapsed): Void {
		super.update(elapsed);
		// matamos al sprite cuando sale de la pantalla
		if (!isOnScreen() || (velocity.x == 0 && velocity.y == 0) )	{
			kill();
		}
	}
	
}