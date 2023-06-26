import wollok.game.*
import canion.*
import naves.*
import posDir.*
import pantallas.*

class Bala {

	const tick
	var property position
	const property direccionamiento
	var property yaDisparada = false
	const velocidad

	method condicionDeSerDestruido() = direccionamiento.estaEnElBorde(self)

	method image() = self.toString() + ".png"

	method disparar(objeto) {
		position.clonar(objeto)
		direccionamiento.nuevaPosicion(position)
		game.addVisual(self)
		self.moverAuto()
		self.primerDisparo()
	}

	method primerDisparo()

	method mover() {
		direccionamiento.nuevaPosicion(position)
	}

	method serDestruido() {
		game.removeVisual(self)
		game.removeTickEvent(tick)
	}

	method moverAuto() {
		game.onTick(velocidad, tick, {=>
			self.mover()
			if (self.condicionDeSerDestruido()) self.serDestruido()})
	}

	method eliminarse() {
		if (game.hasVisual(self)) {
			game.removeTickEvent(tick)
			game.removeVisual(self)
		}
	}
}

class EstadoDeBalaCanion inherits Bala(direccionamiento = arriba, position = new Posicion(x = 0, y = 0), tick = "subir bala", velocidad = 25) {

	override method primerDisparo() {
		if (not yaDisparada) {
			yaDisparada = true
			game.onCollideDo(self, { enemigo => self.eliminarEnemigo(enemigo)})
		}
	}

	method eliminarEnemigo(enemigo) {
		self.serDestruido()
		enemigo.serDestruido()
	}

	method serDaniado(objeto) {
		objeto.serDestruido()
		self.serDestruido()
	}
}

object balaCanion inherits EstadoDeBalaCanion {}

object balaPotente inherits EstadoDeBalaCanion {

	override method eliminarEnemigo(enemigo) {
		self.destruirPotente()
		super(enemigo)
	}

	method destruirPotente() {
		[self.position().y() .. game.height()].forEach{posicionY => self.destruirColumna(posicionY)}
	}
	
	method destruirColumna(posicionY){
		game.getObjectsIn(game.at(self.position().x(), posicionY)).forEach{ nave => nave.serDestruido()}
	}
}

object balaVeloz inherits EstadoDeBalaCanion(velocidad = 5) {}

//BALA DE LA NAVE

object balaNave inherits Bala(direccionamiento = abajo, position = new Posicion(x = 0, y = 0), tick = "bajar bala", velocidad = 50) {

	override method serDestruido() {
		super()
		self.nuevoDisparo()
	}

	override method primerDisparo() {
		if (not yaDisparada) {
			yaDisparada = true
			game.onCollideDo(self, { objetivo => objetivo.serDaniado(self)})
		}
	}

	method nuevoDisparo() {
		const naveAlAzar = ovnis.anyOne()
		naveAlAzar.disparar()
	}
}

const balas = [ balaCanion, balaVeloz, balaPotente, balaNave ]

