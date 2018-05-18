import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.FlxCamera;
import flixel.util.FlxColor;

class Selector extends FlxState
{	
	override public function create():Void
	{
		super.create();		

		
		//grupo de niveles
		nivelesGroup = new Array<PaseNivel>();

		//el mapa de tiles, inicial
		tiledMap = new TiledMap("assets/data/levels/indice.tmx");
		
		//leo todos los objetos del mapa
		for (group in tiledMap.objectGroups)
		{
			for (o in group.objects)
			{
				switch (o.name.toLowerCase()) {
					case "nivel": nivelesGroup.push(new PaseNivel(0,0,0, o.custom.get("archivo"), o.custom.get("nombre") ));
				}
				
			}
		}
		
		texto = new FlxText(0, 0, FlxG.width, "");
		texto.setFormat(null, FlxG.height / 10, FlxColor.BLACK, "center");
		texto.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.WHITE, 4);
		FlxG.state.add(texto);
		
		maxNiveles = nivelesGroup.length;
		
		texto.text = "Seleccione nivel\n" + "# " + nivelesGroup[iterador].getNumero() + "\n" + nivelesGroup[iterador].getNombre();
		
		flechaIzquierda = new FlxSprite(0, FlxG.height/2 - 40, "assets/images/izquierda.png");
		flechaDerecha = new FlxSprite(FlxG.width-80, FlxG.height/2 - 40, "assets/images/derecha.png");
		
		add(flechaIzquierda);
		add(flechaDerecha);
		
		flechaIzquierda.visible = false;
		
	}


	
	override public function update():Void
	{
		super.update();
		
		var i = iterador;
		
		if(FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) {
			if(iterador > 0 ) {
				iterador--;
			}
        }
		
		if(FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) {
			if(iterador < maxNiveles -1 ) {
				iterador++;
			}
        }
		
		if(FlxG.keys.pressed.F) {
			Reg.nivelActual = nivelesGroup[iterador].getArchivo();
			FlxG.switchState(new PlayState());
        }
		
		if(i != iterador) {
			texto.text = "Seleccione nivel\n" + "# " + nivelesGroup[iterador].getNumero() + "\n" + nivelesGroup[iterador].getNombre();
			
			flechaIzquierda.visible = true;
			flechaDerecha.visible = true;
			
			if(iterador == 0) {
				flechaIzquierda.visible = false;
			}
		
			if(iterador == maxNiveles -1) {
				flechaDerecha.visible = false;
			}
		}
				
	}

	//MODIFICAR

  
	private var tiledMap: TiledMap;
	private var nivelesGroup: Array<PaseNivel>;	
	private var texto : FlxText;
	private var flechaIzquierda : FlxSprite;
	private var flechaDerecha : FlxSprite;
	private var iterador : Int = 0;
	private var maxNiveles : Int;

}