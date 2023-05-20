import wollok.game.*
import canion.*
import naves.*
import balas.*

object randomizer {
	
	method position(nave) {
		return game.at(	
			nave.direccionamiento().x(),
			game.height().randomUpTo(self.positionDeY() + 1)
		)
	}	
	
	method positionDeY() {
		return self.positionDeYPosibles().max()
	}
	
	method positionDeYPosibles() {
		return ovnis.map({ ovni => ovni.position().y() })
	}
}
