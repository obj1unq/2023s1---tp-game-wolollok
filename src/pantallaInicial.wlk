import wollok.game.*
import canion.*
import naves.*
import balas.*
import posDir.*
import score.*
import pantallas.*

class ObjetoPantallaInicial {
	const property image = self.toString() + ".png"
	const property position
	
	method iniciarPantalla() {
		game.clear()
		self.iniciar()
	}
	
	method iniciar()
}

object spaceInvaders {
	const property position = new Position(x = 7, y = 15)
	const property image = "spaceInvaders.png"
}
object iniciarJuego inherits ObjetoPantallaInicial(position = new Position(x = 8, y = 12)) {
	override method iniciar() {
		game.clear()
		pantallaNombre.iniciar()
	}
}

object comoJugar inherits ObjetoPantallaInicial(position = new Position(x = 9, y = 9))  {
	override method iniciar() {
		pantallaComoJugar.iniciar()
	}
}

object wolollok inherits ObjetoPantallaInicial(position = new Position(x = 13, y = 6))  {
	override method iniciar() {
		pantallaWolollok.iniciar()
	}
}

object puntero {
	const property image = "puntero.png"
	var property position = iniciarJuego.position()
	var apuntables = [wolollok, iniciarJuego, comoJugar]
	
	
	method iniciarPantalla(pantalla) {
		pantalla.iniciar()
	}
	
	method subir() {
		position = apuntables.get(0).position()
		apuntables = [apuntables.last()] + apuntables.take(2)
	}
	
	method bajar() {
		position = apuntables.get(2).position()
		apuntables = apuntables.drop(1) + [apuntables.first()]
	}

}

object pantallaWolollok {
	const property position = new Position (x = 0, y= 0)
	const property image = "pantallaWolollok.png"
	method iniciar() {
		game.clear()
		game.addVisual(self)
		
		keyboard.backspace().onPressDo({pantallaInicial.iniciar()})
	}
}

object pantallaComoJugar {
	const property position = new Position (x = 0, y= 0)
	const property image = "pantallaComoJugar.png"
	method iniciar() {
		game.clear()
		game.addVisual(self)
		
		keyboard.backspace().onPressDo({pantallaInicial.iniciar()})
	}
}


