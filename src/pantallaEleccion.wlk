import wollok.game.*
import canion.*
import naves.*
import posDir.*
import score.*
import pantallas.*
import pantallaInicial.*

object puntero2 {
	const property image = "puntero2.png"
	var property position = canionNormal.position()
	var property apuntables = [canionNormal, canionRosa, canionAzul, canionCeleste]
	
	method moverDerecha() {
		position = apuntables.get(0).position()
		apuntables = [apuntables.last()] + apuntables.take(3)
		game.sound("mover.mp3").play()
	}
	
	method moverIzquierda() {
		position = apuntables.get(3).position()
		apuntables = apuntables.drop(1) + [apuntables.first()]
		game.sound("mover.mp3").play()
	}
	
	method iniciar(colorDeCanion) {
		colorDeCanion.serElegido()
		game.clear()
		pantallaNombre.iniciar()
	}
	
} 


class ColorDeCanion {
	 var property image = self.toString() + ".png"
	 
	 method serElegido() {
	 	normal.image( self.image() )
	 }
}
object canionNormal inherits ColorDeCanion {
	const property position = new Position (x = 8, y = 10)
}

object canionRosa inherits ColorDeCanion {
	const property position = new Position (x = 10, y = 10)
}

object canionAzul inherits ColorDeCanion {
	const property position = new Position (x = 12, y = 10)
}

object canionCeleste inherits ColorDeCanion {
	const property position = new Position (x = 14, y = 10)
}