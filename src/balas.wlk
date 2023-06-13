import wollok.game.*
import canion.*
import naves.*
import posDir.*
import pantallas.*

class Bala {

	const tick
	var property position
	const direccionamiento

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
		game.onCollideDo(self, { enemigo =>
			self.serDestruido()
			enemigo.serDestruido()
			ovnis.remove(enemigo)
			if (ovnis.isEmpty()) {
				actual.pantalla().siguientePantalla()
			}
		})
	}
}

object balaCanion inherits EstadoDeBalaCanion {	 }
object balaPotente inherits EstadoDeBalaCanion {
	override method eliminarEnemigo() {
		game.onCollideDo(self, {enemigo => 
			self.serDestruido() 
			self.destruirPotente(enemigo)      
			enemigo.serDestruido()
			if (ovnis.isEmpty()) {
			actual.pantalla().siguientePantalla()
			}
		})
	}

	method destruirPotente(ovni) {
		ovni.elDeArriba().forEach{nave => nave.serDestruido()}
		ovni.elDeDosArriba().forEach{nave => nave.serDestruido()}
	}
	
	override method moverAuto() {
		game.onTick(25, tick, {=>
			self.mover()
			if (direccionamiento.estaEnElBorde(self)) self.serDestruido() else self.eliminarEnemigo()
		})
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