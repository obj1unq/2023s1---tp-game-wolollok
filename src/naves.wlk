import wollok.game.*
import canion.*
import balas.*


class Nave{
	
	var property image = "nave2.png"
	method disparar(){}
	
	method serDestruido(){
		game.sound("explosion1.mp3").play()
		self.image("explosion1.png")
		game.schedule(200, {=>self.image("explosion2.png")})
		game.schedule(400, {=>self.image("explosion3.png")})
		game.schedule(600, {=>game.removeVisual(self)})
		
	}
	
}

class NaveFuego{
	var property image = "nave1.png"
	
	method disparar(){}
	
	method serDestruido(){
		game.sound("explosion1.mp3").play()
		self.image("explosion1.png")
		game.schedule(200, {=>self.image("explosion2.png")})
		game.schedule(400, {=>self.image("explosion3.png")})
		game.schedule(600, {=>game.removeVisual(self)})
		
	}
}

class NaveHielo {
	var property image = "nave3.png"
	
	method disparar(){}
	
	method serDestruido(){
		game.sound("explosion1.mp3").play()
		self.image("explosion1.png")
		game.schedule(200, {=>self.image("explosion2.png")})
		game.schedule(400, {=>self.image("explosion3.png")})
		game.schedule(600, {=>game.removeVisual(self)})
		
	}
}



object nave1 inherits NaveFuego {
	
	var property position = game.at(3, 14)
	
	
}

object nave2 inherits Nave{
	
	var property position = game.at(3, 16)
	
}

object nave3 inherits NaveHielo {
	
	var property position = game.at(3, 18)
}
