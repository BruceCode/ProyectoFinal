import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.math.FlxPoint;

class Heroe extends FlxSprite {
	
    public function new (X: Float = 0, Y: Float = 0, tamanio:Float = 0) {
        super(X, Y);
        //loadGraphic("assets/images/alien1.png", true, 70, 96);
		loadGraphic("assets/images/alien2.png", true, 18, 21);
		
		//ajuste de tamaño
		if (tamanio != 0) {
			var escala = tamanio / this.height;
			scale.set(escala, escala);
			updateHitbox();
			this.y = this.y - this.height;
		}
		
		//Animaciones
		animation.add("quieto", [0, 1], 1);
		animation.add("caminando", [4, 5], 8);
		animation.add("aire", [2], 1);
		animation.add("herido", [3], 1);
		animation.play("aire");
        
		//ajusta hitbox
		width = width * 0.75;
		height *= 0.9;
		centerOffsets();
		
		//parámetros de despalzamiento
		maxVelocity.x = CHAR_MAXVEL;
		maxVelocity.y = CHAR_MAXVEL*3; 
        drag.x = CHAR_DRAG;
		acceleration.y = GRAVEDAD;
		ENERGIA = MAX_ENERGIA;
		
		proyectiles = new FlxTypedGroup<Proyectil>();
		
		var ps:PlayState = cast( FlxG.state, PlayState);
		//FlxG.log.add( "xMax" + ps.getXMax() );
		//FlxG.log.add( "yMax" + ps.getYMax() );
		
		this.xMax = ps.getXMax();
		this.yMax = ps.getYMax();

    }

	//cuando lastiman al personaje
	public function lastimar() {
		if (!lastimado) {
			ENERGIA--;
			lastimado = true;
			animation.play("lastimado");
			tweenParpadeo = FlxTween.tween(this, { "alpha" :0 }, 0.1, { type: FlxTween.PINGPONG } );
		}
	}
		
    public override function update(elapsed): Void {
        super.update(elapsed);
		//Bordes
		if (this.x > this.xMax) { this.x = (-1)*this.width*(0.9); }
		if (this.x < (-1)*this.width*(0.9) ) { this.x = this.xMax - (this.width*0.1); }
		if (this.y > this.yMax) { this.y = (-1)*this.width; }
		if (this.y < (-1)*this.width ) { this.y = this.yMax; }
		
		//PARAGUAS
		if(enElAire && paraguas != null && velocity.y > 0) {
			maxVelocity.y = CHAR_MAXVEL * paraguas.factorVelocidad();
		}
		else {
			maxVelocity.y = CHAR_MAXVEL;
		}
		
		//DISPARO
		tiempoDesdeUltimoDisparo += FlxG.elapsed;
	
		//DAÑO
		if(lastimado) {
			tiempoParpadeo += FlxG.elapsed;
			if (tiempoParpadeo > tiempoInvencible) {
				tiempoParpadeo = 0;
				lastimado = false;
				tweenParpadeo.cancel();
				alpha = 1;
			}
		}
		
		//¿está en ele aire?
		if (wasTouching & FlxObject.FLOOR != 0) {
			enElAire = false;
		}
		else {
			enElAire = true;
			animation.play("aire");
		}
		
		//movimiento a los costados
        if(FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) {
            //acceleration.x = -CHAR_ACCEL;
            velocity.x = -CHAR_ACCEL;
            flipX = true;
        } else if(FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) {
            acceleration.x = CHAR_ACCEL;
            flipX = false;
        } else {
            acceleration.x = 0;
        }

		//salto
		//if(! (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN ))
		if(FlxG.keys.justPressed.SPACE && (wasTouching & FlxObject.FLOOR) != 0) {
			y--;
			velocity.y = -GRAVEDAD*4;
		}

		if(FlxG.keys.justPressed.E) {
			var ggg:flixel.addons.effects.chainable.FlxGlitchEffect = new flixel.addons.effects.chainable.FlxGlitchEffect();
			ggg.apply(this.pixels);
			ggg.active = true;
		} 
		
		
		/*
		if (FlxG.keys.justPressed.F && tiempoDesdeUltimoDisparo >= COOLDOWN) {
			//disparar();
			if(paraguas != null) {
				paraguas.abrirCerrar();
			}
		}
		*/
		
        if (Math.abs(velocity.x) < 3) {
			if(!enElAire) animation.play("quieto");
		}
		else {
			if(!enElAire) animation.play("caminando");	
		}
		
/*
		if (paraguas != null) {
			//paraguas.x = x + width*0.5;
			paraguas.x = x;
			paraguas.y = y - height*0.2;
		}
*/
    }

	private function disparar() {
		tiempoDesdeUltimoDisparo = 0;
		
		var nuevoProyectil = proyectiles.recycle(Proyectil);	
		
		var escala = (this.width/2) / nuevoProyectil.width;
		nuevoProyectil.scale.set(escala, escala);
		
		if (flipX) {
			nuevoProyectil.reset( x - (this.width / 2), y + (width / 2) );
			nuevoProyectil.velocity.x = -VEL_PROYECTIL;
		} else {
			nuevoProyectil.reset( x + this.width, y + (width / 2) );
			nuevoProyectil.velocity.x = VEL_PROYECTIL;
		}
		
	}
	
	public function getEnergia() {
		return ENERGIA;
	}
	
	public function addEnergia() {
		if(ENERGIA < MAX_ENERGIA) {
			ENERGIA++;
		}
	}
	
	public function setParaguas() {
		//paraguas = new Paraguas(0,0,height*0.75);
		paraguas = new Paraguas(0,0,height*0.9);
		FlxG.state.add(paraguas);
	}
	
	public function estaLastimado() {
		return lastimado;
	}
	
    private inline static var CHAR_ACCEL: Float     = 300;
    private inline static var CHAR_MAXVEL: Float	= 300;
    private inline static var CHAR_DRAG: Float      = 0;
	private inline static var GRAVEDAD: Float 		= 300;
	
	public  static var proyectiles(default, null): FlxTypedGroup<Proyectil>;
	
	private var tweenParpadeo: FlxTween;
	public var lastimado:Bool = false;
	private var tiempoParpadeo: Float = 0;
	private var tiempoInvencible: Float = 1.0;
	
	private var VEL_PROYECTIL : Float = 150.0;
	private var tiempoDesdeUltimoDisparo: Float = 0;
	private var COOLDOWN = 1 / 3;
	
	private var ENERGIA: Int;
	private var MAX_ENERGIA: Int = 3;
	
	private var enElAire:Bool;
	
	private var paraguas: Paraguas;
	
	
	private var xMax:Int;
	private var yMax:Int;

	public var gg:flixel.addons.effects.chainable.FlxGlitchEffect;
	
}