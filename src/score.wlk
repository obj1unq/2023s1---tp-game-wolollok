import wollok.game.*
import naves.*
import balas.*
import canion.*
import posDir.*

object score {
	var property puntaje = 100000
	
	method scorear(puntos) {
		puntaje += puntos
	}
}

class Digito {
	const property position
	const property posicionDigito
	const property posicionFinal
	
	method image() {
		return self.numero() + "-score.png"
	}
	
	method numero() {
		return score.puntaje().toString().charAt(posicionDigito)
	}
	
	method serDestruido(){}
	
	method puntajeFinal(){
		game.addVisualIn(self, posicionFinal)
	}
}

object unidad    inherits Digito (position = new Posicion (x = 29, y = 19, duenio = self), posicionDigito = 5, posicionFinal = new Posicion (x = 20, y = 9, duenio = self) ) {}

object decena    inherits Digito (position = new Posicion (x = 28, y = 19, duenio = self), posicionDigito = 4, posicionFinal = new Posicion (x = 19, y = 9, duenio = self) ) {}

object centena   inherits Digito (position = new Posicion (x = 27, y = 19, duenio = self), posicionDigito = 3, posicionFinal = new Posicion (x = 18, y = 9, duenio = self) ){}

object mil       inherits Digito (position = new Posicion (x = 26, y = 19, duenio = self), posicionDigito = 2, posicionFinal = new Posicion (x = 17, y = 9, duenio = self) ) {}

object decenaMil inherits Digito (position = new Posicion (x = 25, y = 19, duenio = self), posicionDigito = 1, posicionFinal = new Posicion (x = 16, y = 9, duenio = self) ){}

const scoreCompleto = [ unidad, decena, centena, mil, decenaMil ]


