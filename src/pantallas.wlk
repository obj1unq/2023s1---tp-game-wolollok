import wollok.game.*
import canion.*
import naves.*
import balas.*
import direcciones.*
import score.*
import nombre.*

object pantallaNombre {
	
	const property image = "fondoNombre.jpg"
	const property position = game.at(0,0)
	
	method iniciar(){
		game.addVisual(self)
		game.addVisualIn(nombre, game.at(14,13))
		nombre.iniciarTeclas()
	}
	
	method siguientePantalla(){
		game.clear()
		nivel1.iniciar()
	}
	
}

object nivel1 {
	
	const property image = "fondo1.jpg"
	const property position = game.at(0,0)
	
	method iniciar(){
		
		game.addVisual(self)
		game.schedule(500, {balaNave.nuevoDisparo()})
		movimiento.mover(ovnis)
		
		//	VISUALES
		
		game.addVisual(canion)
		game.addVisual(vidas)
		game.addVisual(nombre)
		ovnis.forEach{ovni => game.addVisual(ovni) }
		scoreCompleto.forEach{puntaje => game.addVisual(puntaje)}
		
		// HECHOS CASUALES
		game.onTick(20000, "Agregar nave aleatoria", {naveAleatoria.aparecer()})
		
		//  CONTROLES

		keyboard.left().onPressDo { canion.mover(izquierda) }
		keyboard.right().onPressDo { canion.mover(derecha) }
		keyboard.space().onPressDo {canion.disparar()}
	}
}