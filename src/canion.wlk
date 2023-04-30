import wollok.game.*
import naves.*
import balas.*

object canion {

	var property position = game.at(15, 1)
	const property balas = []

	method image() = "canion.png"

	method mover(_posicion) {
		if (self.puedeMover(_posicion)) {
			position = _posicion
		}
	}

	method puedeMover(_posicion) {
		return _posicion.x().between(0, 29)
	}

	method disparar() {
		if (not game.hasVisual(balaCanion)) {
			game.sound("disparoCanion.mp3").play()
			game.schedule(200, {balaCanion.disparar(position)})
			
		}
	}
}

