import wollok.game.*
import canion.*
import naves.*
import balas.*
import posDir.*
import score.*
import pantallas.*
object iniciarJuego {
	const property image 
	const property position = new Position(x = 0, y = 0)
	method iniciarPantalla() {
		game.clear()
		game.addVisual(self)
	}
	
	method iniciarTeclas() {
		keyboard.backspace().onPressDo({pantallaInicial.iniciar()})
	}
}

object comoJugar {
	const property image 
	const property position = new Position(x = 0, y = 0)
	method iniciarPantalla() {
		game.clear()
		game.addVisual(self)
	}
	
	method iniciarTeclas() {
		keyboard.backspace().onPressDo({pantallaInicial.iniciar()})
	}
}

object wolollok {
	const property image 
	const property position = new Position(x = 0, y = 0)	
	method iniciarPantalla() {
		game.clear()
		game.addVisual(self)
		self.iniciarTeclas()
	}
	
	method iniciarTeclas() {
		keyboard.backspace().onPressDo({pantallaInicial.iniciar()})
	}
}

object puntero {
	const image
	var property position = new Position (x = 10, y = 16)
	
	method iniciarPantalla(pantalla) {
		pantalla.iniciar()
	}
	
	method iniciarTeclas() {
		keyboard.up().onPressDo({self.subir()})
		keyboard.down().onPressDo({self.bajar()})
		keyboard.enter().onPressDo({self.iniciarPantalla(game.uniqueCollider(self))})
	}
	
	method subir() {
		if (position.y() < 16) {//POSIBLE POSICION DE Y DE INICIARJUEGO)   
			self.position(new Position(x = self.position().x(), y = self.position().y() + 2 ))
		}
	}
	
	method bajar() {
		if (position.y() > 12) {//POSIBLE POSICION DE Y DE INICIARJUEGO)   
			self.position(new Position(x = self.position().x(), y = self.position().y() + 2 ))
		}
	}
}
