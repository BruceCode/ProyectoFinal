import flixel.addons.effects.FlxWaveSprite;
import flixel.FlxObject;
import flixel.group.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;

class EnemigoGelatina extends Enemigo {

    public function new (X: Float = 0, Y: Float = 0, tamanio:Float = 0) {
        super(X, Y);
		
		//FlxG.log.add("1- parametros" + X + " " + Y + " - objeto " + this.x + " " + this.y);
		
		//Graficos y animaciones
		loadGraphic("assets/images/enemigo4.png", true, 51, 28);
		animation.add("caminar", [0, 1], 5, true);
		animation.play("caminar");
		
		setEscala(tamanio);
		
		setVelocidad(tamanio);
		//podria formar parte de la escala y me olvido de todo
		
		//Para que se de cuenta donde termina el suelo
		
		var ps:PlayState = cast( FlxG.state, PlayState);
		level = ps.getLevel();
		
		this.xMax = ps.getXMax();
		this.yMax = ps.getYMax();
		
		anchoTile = level.width/level.widthInTiles;
		altoTile = level.height / level.heightInTiles;

		//Esto es para que caiga y se acomode al nivel
		velocity.y = velocidad * 2;
		
		//Empieza en sentido izquierdo
		velocity.x = -velocidad;
		
		//Un efecto de transparencia
		alpha = 0.9;
		FlxTween.tween(this, { "alpha" : 0.75 }, 0.5, {  type:FlxTween.PINGPONG } );
		
		//FlxG.log.add("2- parametros" + X + " " + Y + " - objeto " + this.x + " " + this.y);
    }
	
	
	override public function resuelve() {
		
		var ps:PlayState = cast( FlxG.state, PlayState);
		var pj = ps.getHeroe();
		
		var angulo = FlxAngle.getAngle(new FlxPoint(pj.getMidpoint().x, pj.y + pj.height) , new FlxPoint(this.getMidpoint().x , this.y + this.height));
		// si lo chocamos por arriba muere, sino el que muere es el personaje
		if( Math.abs(angulo) > (90 + 30 ) ) {
			this.lastimar();
			ps.textoInformativo.setTexto(this.getDialogoAtacado());
		}
		else {
			pj.lastimar();
			ps.energiaHeroe();
			ps.textoInformativo.setTexto(this.getDialogoAtaque());
			
			if(pj.getMidpoint().x > this.getMidpoint().x) {
				pj.velocity.x = 50;
			}
			else {
				pj.velocity.x = -50;
			}
		}
	
	}
	
	
	override public function update():Void {
		
			super.update();
			
			//llega al borde y pega la vuelta
			//si hay pared, también se da vuelta
			if (velocity.y == 0) {
				if(!flipX) {
					if ( level.getTile( Std.int(x / anchoTile), Std.int((y + height ) / altoTile)  ) == 0 
					|| (wasTouching & FlxObject.WALL) != 0 || this.x < 0 ) {
						set_flipX(true);
						velocity.x = 50;
						x++;
					}
					
				}
				else {
					if ( level.getTile( Std.int( (x + width) / anchoTile), Std.int((y + height ) / altoTile) ) == 0 
					|| (wasTouching & FlxObject.WALL) != 0 || (this.x +  this.width) > this.xMax ) {
						set_flipX(false);
						velocity.x = -50;
						x--;
					}
				}
			}
			
	}

	override public function lastimar() {
		allowCollisions = 0;
		velocity.x = 0;
		var tween = FlxTween.tween(this, { "y" : y + height/2  }, 0.5, {  complete:tweenCompleto } );
	}

	public function tweenCompleto(tween: FlxTween) {
		kill();
	}

	
	private var level: FlxTilemap;
	private var anchoTile: Float;
	private var altoTile: Float;
	
	private var xMax:Int;
	private var yMax:Int;

}