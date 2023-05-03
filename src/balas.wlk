import wollok.game.*
import canion.*
import naves.*

object balaCanion {

	var property position

	method image() = "balaCanion.png"

	method disparar(posicionCanion) {
		position = posicionCanion.up(2)
		game.addVisual(self)
		self.subirAuto()
	}

	method subirAuto() {
		game.onTick(50, "subir bala", {=>
			self.subir()
			if (self.position().y() > game.height() - 1) self.desaparecer() else self.eliminarEnemigo()
		})
	}

	method eliminarEnemigo() {
		game.whenCollideDo(self, { enemigo =>
			self.desaparecer()
			enemigo.serDestruido()
			ovnis.remove(enemigo)
		})
	}

	method subir() {
		position = position.up(1)
	}

	method desaparecer() {
		game.removeVisual(self)
		game.removeTickEvent("subir bala")
	}

}

object balaNave {
	
	var property position
	
	method image() = "balaNave.png"
	
	method disparar(posicionNave) {
		position = posicionNave.down(1)
		game.addVisual(self)
		self.bajarAuto()
	}
	
	method bajarAuto(){
		game.onTick(50, "bajar bala", {=>
			self.bajar()
			if (self.position().y() == 1) self.desaparecer() else self.daniarCanion()
		})
	}
	
	method bajar() {
		position = position.down(1)
	}

	method desaparecer() {
		game.removeVisual(self)
		game.removeTickEvent("bajar bala")
		self.nuevoDisparo()
	}
	
	method daniarCanion(){
		game.whenCollideDo(self, { objetivo =>
			if (objetivo == canion){
				self.desaparecer()
				objetivo.serDestruido()
			}
		})
	}
	
	method nuevoDisparo(){
		const naveAlAzar = ovnis.get((0..ovnis.size()-1).anyOne())
		naveAlAzar.disparar()
	}
	
}
