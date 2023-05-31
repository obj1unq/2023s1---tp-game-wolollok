import wollok.game.*
import naves.*
import balas.*
import direcciones.*

object canion {

	var property position = game.at(game.center().x(), 1)

	method image() = "canion.png"

	method mover(direccion) {
		if (self.puedeMover(direccion)) {
			position = direccion.nuevaPosicion(self)
		}
	}

	method puedeMover(direccion) {
		return not direccion.estaEnElBorde(self)
	}

	method disparar() {
		if (not game.hasVisual(balaCanion)) {
			game.sound("disparoCanion.mp3").play()
			balaCanion.disparar(self)
		}
	}
	

	method serDestruido() {
		gestorDeVidas.perderVida()
	}

}


const vidas = []

object gestorDeVidas {
	
	method perderVida() {
		if (vidas.size() == 3) {
			vidas.last().perderVida()
			vidas.remove(vidas.last())
			game.sound("dos-vida.mp3").play()
		} else if (vidas.size() == 2) {
			vidas.last().perderVida()
			vidas.remove(vidas.last())
			game.sound("una-vida.mp3").play()
		} else if (vidas.size() == 1) {
			vidas.last().perderVida()
			gameOver.sinVidas()			
		}
	}
	
}

object gameOver {
	
	
	var property image = "dos-vida.png"
	
	const property position = game.at(1,0)
	
	method sinVidas() {
		game.removeTickEvent("moverOvnis")
		game.removeTickEvent("moverNaveAleatoria")
		game.removeTickEvent("Agregar nave aleatoria")
		vidas.last()
		game.addVisual(self)
		game.schedule(600, {=> self.image("una-vida.png")})
		game.schedule(1000, {=> self.image("calavera.png")})
	}
}

class Vida {
	const property position //= game.at(1,0)

	method image() {
		return "vida.png"
	}
	
	method perderVida() {
		game.removeVisual(self)
	}
	
	
}

object factoryDeVidas {
	
	method inicializarVidas () {
		self.creadorDeVidas()
		vidas.forEach {vida => game.addVisual(vida)}
	}
	
	 method creadorDeVidas() {
		 	vidas.add(self.construir (1))
		 	vidas.add(self.construir (2))
		 	vidas.add(self.construir (3))
	}
	
	 method construir(x){
		return new Vida (position = game.at(x,0) )
	}
}

