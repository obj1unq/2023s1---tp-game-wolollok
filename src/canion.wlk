import wollok.game.*
import naves.*
import balas.*

object canion {

	var property position = game.at(game.center().x() , 1)
	const property balas = []
	var property cantidaDeVidas = 3

	method image() = "canion.png"

	method mover(_posicion) {
		if (self.puedeMover(_posicion)) {
			position = _posicion
		}
	}

	method puedeMover(_posicion) {
		return _posicion.x().between(0, game.width() - 1)
	}

	method disparar() {
		if (not game.hasVisual(balaCanion)) {
			game.sound("disparoCanion.mp3").play()
			balaCanion.disparar(position)
			
		}
	}
	method serDestruido() {
		
		const vida = vidas
		
		if (cantidaDeVidas == 3) {
			game.sound("primeraVidaPerdida.mp3").play()
			vida.perderVida()
			cantidaDeVidas -= 1
			} else if (cantidaDeVidas == 2) {
				game.sound("segundaVidaPerdida.mp3").play()
				vida.perderVida()
				cantidaDeVidas -= 1
			} else {
				vida.perderVida()
				cantidaDeVidas -= 1
				//gamerOver?
			}
		
	}
}

object vidas {
	
	var property cantidad = tres
	
	method position() {
		return game.at(1, 0)
	}
	
	method image () {
		return cantidad.toString() + "-vida.png"
	}
	
	method perderVida() {
		cantidad = cantidad.restarVida()
	}
	
}

object tres {
	
	method restarVida() {
		return dos
	}
	
}

object dos {
	method restarVida() {
		return una
	}
}

object una {
	
	method restarVida(){
		
	}
	
}

