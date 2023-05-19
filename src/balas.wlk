import wollok.game.*
import canion.*
import naves.*
import direcciones.*

class Bala {
	const tick 
	var property position
	const direccionamiento
	
	method image() = self.toString() + ".png"
	
	method disparar(objeto) {
		position = direccionamiento.nuevaPosicion(objeto)
		game.addVisual(self)
		self.moverAuto()
	}
	
	method mover() {
		position = direccionamiento.nuevaPosicion(self)
	}
	method serDestruido() {
		game.removeVisual(self)
		game.removeTickEvent(tick)
	}
	method moverAuto()
}
object balaCanion inherits Bala(direccionamiento = arriba, position = game.origin(), tick = "subir bala") {

	override method moverAuto() {
		game.onTick(10, tick, {=>
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

object balaNave inherits Bala(direccionamiento = abajo, position = game.origin(), tick = "bajar bala") {
	
	
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
