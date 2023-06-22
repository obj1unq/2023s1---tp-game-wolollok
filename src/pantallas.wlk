import wollok.game.*
import canion.*
import naves.*
import balas.*
import posDir.*
import score.*
import nombre.*
import pantallaInicial.*
import pantallaEleccion.*
import pantallaPerder.*

object actual {

	var property pantalla = null
	var property nivel = nivel3
	
	method nivelActual() {
		return nivel.numero()
	}
	
	method indicador() {
		return pantalla.indicador()
	}
}


class Pantalla {
	const property position = new Posicion(x = 0, y = 0)
	
	method iniciar() {
		actual.pantalla(self)
		game.addVisual(self)
	}
}

class Fondo inherits Pantalla {
	const property indicador
	const property image
	
	override method iniciar() {
		super()
		game.addVisual(indicador)
	}
}
object pantallaInicial inherits Fondo(indicador = puntero, image = "fondoPantallaInicial.jpg"){
	
	override method iniciar() {
		game.clear()
		super()
		game.addVisual(spaceInvaders)
		game.addVisual(iniciarJuego)
		game.addVisual(comoJugar)
		game.addVisual(wolollok)
	
		keyboard.up().onPressDo({puntero.subir()})
		keyboard.down().onPressDo({puntero.bajar()})
		keyboard.enter().onPressDo({actual.indicador().iniciar(game.uniqueCollider(actual.indicador()))})
	}
	
	method reiniciarJuego() {
		game.clear()
		gestorDeVidas.vidas([uno, dos, tres])
		score.puntaje(100000)
		self.iniciar()
	}
}

object pantallaNombre inherits Fondo(indicador = punteroNombre, image = "fondoNombre.png"){

	override method iniciar() {
		super()
		game.addVisualIn(nombre, new Posicion(x = 14, y = 13))
		nombre.iniciarTeclas()
	}
}
object pantallaEleccion inherits Fondo(indicador = puntero2, image = "fondoEleccion.png") {
	
	override method iniciar() {
		super()
		game.addVisual(canionNormal)
		game.addVisual(canionRosa)
		game.addVisual(canionDorado)
		game.addVisual(canionVerde)
		game.addVisual(canionNaranja)
		game.addVisual(canionAzul)
		
		keyboard.left().onPressDo({ puntero2.moverIzquierda() })
		keyboard.right().onPressDo({ puntero2.moverDerecha() })
	}
}


class Nivel inherits Pantalla {
	const property numero
	const property image = "fondo" + numero + ".jpg"
	const tiempoMover	

	override method iniciar() {
		game.sound("musicaInGame.mp3").play()
		game.clear()
    	super()
		actual.nivel(self)
		factories.forEach{ factory => factory.construirNaves()}
		gestorDeVidas.inicializarVidas()
		game.schedule(1000, { balaNave.nuevoDisparo()})
		movimiento.mover(ovnis, tiempoMover)
			// VISUALES
		game.addVisual(canion)
		game.addVisual(nombre)
		ovnis.forEach{ ovni => game.addVisual(ovni)}
		scoreCompleto.forEach{ puntaje => game.addVisual(puntaje)}
			// HECHOS CASUALES
		game.schedule(30000, { naveAleatoria.aparecer()})
			// CONTROLES
		keyboard.left().onPressDo{ canion.mover(izquierda)}
		keyboard.right().onPressDo{ canion.mover(derecha)}
		keyboard.space().onPressDo{ canion.disparar()}
		
}
	method serDaniado(objeto) {}
}

object nivel1 inherits Nivel(numero = 1, tiempoMover = 2500) {}

object nivel2 inherits Nivel(numero = 2, tiempoMover = 1750){}


object nivel3 inherits Nivel(numero = 3, tiempoMover = 1000) {
	override method iniciar() {
		super()
		game.schedule(50000, { naveAleatoria.aparecer()})
	  }
}

object pantallaGanaste {
	
}
object fondoPerder {
	var property image = "fondoPantallaInicial.jpg"
	const property position = new Position(x = 0, y = 0)
	method iniciar() {
		ovnis.clear()
		balaCanion.eliminarse()
		balaNave.eliminarse()
		game.removeTickEvent("moverOvnis")
		game.clear()
		game.addVisual(self)
		corazonPerder.animacion()
	}	
}
	

object gameOver inherits Pantalla {

	const property image = "gameOver.jpg"

	override method iniciar(){
		game.clear()
		game.addVisual(self)
		scoreCompleto.forEach{ puntaje => puntaje.puntajeFinal()}
		keyboard.r().onPressDo{ pantallaInicial.reiniciarJuego()}
		keyboard.e().onPressDo{ game.stop()}
	}

}

