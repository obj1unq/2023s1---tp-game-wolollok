import wollok.game.*
import canion.*
import naves.*
import posDir.*
import pantallas.*

class Bala {

	const tick
	var property position
	const property direccionamiento
	var primerDisparo = false

	method image() = self.toString() + ".png"

	method disparar(objeto) {
		position.clonar(objeto)
		direccionamiento.nuevaPosicion(position)
		game.addVisual(self)
		self.moverAuto()
	}

	method mover() {
		direccionamiento.nuevaPosicion(position)
	}

	method serDestruido() {
		game.removeVisual(self)
		game.removeTickEvent(tick)
		
	}

	method moverAuto()
	
	method eliminarse() {
		if (game.hasVisual(self)) {
			game.removeTickEvent(tick)
			game.removeVisual(self)
		}
	}
}

class EstadoDeBalaCanion inherits Bala(direccionamiento = arriba, position = new Posicion(x = 0, y = 0), tick = "subir bala"){
	override method moverAuto() {
		game.onTick(25, tick, {=>
			self.mover()
			if (direccionamiento.estaEnElBorde(self)) self.serDestruido() else self.eliminarEnemigo()
		})
	}
	
	method eliminarEnemigo() {
		if (not primerDisparo) {
		game.onCollideDo(self, { enemigo => self.eliminarEnemigoModelo(enemigo)	})
		}
	}
	
	method eliminarEnemigoModelo(enemigo) {
			self.serDestruido()
			primerDisparo = true
			enemigo.serDestruido()
			if (ovnis.isEmpty()) {
				actual.nivel().siguienteNivelSetear()
			}
	}
	
	method serDaniado(objeto) {
		objeto.serDestruido()
		self.serDestruido()
	}
}

object balaCanion inherits EstadoDeBalaCanion {	 }
object balaPotente inherits EstadoDeBalaCanion {
	override method eliminarEnemigoModelo(enemigo) { 
		self.destruirPotente(enemigo)
		super(enemigo)
	}
	method destruirPotente(ovni) {
		game.getObjectsIn(game.at(ovni.position().x(), ovni.position().y() + 2)).forEach{nave => nave.serDestruido()}
		game.getObjectsIn(game.at(ovni.position().x(), ovni.position().y() + 4)).forEach{nave => nave.serDestruido()}
	}	
}
object balaVeloz inherits EstadoDeBalaCanion {
	override method moverAuto() {
		game.onTick(5, tick, {=>
			self.mover()
			if (direccionamiento.estaEnElBorde(self)) self.serDestruido() else self.eliminarEnemigo()
		})
	}	
}
//BALA DE LA NAVE
object balaNave inherits Bala(direccionamiento = abajo, position = new Posicion(x = 0, y = 0), tick = "bajar bala") {

	override method moverAuto() {
		game.onTick(50, tick, {=>
			self.mover()
			if (direccionamiento.estaEnElBorde(self)) self.daniarCanion() else if (self.position().y() < 1) self.serDestruido()
		})
	}

	override method serDestruido() {
		super()
		self.nuevoDisparo()
	}

	method daniarCanion() {
		game.onCollideDo(self, { objetivo => objetivo.serDaniado(self) 
			                                 
		})
		
	}

	method nuevoDisparo() {
		const naveAlAzar = ovnis.anyOne()
		naveAlAzar.disparar()
	}
	
	method elDeArriba() = game.getObjectsIn(game.at(self.position().x(), self.position().y() + 2))
	method elDeDosArria() {}
}