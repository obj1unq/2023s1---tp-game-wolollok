import wollok.game.*
import naves.*
import balas.*

object canion {

	var property position = game.at(game.center().x() , 1)
	var property score = 0

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


object unidad {
	method image() { return  self.numero() + "score.png" }
	
	method numero() {return ((canion.score() - decenaMil.numeroUbicado() - mil.numeroUbicado() - centena.numeroUbicado() - decena.numeroUbicado())).truncate(0) }
}

object decena {
	method image() { return self.numero() + "score.png" }
	
	method numero() { return ((canion.score() - decenaMil.numeroUbicado()  - mil.numeroUbicado() - centena.numeroUbicado() ) / 10 ).truncate(0) }
	
	method numeroUbicado() { return self.numero() * 10 }
}

object centena {
	method image() { return  self.numero() + "score.png" }
	
	method numero() { return ((canion.score() - decenaMil.numeroUbicado()  - mil.numeroUbicado() ) / 100 ).truncate(0) }

	method numeroUbicado() { return self.numero() * 100 }
}

object mil {
	method image() { return self.numero()  + "score.png" }
	
	method numero() { return ((canion.score() - decenaMil.numeroUbicado() ) / 1000 ).truncate(0) }

	method numeroUbicado() { return self.numero() * 1000 }
}

object decenaMil {
	method image() { return self.numero() + "score.png" }
	
	method numero() { return (canion.score()/10000).truncate(0)	}
	
	method numeroUbicado() { return self.numero() * 10000 }
}

const scoreCompleto = [unidad, decena, centena, mil, decenaMil]
