import wollok.game.*
import naves.*
import balas.*

object canion {

	var property position = game.at(game.center().x() , 1)
	const property balas = []

	method image() = "canion.png"

	method mover(_posicion) {
		if (self.puedeMover(_posicion)) {
			position = _posicion
		}
	}

	method puedeMover(_posicion) {
		return _posicion.x().between(0, game.width() - 1)
	}

	method disparar() {
		if (not game.hasVisual(balaCanion)) {
			game.sound("disparoCanion.mp3").play()
			balaCanion.disparar(position)
			
		}
	}
}

