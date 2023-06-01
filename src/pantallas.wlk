import wollok.game.*
import canion.*
import naves.*
import balas.*
import posDir.*
import score.*
import nombre.*

object pantallaNombre {
	
	const property image = "fondoNombre.jpg"
	const property position = new Posicion ( x = 0, y = 0)
	
	method iniciar(){
		game.addVisual(self)
		game.addVisualIn(nombre, new Posicion ( x = 14, y = 13))
		nombre.iniciarTeclas()
	}
	
	method siguientePantalla(){
		game.clear()
		nivel1.iniciar()
	}
	
}

object nivel1 {
	
	const property image = "fondo1.jpg"
	const property position = new Posicion ( x = 0, y = 0)
	
	method iniciar(){
		
		game.addVisual(self)
		factories.forEach{factory => factory.construirNaves()}
		gestorDeVidas.inicializarVidas()
		game.schedule(500, {balaNave.nuevoDisparo()})
		movimiento.mover(ovnis)
		
		//	VISUALES
		
		game.addVisual(canion)
		game.addVisual(nombre)
		ovnis.forEach{ovni => game.addVisual(ovni) }
		scoreCompleto.forEach{puntaje => game.addVisual(puntaje)}

		
		// HECHOS CASUALES
		game.onTick(10000, "Agregar nave aleatoria", {naveAleatoria.aparecer()})
		
		//  CONTROLES

		keyboard.left().onPressDo { canion.mover(izquierda) }
		keyboard.right().onPressDo { canion.mover(derecha) }
		keyboard.space().onPressDo {canion.disparar()}
	}
}

object gameOver {
	
	const property image = "gameOver.jpg"
	const property position = new Posicion ( x = 0, y = 0)
	
	method iniciar(){
		balaCanion.eliminarse()
		balaNave.eliminarse()
		game.removeTickEvent("moverOvnis")
		game.removeTickEvent("Agregar nave aleatoria")
		game.clear()
		ovnis.clear()
		game.addVisual(self)
		scoreCompleto.forEach{puntaje => puntaje.puntajeFinal()}
		
		keyboard.r().onPressDo { pantallaNombre.siguientePantalla() }
		keyboard.e().onPressDo { game.stop() }
	}
}