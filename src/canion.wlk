import wollok.game.*
import naves.*
import balas.*

object canion {

	var property position = game.at(game.center().x(), 1)
	var property score = 100000

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
	
	method scorear(puntos) {
		score = score + puntos
	}

	method serDestruido() {
		const vida = vidas
		if (vida == tres) {
			game.sound("primeraVidaPerdida.mp3").play()
			vida.perderVida()
		} else if (vida == dos) {
			game.sound("segundaVidaPerdida.mp3").play()
			vida.perderVida()
		} else {
			vida.perderVida()
		// gamerOver?
		}
	}

}

object vidas {

	var property cantidad = tres

	method position() {
		return game.at(1, 0)
	}

	method image() {
		return cantidad.toString() + "-vida.png"
	}

	method perderVida() {
		cantidad = cantidad.restarVida()
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


object unidad {

	var property position = game.at(29, 19)

	method image() {
		return self.numero() + "-score.png"
	}

	method numero() {
		return canion.score().toString().charAt(5)
	}

}

object decena {

	var property position = game.at(28, 19)

	method image() {
		return self.numero() + "-score.png"
	}

	method numero() {
		return canion.score().toString().charAt(4)
	}

}

object centena {

	var property position = game.at(27, 19)

	method image() {
		return self.numero() + "-score.png"
	}

	method numero() {
		return canion.score().toString().charAt(3)
	}

}

object mil {

	var property position = game.at(26, 19)

	method image() {
		return self.numero() + "-score.png"
	}

	method numero() {
		return canion.score().toString().charAt(2)
	}

}

object decenaMil {

	var property position = game.at(25, 19)

	method image() {
		return self.numero() + "-score.png"
	}

	method numero() {
		return canion.score().toString().charAt(1)
	}

}

const scoreCompleto = [ unidad, decena, centena, mil, decenaMil ]


