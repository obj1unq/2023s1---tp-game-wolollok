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
	
	method positionDeYPosibles() {
		return ovnis2Patas.map({ovni => ovni.position().y()})
	}
	
	method positionDeY() {
		return self.positionDeYPosibles().anyOne()
	}
}
