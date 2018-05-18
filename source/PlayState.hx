import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.system.scaleModes.StageSizeScaleMode;
import flixel.text.FlxText;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;


import flixel.group.FlxGroup;
//import flixel.group.FlxTypedGroup;
//import flixel.addons.editors.tiled.TiledObject;
//import flixel.addons.editors.tiled.TiledObjectGroup;
//import flixel.addons.editors.tiled.TiledObjectLayer;

import flixel.FlxCamera;
import flixel.math.FlxAngle;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;



/**
* asd 
* @autor joseles
*/

class PlayState extends FlxState
{	
	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;
		//openSubState(new Intro());
		
		var next = false;
		
		//el nivel solido, con el que colisiona
		//var level = new FlxTilemap();
		//para que el fondo tenga cierto encanto
		//var levelFondo = new FlxTilemap();
		//el nivel solido sólo desde arriba
		//var levelOneWay = new FlxTilemap();
		
		//grupo de enemigos
		var enemigosSuperGrupo = new FlxGroup();


		
		//grupo de objetos
		//energiaGroup = new FlxTypedGroup<Energia>();
		//espinaGroup = new FlxTypedGroup<Espina>();
		
		//objetos que al colisionarlos nos hace pasar a otro nivel
		//nivelesGroup = new FlxTypedGroup<PaseNivel>();
		
		//A definir
		//Proyectiles
		//proyectilesEnemigosGroup = new FlxTypedGroup<Proyectil>();
		
		//el mapa de tiles, el primero está hardcodeado
		Reg.nivelActual = 'fase' + Reg.nivel + '.tmx';

		tiledMap = new TiledMap("assets/data/levels/" + Reg.nivelActual);

		//capas
		var layerSolido : TiledTileLayer = cast tiledMap.getLayer("solido");
		var layerFondo : TiledTileLayer = cast tiledMap.getLayer("fondo");
		var layerOneWay : TiledTileLayer = cast tiledMap.getLayer("oneway");
		
		//tileset, imagen que conoce el layer solido; cada capa podría tener su imagen
		var tileset = "assets/images/" + layerSolido.properties.get("imagen");

		//Capa que contiene tiles de fondo, no collisiona
		
		if(layerFondo != null) {
			FlxG.log.add("layerFondo");
			levelFondo.loadMapFromArray(layerFondo.tileArray , tiledMap.width, tiledMap.height, tileset, tiledMap.tileWidth, tiledMap.tileHeight, flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling.OFF, 1);


			var tiles = new Array();
			//Recorro los tiles y guardo los valores sin repetir
			for (tile in layerFondo.tileArray) {
				//Si no está en el aray y el tile es distinto de 0
				if( tiles.indexOf(tile) == -1 && tile != 0 ) {
					tiles.push(tile);
				}
			}
			//Aplico la configuración a todos los tiles de la capa
			for (tile in tiles) {
				levelFondo.setTileProperties(tile, FlxObject.NONE);
			}


			
			add(levelFondo);
		}
		
		//Capa que contiene tiles que son colisionables sólo desde arriba
		if(layerOneWay != null) {

			levelOneWay.loadMapFromArray(layerOneWay.tileArray , tiledMap.width, tiledMap.height, tileset, tiledMap.tileWidth, tiledMap.tileHeight, flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling.OFF, 1);

			var tiles = new Array();
			//Recorro los tiles y guardo los valores sin repetir
			for (tile in layerOneWay.tileArray) {
				if( tiles.indexOf(tile) == -1 && tile != 0 ) {
					tiles.push(tile);
				}
			}
			//Aplico la configuración a todos los tiles de la capa
			for (tile in tiles) {
				levelOneWay.setTileProperties(tile, FlxObject.UP);
			}

			add(levelOneWay);
		}
		
		//Capa principal
		//level.loadMapFromArray(layerSolido.tileArray , tiledMap.width, tiledMap.height,  layerSolido.properties.get("imagen"), tiledMap.tileWidth, tiledMap.tileHeight);
		level.loadMapFromArray(layerSolido.tileArray , tiledMap.width, tiledMap.height,  tileset, tiledMap.tileWidth, tiledMap.tileHeight, flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling.OFF, 1);
		add(level);

