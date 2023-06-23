import wollok.game.*
import canion.*
import naves.*
import posDir.*
import score.*
import pantallas.*
import pantallaInicial.*

object puntero2 {
	const property image = "puntero2.png"
	var property position = canionNormal.position()
	var property apuntables = [canionRosa, canionAzul, canionNaranja, canionVerde, canionDorado, canionNormal]
	
	method moverDerecha() {
		position = apuntables.get(0).position()
		apuntables =  apuntables.drop(1) + [apuntables.first()]
		game.sound("mover.mp3").play()
	}
	
	method moverIzquierda() {
		position = apuntables.get(4).position()
		apuntables = [apuntables.last()] + apuntables.take(5)
		game.sound("mover.mp3").play()
	}
	
	method iniciar(colorDeCanion) {
		try {
		colorDeCanion.validarEleccion()
		colorDeCanion.serElegido()
		game.removeVisual(pantallaEleccion)
		game.removeVisual(self)
		game.removeVisual(canionNormal)
		game.removeVisual(canionRosa)
		game.removeVisual(canionAzul)
		game.removeVisual(canionDorado)
		actual.nivel().iniciar()
		} catch error {
			game.say(colorDeCanion, "Este canion se desbloquea en el nivel" + colorDeCanion.nivelDeDesbloqueo()) 
			// No mostramos el mensaje de error porque nos parece feo el mensaje en rojo
		}
		}
	} 

class ColorDeCanion {
	 const property nivelDeDesbloqueo
	 const imagenJugar = self.toString() +"Jugar.png" 
	 
	 method image() = self.estado().image(self)
	 method serElegido() {
	 	self.validarEleccion()
	 	normal.image(imagenJugar)
	 } 
	 
	 method validarEleccion() {
		if (not self.estaDesbloqueado()) {
			self.error("")
		}
	}
	
	method estaDesbloqueado() {
		return nivelDeDesbloqueo <= actual.nivelActual()
	}
	
	method estado() = if (self.estaDesbloqueado() ) desbloqueado else candado
}
object canionNormal inherits ColorDeCanion(nivelDeDesbloqueo = 1) {
	const property position = new Position (x = 7, y = 7)
}

object canionRosa inherits ColorDeCanion(nivelDeDesbloqueo = 1) {
	const property position = new Position (x = 10, y = 7)
}

object canionAzul inherits ColorDeCanion(nivelDeDesbloqueo = 2) {
	const property position = new Position (x = 13, y = 7)
}

object canionNaranja inherits ColorDeCanion(nivelDeDesbloqueo = 2) {
	const property position = new Position (x = 16, y = 7)
}

object canionVerde inherits ColorDeCanion(nivelDeDesbloqueo = 3) {
	const property position = new Position (x = 19, y = 7)
}

object canionDorado inherits ColorDeCanion(nivelDeDesbloqueo = 3) {
	const property position = new Position (x = 22, y = 7)
}



object candado {
	method image(color) = "candado.png"
}

object desbloqueado {
	method image(color) = color.toString() + "Eleccion.png"
}

object seleccionarNave {
	const property image = "seleccionarNave.png"
	const property position = new Posicion(x = 9 , y = 9)
	method iniciar() {
		pantallaSiguienteNivel.eliminarse()
		pantallaEleccion.iniciar()
	}
}

object punteroSigNivel {
	const property image = "puntero.png"
	var property position = iniciarJuego.position()
	var property apuntables = [iniciarJuego, seleccionarNave]
	method iniciar(pantalla) {
		game.sound("entrar.mp3").play()
		pantalla.iniciar()
	}

	method mover() {
		if (self.puedeMover()) {
			position = apuntables.get(1).position()
			apuntables = apuntables.reverse()
			game.sound("mover.mp3").play()
		}
	}


	method iniciarTeclas() {
		keyboard.up().onPressDo({ self.mover()})
		keyboard.down().onPressDo({ self.mover()})
	}

	method puedeMover() {
		return game.hasVisual(self)
	}
}

object nivelCompletado {
	const property image = "nivelCompletado.png"
	const property position = new Posicion(x = 7, y = 15)
}