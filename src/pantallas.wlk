import wollok.game.*
import canion.*
import naves.*
import balas.*
import direcciones.*
import score.*
import nombre.*

object pantallaNombre {
		
	method iniciar(){
		
		game.boardGround("fondoNombre.jpg")
		game.addVisualIn(nombre, game.at(15,15))
	}
	
}

object nivel1 {
	
	method iniciar(){
		
		game.boardGround("fondo1.jpg")
		game.schedule(500, {balaNave.nuevoDisparo()})
		movimiento.mover(ovnis)
		
		//	VISUALES
		
		game.addVisual(canion)
		game.addVisual(vidas)
		ovnis.forEach{ovni => game.addVisual(ovni) }
		scoreCompleto.forEach{puntaje => game.addVisual(puntaje)}
		
		//  CONTROLES

		keyboard.left().onPressDo { canion.mover(izquierda) }
		keyboard.right().onPressDo { canion.mover(derecha) }
		keyboard.space().onPressDo {canion.disparar()}
	}
}