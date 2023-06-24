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

object soundProducer {
	
	var provider = game
	
	method provider(_provider){
		provider = _provider
	}
	
	method sound(audioFile) = provider.sound(audioFile)
	
}

object soundProviderMock {
	
	method sound(audioFile) = soundMock
}

object soundMock {
	method play() {}
}

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
	
	method eliminarse() {
		game.removeVisual(self)
	}

}

object pantallaInicial inherits Fondo(indicador = puntero, image = "fondoPantallaInicial.jpg") {

	override method iniciar() {
		game.clear()
		super()
		game.addVisual(spaceInvaders)
		game.addVisual(iniciarJuego)
		game.addVisual(comoJugar)
		game.addVisual(wolollok)
		indicador.iniciarTeclas()
		keyboard.enter().onPressDo({ actual.indicador().iniciar(game.uniqueCollider(actual.indicador()))})
	}

	override method eliminarse() {
		game.removeVisual(spaceInvaders)
		game.removeVisual(iniciarJuego)
		game.removeVisual(comoJugar)
		game.removeVisual(wolollok)
		game.removeVisual(indicador)
		super()
	}

	method reiniciarJuego() {
		game.clear()
		gestorDeVidas.vidas([ uno, dos, tres ])
		score.puntaje(100000)
		self.iniciar()
	}

}

object pantallaNombre inherits Fondo(indicador = punteroNombre, image = "fondoNombre.png") {

	override method iniciar() {
		super()
		game.addVisualIn(nombre, new Posicion(x = 14, y = 13))
		nombre.iniciarTeclas()
	}

	override method eliminarse() {
		super()
		game.removeVisual(nombre)
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
		keyboard.left().onPressDo({ puntero2.moverIzquierda()})
		keyboard.right().onPressDo({ puntero2.moverDerecha()})
	}

}

object pantallaSiguienteNivel inherits Fondo(indicador = punteroSigNivel, image = "fondoPantallaInicial.jpg") {
	override method iniciar() {
		game.clear()
		super()
		game.addVisual(iniciarJuego)
		game.addVisual(seleccionarNave)
		game.addVisual(nivelCompletado)
		indicador.iniciarTeclas()
		
		keyboard.enter().onPressDo({ actual.indicador().iniciar(game.uniqueCollider(actual.indicador()))})
	}
	
	override method eliminarse() {
		super()
		game.removeVisual(indicador)
		game.removeVisual(iniciarJuego)
		
		game.removeVisual(seleccionarNave)
	}
}

class Nivel inherits Pantalla {

	const property numero
	const property image = "fondo" + numero + ".jpg"
	const tiempoMover

	override method iniciar() {
		soundProducer.sound("musicaInGame.mp3").play()
		game.clear()
		super()
		actual.nivel(self)
		factories.forEach{ factory => factory.construirNaves()}
		gestorDeVidas.inicializarVidas()
		game.schedule(1000, { balaNave.nuevoDisparo()})
		movimiento.mover(tiempoMover)
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
	method siguienteNivel()
	method siguienteNivelSetear() {
		actual.nivel(self.siguienteNivel())
		pantallaSiguienteNivel.iniciar()
	}
	method serDaniado(objeto) {}
}

object nivel1 inherits Nivel(numero = 1, tiempoMover = 2500) {
	override method siguienteNivel() = nivel2
}

object nivel2 inherits Nivel(numero = 2, tiempoMover = 1750){
	override method siguienteNivel() = nivel3
}

object nivel3 inherits Nivel(numero = 3, tiempoMover = 1000) {

	override method iniciar() {
		super()
		game.schedule(50000, { naveAleatoria.aparecer()})
	  }
	
	override method siguienteNivelSetear() {
		pantallaGanaste.iniciar()
	} 
	override method siguienteNivel() {}
	}

class PantallaDerrota inherits Pantalla {
	override method iniciar() {
		game.clear()
		super()
		scoreCompleto.forEach{ puntaje => puntaje.puntajeFinal()}
		
		keyboard.r().onPressDo{ pantallaInicial.reiniciarJuego()}
		keyboard.e().onPressDo{ game.stop()}
		
	}
}
object pantallaGanaste inherits PantallaDerrota {
	const property image = "gameWin.png"
	override method iniciar() {
		super()
		actual.nivel(nivel1)
	}
}

object fondoPerder {

	var property image = "fondoPantallaInicial.jpg"
	const property position = new Position(x = 0, y = 0)
	var property formaDePerder = naveEnLaTierra

	method iniciar() {
		ovnis.clear()
		balaCanion.eliminarse()
		balaNave.eliminarse()
//		game.removeTickEvent("moverOvnis")
		game.clear()
		game.addVisual(self)
		formaDePerder.animacion()
	}

}

object gameOver inherits PantallaDerrota {
	const property image = "gameOver.png"
}