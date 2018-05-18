import flixel.FlxSprite;

class Espina extends FlxSprite {

    public function new (X: Float = 0, Y: Float = 0, tamanio:Float = 0) {
        super(X, Y);
        loadGraphic("assets/images/espina.png", true, 44, 47);
        animation.add("on", [0], 1, true);
		animation.play("on");
		
		//ajuste de tamaño
		if (tamanio != 0) {
			var escala = tamanio / this.width;
			scale.set(escala, escala);
			updateHitbox();
		}
		
		set_immovable(true);
    }
	
}