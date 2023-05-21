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


const vidas = #{uno, dos, tres}

object gestorDeVidas {
	
	method perderVida() {
		if (vidas.size() == 3) {
			vidas.remove(tres)
			game.sound("dos-vida.mp3").play()
			tres.perderVida()
		} else if (vidas.size() == 2) {
			vidas.remove(dos)
			game.sound("una-vida.mp3").play()
			dos.perderVida()
		} else if (vidas.size() == 1) {
			ultimaVida.gameOver()			
		}
	}
	
}

object ultimaVida {
	
	const ultimaVida = uno
	const ultimaVidaDe = canion
	
	var property image = "dos-vida.png"
	
	const property position = game.at(1,0)
	
	method gameOver() {
		game.removeVisual(ultimaVida)
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

const tres = new Vida (position = game.at(3,0) )
const dos = new Vida (position = game.at(2,0) )
const uno = new Vida (position = game.at(1,0) )
