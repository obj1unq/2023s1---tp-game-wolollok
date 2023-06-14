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
		pantallaEleccion.iniciar()
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
		game.sound("entrar.mp3").play()
		pantalla.iniciar()
	}
	
	method subir() {
		position = apuntables.get(0).position()
		apuntables = [apuntables.last()] + apuntables.take(2)
		game.sound("mover.mp3").play()
	}
	
	method bajar() {
		position = apuntables.get(2).position()
		apuntables = apuntables.drop(1) + [apuntables.first()]
		game.sound("mover.mp3").play()
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
	var property image = "pantallaComoJugar1.png"
	
	method iniciar() {
		game.clear()
		game.addVisual(self)
		keyboard.backspace().onPressDo({ pantallaInicial.iniciar() })
		keyboard.right().onPressDo({self.image("pantallaComoJugar2.png")})
		keyboard.left().onPressDo({self.image("pantallaComoJugar1.png")})
	}
}