		this.xMax = tiledMap.width * tiledMap.tileWidth;
		this.yMax = tiledMap.height * tiledMap.tileHeight;
		



		//leo todos los objetos del mapa



		/*
		for (group in tiledMaobjectGroups)
		
		{
			for (o in group.objects)
			{
				if( o.type == "enemigo".toLowerCase()){
					switch (o.name.toLowerCase()) {
						case "gelatina" :
						//ajustar tamaño y donde inician por tamaño tile proporcion
						var e = new EnemigoGelatina(o.x, o.y, tiledMap.tileHeight * 1);
						e.setDialogoAtaque(o.custom.get("dialogoAtaque"));
						e.setDialogoAtacado(o.custom.get("dialogoAtacado"));
						e.setVelocidad( Std.parseFloat(o.custom.get("velocidad")) );
						enemigosSuperGrupo.add(e);
						
					}
				}
				
				//segun el nombre, agrego el elemento al grupo correspondiente
				//hay diferencias en el sistema coordenado del eje y, por eso el ajuste
				switch (o.name.toLowerCase()) {
					case "player": heroe = new Heroe(o.x, o.y, tiledMap.tileWidth *1);
					
					
				}
			}
		}//objetos
		*/
		FlxG.log.add("FAlla");
		add(nivelesGroup);
		
		add(enemigosSuperGrupo);

		//add(energiaGroup);
		//add(espinaGroup);
		
		//los protectiles
		//add(Enemigo1.proyectiles);

		//el PJ
		heroe = new Heroe(10, 10, tiledMap.tileWidth *1);
		add(heroe);
		//add(Heroe.proyectiles);
		/*
		if(tiledMap.properties.get("ajusteAncho") != null)
			ajusteZoom(Std.parseInt(tiledMap.properties.get("ajusteAncho")), Std.parseInt(tiledMap.properties.get("ajusteAlto")));
		*/
		
		//ajuste de camara
		//FlxG.camera.follow(heroe, FlxCamera.STYLE_PLATFORMER);
		//FlxCamera.setScrollBoundsRect(0, 0, level.width, level.height, true);
		//FlxG.camera.setScrollBoundsRect(0, 0, level.width, level.health, true);

//FlxG.camera.setScrollBoundsRect(0, 0, 800, 600, true);
FlxG.camera.setScrollBoundsRect(0, 0, level.width, level.height, true);

		 
		//FlxG.camera.follow(heroe, FlxCameraFollowStyle.PLATFORMER);
		//ajusteZoom();
		

		//GUI/HUD para mostrar la cantidad de energia del PJ
		//indicadorVidas = new IndicadorVidas();
		//indicadorVidas.setEscala(tiledMap.tileWidth);
		//energiaHeroe();
		
		//textoInformativo = new TextoInformativo();
		//textoInformativo.setPosition(0, tiledMap.tileHeight, tiledMap.tileHeight/2);
		
