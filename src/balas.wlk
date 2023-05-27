import wollok.game.*
import canion.*
import naves.*
import posDir.*

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
}
object balaCanion inherits Bala(direccionamiento = arriba, position = new Posicion (x = 0, y = 0), tick = "subir bala") {

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
		})
	}

}

object balaNave inherits Bala(direccionamiento = abajo, position = new Posicion (x = 0, y = 0), tick = "bajar bala") {
	
	
	override method moverAuto(){
		game.onTick(50, tick, {=>
			self.mover()
			if (direccionamiento.estaEnElBorde(self)) self.daniarCanion() else if (self.position().y() < 1) self.serDestruido()
		})
	}
	
	

	override method serDestruido() {
		super()
		self.nuevoDisparo()
	}
	
	method daniarCanion(){
		game.onCollideDo(self, { objetivo =>
			if (objetivo == canion){
				self.serDestruido()
				objetivo.serDestruido()
			}
		})
	}
	
	method nuevoDisparo(){
		const naveAlAzar = ovnis.anyOne()
		naveAlAzar.disparar()
	}
}
