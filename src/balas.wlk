import wollok.game.*
import canion.*
import naves.*

object balaCanion {

	var property position

	method image() = "balaCanion.png"

	method disparar(posicionCanion) {
		position = posicionCanion.up(2)
		game.addVisual(self)
		self.subirAuto()
	}

	method subirAuto() {
		game.onTick(50, "subir bala", {=>
			self.subir()
			if (self.position().y() > game.height() - 1) self.desaparecer() else self.eliminarEnemigo()
		})
	}

	method eliminarEnemigo() {
		game.whenCollideDo(self, { enemigo =>
			enemigo.serDestruido()
			self.desaparecer()
		})
	}

	method subir() {
		position = position.up(1)
	}

	method desaparecer() {
		game.removeVisual(self)
		game.removeTickEvent("subir bala")
	}

}