		//textoInformativo.setTexto(tiledMap.properties.get("titulo"));
		
	}

	override public function update(elapsed):Void
	{
		super.update(elapsed);
		/*
		//Para la pausa
		if (FlxG.keys.justPressed.P) {
			openSubState(new Pausa());
		}
		*/
		/*
		if (FlxG.keys.pressed.N) {
			FlxG.camera.shake(0.01, 0.1);
		}
		*/
		/*
		if (FlxG.keys.pressed.M) {
			FlxG.camera.flash(FlxColor.WHITE, 0.1);
		}
		*/
		
		if (FlxG.keys.justPressed.B) {
			//ajusteZoom(16,12);
			ajusteZoom();
			//nextLevel();
		}
		
		if (FlxG.keys.pressed.A) {
			moverCamaraLateral(false);
		}

		if (FlxG.keys.pressed.D) {
			moverCamaraLateral(true);
		}

		if (FlxG.keys.pressed.W) {
			moverCamaraVertical(false);
		}

		if (FlxG.keys.pressed.S) {
			moverCamaraVertical(true);
		}

		if (FlxG.keys.justPressed.F) {
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		
		//if (! ( (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S) && FlxG.keys.pressed.ALT) ) {
		if (! (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S) ) {
			FlxG.collide(levelOneWay, heroe);
		}
		
		
		//el nivel es fijo y el personaje lo choca
		FlxG.collide(level, heroe);
		FlxG.collide(level, enemigosSuperGrupo);
		
		//FlxG.overlap(heroe, enemigosSuperGrupo , resuelveImpactoHeroeEnemigos);
		FlxG.overlap(heroe, enemigosSuperGrupo , resuelveImpactoHeroeEnemigos);
		
		//los proyectiles chochan con el nivel, ¿entonces?
		//la velocidad del proyectil es cero, vease el método update del proyectil
		//FlxG.collide(level, Enemigo1.proyectiles);
		//FlxG.collide(level, Heroe.proyectiles);
		
		//Impacto de los proyectiles enemigos con el Heroe
		//FlxG.overlap(heroe, Enemigo1.proyectiles, resuelveImpactoHeroe);
		/*
		FlxG.collide(heroe, espinaGroup, espina);
		FlxG.overlap(heroe, energiaGroup, addEnergia);		
		FlxG.overlap(heroe, paraguas, setParaguas);
		FlxG.overlap(heroe, nivelesGroup, resuelveNivel);
		*/
		
		//if (enemigosSuperGrupo.countLiving() == 0 && !next ) { nextLevel(); next = true; }
		
	}
	
	/*
	private function resuelveNivel(pj: Heroe, nivel:PaseNivel) {
		Reg.nivelActual = nivel.getArchivo();
		FlxG.camera.fade(0x000000, 0.25, false, cargarNivel);
	}
	*/

	
	private function resuelveImpactoHeroeEnemigos(pj: Heroe, enemigo:Enemigo) {
		enemigo.resuelve();
	}
	
	/*
	private function espina(heroe:Heroe, e:Espina) {
		heroe.lastimar();
		energiaHeroe();
		
		//Depende de por donde pinchen al PJ, este reacciona en sentido opuesto	
		if(heroe.x > e.x) {
			heroe.velocity.x = 50;
		}
		else {
			heroe.velocity.x = -50;
		}
		
		if(heroe.y > e.y) {
			heroe.velocity.y = 50;
		}
		else {
			heroe.velocity.y = -50;
		}
	}
	*/
	/*
	private function resuelveImpactoHeroe(pj: Heroe, proyectil:Proyectil) {
		pj.lastimar();
		energiaHeroe();
		proyectil.kill();
		//lo siguiente es para darle un efecto de retroceder
		//en el sentido opuesto al impacto
		if(pj.x > proyectil.x) {
			pj.velocity.x = 50;
		}
		else {
			pj.velocity.x = -50;
		}
	}
	*/
	
	/*
	private function addEnergia(heroe:Heroe, e:Energia) {
		e.lastimar();
		heroe.addEnergia();
		energiaHeroe();
	}
	*/
	
	public function getLevel() {
		return level;
	}
	
	public function getHeroe() {
		return heroe;
	}
	
	public function getTileWidth() {
		return tiledMap.tileWidth;
	}
	
	public function energiaHeroe() {
		if( heroe.getEnergia() <= 0) {
			FlxG.camera.fade(0xffffffff, 0.5, false, cargarNivel);
		}
		
		indicadorVidas.setTexto( "x "  + heroe.getEnergia() );
	}

	/*
	private function setParaguas(heroe:Heroe, paraguas:Paraguas) {
		paraguas.kill();
		heroe.setParaguas();		
		textoInformativo.setTexto(paraguas.getScript());
	}
	*/
	
	//MODIFICAR
	private function cargarNivel()	{
		FlxG.switchState(new PlayState());
	}
  
	
	private function moverCamaraLateral(derecha:Bool) {
		if(derecha)
			FlxG.camera.x += 1;
		else 
			FlxG.camera.x -= 1;
	}

	private function moverCamaraVertical(abajo:Bool) {
		if(abajo)
			FlxG.camera.y += 1;
		else 
			FlxG.camera.y -= 1;
	}

	/**
	 * Ajusta la camara a los caprichos de cuantos tiles quiero ver.
	 * Por defecto mostrará todo el nivel
	 * 
	 * con parámetros 0,0 mapa completo
	 * !0 tomará el valor mayor, por ancho o alto del mapa
	 * 
	 * @param	ancho	ancho en tiles.
	 * @param	alto	alto en tiles.
	 */
	private function ajusteZoom(ancho:Int=0, alto:Int=0) {
		FlxG.scaleMode = new StageSizeScaleMode();
		//Mapa completo
		if (ancho == 0 && alto == 0) {
			ancho = Std.int(level.width);
			alto = Std.int(level.height);

			if(ancho < alto) {
				FlxG.log.add("--- mas alto");
				var z = FlxG.width / ancho;
				var z = FlxG.height / alto;
				FlxG.camera.zoom = z;	
				FlxG.camera.setSize(ancho, alto);
				FlxG.log.add("Camera antes " + FlxG.camera.x + " " + FlxG.camera.y);
				FlxG.camera.setPosition(FlxG.width - ancho, FlxG.height - alto);
			}
			else {
				FlxG.log.add("--- mas ancho");
				var z = FlxG.height / alto;
				var z = FlxG.width / ancho;
				FlxG.camera.zoom = z;
				FlxG.camera.setSize(ancho, alto);
				FlxG.log.add("Camera antes " + FlxG.camera.x + " " + FlxG.camera.y);
				//FlxG.camera.setPosition(FlxG.width - ancho, Std.int((FlxG.height - alto)/2) * -1);
				FlxG.camera.setPosition(FlxG.width - ancho, FlxG.height - alto);
				
			}
			
		FlxG.log.add("FlxG " + FlxG.width + " " + FlxG.height);
		FlxG.log.add("Level " + ancho + " " + alto);
		FlxG.log.add("Camera " + FlxG.camera.x + " " + FlxG.camera.y);

		}//Por ancho o alto completo
	
		else {
			ancho = ancho * tiledMap.tileWidth;
			alto = alto * tiledMap.tileHeight;
			
			if(ancho > alto) {
				var z = FlxG.width / ancho;
				FlxG.camera.zoom = z;	
				FlxG.camera.setSize(ancho, Std.int(ancho*3/4));
			}
			else {
				var z = FlxG.height / alto;
				FlxG.camera.zoom = z;
				FlxG.camera.setSize(Std.int(alto*4/3), alto);
			}
		}

		FlxG.scaleMode = new StageSizeScaleMode();
		FlxG.scaleMode = new flixel.system.scaleModes.FillScaleMode();
	}//ajusteZoom
	
	//private var paraguas: Paraguas;
	public var heroe: Heroe;
	public var tiledMap: TiledMap;
	private var level: FlxTilemap = new FlxTilemap();
	private var levelFondo: FlxTilemap = new FlxTilemap();
	private var levelOneWay: FlxTilemap = new FlxTilemap();
	
	
	private var enemigosSuperGrupo:FlxGroup;
	
	//private var bossAbeja : BossAbeja;
	//private var bossGelatina : EnemigoBossGelatina;
	
	//private var energiaGroup: FlxTypedGroup<Energia>;
	//private var espinaGroup: FlxTypedGroup<Espina>;
	
	private var nivelesGroup: FlxTypedGroup<PaseNivel>;
	private var indicadorVidas : IndicadorVidas;
	public var textoInformativo : TextoInformativo;
	
	private var xMax : Int;
	private var yMax : Int;
	
	public function getXMax(){
		return this.xMax;
	}
	
	public function getYMax(){
		return this.yMax;
	}
	
	private var proyectilesEnemigosGroup : FlxTypedGroup<Proyectil>;
	
	private var next:Bool;
	
	private function nextLevel() {
		FlxG.log.add('nivel antes' + Reg.nivel );
		if ( Reg.nivel < Reg.cantidadNiveles ) { 
			Reg.nivel += 1 ; 
			FlxG.log.add('nivel despues' + Reg.nivel );
			FlxG.camera.fade(0x000000, 0.25, false, cargarNivel);
		} else {
			FlxG.switchState(new Fin());
		}

	}
}