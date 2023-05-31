import wollok.game.*
import naves.*
import balas.*
import posDir.*
import pantallas.*



object canion {

	var property position = new Posicion(x = game.center().x(), y = 1)

	method image() = "canion.png"

	method mover(direccion) {
		if (self.puedeMover(direccion)) {
			direccion.nuevaPosicion(position)
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
	

	method serDaniado(objeto) {
		gestorDeVidas.perderVida()
		objeto.serDestruido()
	}
}

const vidas = []


object gestorDeVidas {
	
	method perderVida() {
		self.ultimaVida().eliminarse()
		vidas.remove(self.ultimaVida())
	}
	
	method inicializarVidas() {
		vidas.add(uno)
		vidas.add(dos)
		vidas.add(tres)
		vidas.forEach{vida => game.addVisual(vida)}
	}
	
	method ultimaVida() {
		return vidas.last()
	}
}

class Vida {
	const property position

	method image() {
		return "vida.png"
	}
	
	method perderVida() {
		game.removeVisual(self)
	}	
	
	method eliminarse() {
		game.removeVisual(self)
	}
  
  method serDaniado(objeto) {}
}

object uno inherits Vida(position = new Posicion(x = 0, y = 0)) {
	override method eliminarse() {
		super()
		gameOver.iniciar()
  }
}
object dos inherits Vida(position = new Posicion(x = 1, y = 0)) {}
object tres inherits Vida(position = new Posicion(x = 2, y = 0)) {}


