import wollok.game.*
import naves.*
import balas.*
import posDir.*

object canion {

	var property position = new Posicion(x = game.center().x(), y = 1)

	method image() = "canion.png"

	method mover(direccion) {
		if (self.puedeMover(direccion)) {
			direccion.nuevaPosicion(position)
		}
	}

	method puedeMover(direccion) {
		return not direccion.estaEnElBorde(self)
	}

	method disparar() {
		if (not game.hasVisual(balaCanion)) {
			game.sound("disparoCanion.mp3").play()
			balaCanion.disparar(self)
		}
	}
	

	method serDestruido() {
		vidas.perderVida()
	}

}

object vidas {
	const property position = new Posicion (x = 1, y = 0)
	var property cantidad = tres

	method image() {
		return cantidad.toString() + "-vida.png"
	}

	method perderVida() {
		cantidad = cantidad.restarVida()
		game.sound(cantidad.toString() + "-vida.mp3").play()
	}

}

object tres {

	method restarVida() {
		return dos
	}

}

object dos {

	method restarVida() {
		return una
	}

}

object una {

	method restarVida() {
	}

}

