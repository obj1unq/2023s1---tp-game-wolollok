import wollok.game.*
import canion.*
import naves.*
import balas.*
import posDir.*
import score.*
import pantallas.*
import sound.*
import easterEgg.*

class ObjetoPantallaInicial {

	const property image = self.toString() + ".png"
	const property position

	method iniciar()

}

object spaceInvaders {

	const property position = new Position(x = 7, y = 15)
	const property image = "spaceInvaders.png"

}

object iniciarJuego inherits ObjetoPantallaInicial(position = new Position(x = 8, y = 12)) {

	override method iniciar() {
		pantallaInicial.eliminarse()
		pantallaNombre.iniciar()
	}
	
	method continuarJuego() {
		actual.nivel().iniciar()
	}

}

object comoJugar inherits ObjetoPantallaInicial(position = new Position(x = 9, y = 9)) {

	override method iniciar() {
		game.clear()
		pantallaComoJugar.iniciar()
	}

}

object wolollok inherits ObjetoPantallaInicial(position = new Position(x = 13, y = 6)) {

	override method iniciar() {
		game.clear()
		pantallaWolollok.iniciar()
		easterEgg.iniciarTeclas()
	}

}

object puntero {

	const property image = "puntero.png"
	var property position = iniciarJuego.position()
	var apuntables = [ wolollok, iniciarJuego, comoJugar ]

	method iniciar(pantalla) {
		soundProducer.sound("entrar.mp3").play()
		pantalla.iniciar()
	}

	method subir() {
		if (self.puedeMover()) {
			position = apuntables.get(0).position()
			apuntables = [ apuntables.last() ] + apuntables.take(2)
			soundProducer.sound("mover.mp3").play()
		}
	}

	method bajar() {
		if (self.puedeMover()) {
			position = apuntables.get(2).position()
			apuntables = apuntables.drop(1) + [ apuntables.first() ]
			soundProducer.sound("mover.mp3").play()
		}
	}

	method iniciarTeclas() {
		keyboard.up().onPressDo({ self.subir()})
		keyboard.down().onPressDo({ self.bajar()})
	}

	method puedeMover() {
		return game.hasVisual(self)
	}

}

object pantallaWolollok {

	const property position = new Position(x = 0, y = 0)
	const property image = "pantallaWolollok.png"

	method iniciar() {
		game.addVisual(self)
		keyboard.backspace().onPressDo({ pantallaInicial.iniciar()
										 easterEgg.borrarAcumulador() })
	}

}

object pantallaComoJugar {

	const property position = new Position(x = 0, y = 0)
	var property image = "pantallaComoJugar1.png"

	method iniciar() {
		game.addVisual(self)
		keyboard.backspace().onPressDo({ pantallaInicial.iniciar()})
		keyboard.right().onPressDo({ self.image("pantallaComoJugar2.png")})
		keyboard.left().onPressDo({ self.image("pantallaComoJugar1.png")})
	}

}

