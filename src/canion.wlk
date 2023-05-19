import wollok.game.*
import naves.*
import balas.*
import direcciones.*

object canion {

	var property position = game.at(game.center().x(), 1)

	method image() = "canion.png"

	method mover(direccion) {
		if (self.puedeMover(direccion)) {
			position = direccion.nuevaPosicion(self)
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
	const property position = game.at(1,0)
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

