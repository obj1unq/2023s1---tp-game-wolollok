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

class Digito {
	const property position
	const property posicionDigito
	
	method image() {
		return self.numero() + "-score.png"
	}
	
	method numero() {
		return score.puntaje().toString().charAt(posicionDigito)
	}
	
	method serDestruido(){}
	
}

object unidad inherits Digito (position = game.at(29, 19), posicionDigito = 5 ) {}

object decena inherits Digito (position = game.at(28, 19), posicionDigito = 4 ) {}

object centena inherits Digito (position = game.at(27, 19), posicionDigito = 3 ){}

object mil inherits Digito (position = game.at(26, 19), posicionDigito = 2 ) {}

object decenaMil inherits Digito (position = game.at(25, 19), posicionDigito = 1 ){}

const scoreCompleto = [ unidad, decena, centena, mil, decenaMil ]
