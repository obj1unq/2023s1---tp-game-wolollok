import wollok.game.*
import naves.*
import balas.*

object canion {

	var property position = game.at(game.center().x() , 1)

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
		
		if (vida == tres) {
			game.sound("primeraVidaPerdida.mp3").play()
			vida.perderVida()
			} else if (vida == dos) {
				game.sound("segundaVidaPerdida.mp3").play()
				vida.perderVida()
			} else {
				vida.perderVida()
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
	
