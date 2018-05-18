import flixel.FlxSprite;

class PaseNivel extends FlxSprite {

    public function new (X: Float = 0, Y: Float = 0, tamanio:Float = 0,  archivo: String = "nivel.tmx", nombre: String = "nivel", numero: Int = 0) {
        super(X, Y);
		if( X != 0 && Y != 0 ) {
			loadGraphic("assets/images/bandera.png", true, 67, 70);
			animation.add("on", [0,1], 3, true);
			animation.play("on");
			
			//ajuste de tamaño
			if (tamanio != 0) {
				var escala = tamanio / this.width;
				scale.set(escala, escala);
				updateHitbox();
			}
			
			width = width * 0.5;
			height *= 0.5;
			
			
			set_immovable(true);		
		}
		
		this.nombre = nombre;
		this.archivo = archivo;
		this.numero = numero;
		
    }
	
	public function getNombre() {
		return nombre;
	}
	
	public function getArchivo() {
		return archivo;
	}
	
	public function getNumero() {
		return numero;
	}
	
	private var nombre : String;
	private var archivo : String;
	private var numero : Int;
	
}