import wollok.game.*
import canion.*
import naves.*
import direcciones.*

object balaCanion {

	var property position

	method image() = "balaCanion.png"

	method disparar(objeto) {
		position = arriba.nuevaPosicion(objeto)
		game.addVisual(self)
		self.subirAuto()
	}

	method subirAuto() {
		game.onTick(25, "subir bala", {=>
			self.subir()
			if (arriba.estaEnElBorde(self)) self.serDestruido() else self.eliminarEnemigo()
		})
	}

	method eliminarEnemigo() {
		game.onCollideDo(self, { enemigo =>
			self.serDestruido()
			enemigo.serDestruido()
			ovnis.remove(enemigo)
		})
	}

	method subir() {
		position = arriba.nuevaPosicion(self)
	}

	method serDestruido() {
		game.removeVisual(self)
		game.removeTickEvent("subir bala")
	}


}

object balaNave {
	
	var property position
	
	method image() = "balaNave.png"
	
	method disparar(objeto) {
		position = abajo.nuevaPosicion(objeto)
		game.addVisual(self)
		self.bajarAuto()
	}
	
	method bajarAuto(){
		game.onTick(50, "bajar bala", {=>
			self.bajar()
			if (abajo.estaEnElBorde(self)) self.daniarCanion() else if (self.position().y() < 1) self.serDestruido()
		})
	}
	
	method bajar() {
		position = abajo.nuevaPosicion(self)
	}

	method serDestruido() {
		game.removeVisual(self)
		game.removeTickEvent("bajar bala")
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
		const naveAlAzar = ovnis.get((0..ovnis.size()-1).anyOne())
		naveAlAzar.disparar()
	}
}
