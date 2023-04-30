import wollok.game.*
import canion.*
import balas.*


class Nave{
	
	var property image
	
	
	method serDestruido(){
		game.sound("explosion1.mp3").play()
		self.image("explosion1.png")
		game.schedule(200, {=>self.image("explosion2.png")})
		game.schedule(400, {=>self.image("explosion3.png")})
		game.schedule(600, {=>game.removeVisual(self)})
		
	}
	
	method disparar(){} //TODO
}

class Nave3Patas inherits Nave{
	
	var property image = "nave2.png"
	
}

class NaveConFuego inherits Nave{
	var property image = "nave1.png"
	
}

class Nave2Patas inherits Nave{
	var property image = "nave3.png"
	
}


object nave11 inherits NaveConFuego {
	
	var property position = game.at(3, 14)
		
}

object nave12 inherits NaveConFuego {
	
	var property position = game.at(5, 14)
		
}

object nave13 inherits NaveConFuego {
	
	var property position = game.at(7, 14)
		
}

object nave21 inherits Nave3Patas{
	
	var property position = game.at(3, 16)
	
}

object nave22 inherits Nave3Patas{
	
	var property position = game.at(5, 16)
	
}

object nave23 inherits Nave3Patas{
	
	var property position = game.at(7, 16)
	
}

object nave31 inherits Nave2Patas {
	
	var property position = game.at(3, 18)
}

object nave32 inherits Nave2Patas {
	
	var property position = game.at(5, 18)
}

object nave33 inherits Nave2Patas {
	
	var property position = game.at(7, 18)
}

