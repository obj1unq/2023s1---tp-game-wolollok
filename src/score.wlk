import wollok.game.*
import naves.*
import balas.*
import canion.*

object score {
	var property puntaje = 100000
	
	method scorear(puntos) {
		puntaje += puntos
	}
}
object unidad {

	var property position = game.at(29, 19)

	method image() {
		return self.numero() + "-score.png"
	}

	method numero() {
		return score.puntaje().toString().charAt(5)
	}

}

object decena {

	var property position = game.at(28, 19)

	method image() {
		return self.numero() + "-score.png"
	}

	method numero() {
		return score.puntaje().toString().charAt(4)
	}

}

object centena {

	var property position = game.at(27, 19)

	method image() {
		return self.numero() + "-score.png"
	}

	method numero() {
		return score.puntaje().toString().charAt(3)
	}

}

object mil {

	var property position = game.at(26, 19)

	method image() {
		return self.numero() + "-score.png"
	}

	method numero() {
		return score.puntaje().toString().charAt(2)
	}

}

object decenaMil {

	var property position = game.at(25, 19)

	method image() {
		return self.numero() + "-score.png"
	}

	method numero() {
		return score.puntaje().toString().charAt(1)
	}

}

const scoreCompleto = [ unidad, decena, centena, mil, decenaMil ]
