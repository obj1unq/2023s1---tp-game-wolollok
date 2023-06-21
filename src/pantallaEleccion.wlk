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
	var property apuntables = [canionRosa, canionAzul, canionCeleste, canionNormal]
	
	method moverDerecha() {
		position = apuntables.get(0).position()
		apuntables =  apuntables.drop(1) + [apuntables.first()]
		game.sound("mover.mp3").play()
	}
	
	method moverIzquierda() {
		position = apuntables.get(2).position()
		apuntables = [apuntables.last()] + apuntables.take(3)
		game.sound("mover.mp3").play()
	}
	
	method iniciar(colorDeCanion) {
		colorDeCanion.serElegido()
		game.removeVisual(pantallaEleccion)
		game.removeVisual(self)
		game.removeVisual(canionNormal)
		game.removeVisual(canionRosa)
		game.removeVisual(canionAzul)
		game.removeVisual(canionCeleste)
		pantallaNombre.iniciar()
	}
	
} 


class ColorDeCanion {
	 var property image = self.toString() + "Eleccion.png"
	 const property nivelDeDesbloqueo
	 
	 method serElegido() {
	 	self.validarEleccion()
	 	normal.image( self.toString() +"Jugar.png" )
	 }
	 
	 method validarEleccion() {
		if (not self.estaDesbloqueado()) {
			self.error("Este canion se desbloquea en el nivel" + nivelDeDesbloqueo)
		}
	}
	
	method estaDesbloqueado() {
		return nivelDeDesbloqueo <= actual.nivelActual()
	}
}
object canionNormal inherits ColorDeCanion(nivelDeDesbloqueo = 1) {
	const property position = new Position (x = 8, y = 10)
}

object canionRosa inherits ColorDeCanion(nivelDeDesbloqueo = 2) {
	const property position = new Position (x = 11, y = 10)
}

object canionAzul inherits ColorDeCanion(nivelDeDesbloqueo = 2) {
	const property position = new Position (x = 14, y = 10)
}

object canionCeleste inherits ColorDeCanion(nivelDeDesbloqueo = 3) {
	const property position = new Position (x = 17, y = 10)
}