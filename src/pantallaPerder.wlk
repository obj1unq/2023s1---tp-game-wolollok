import wollok.game.*
import canion.*
import naves.*
import posDir.*
import score.*
import pantallas.*
import pantallaInicial.*

object corazonPerder {
	var property image 
	const property position = new Position( x = 4, y = 4)
	
	method animacion() {
		game.schedule(400, {soundProducer.sound("perder.mp3").play()
							self.image("corazon1.png")
							game.addVisual(self)})
		game.schedule(550, {self.image("corazon2.png")})
		game.schedule(700, {self.image("corazon3.png")})
		game.schedule(850, {self.image("corazon4.png")})
		game.schedule(1000, {self.image("corazon5.png")})
		game.schedule(1150, {self.image("corazon6.png")})
		game.schedule(1450, {gameOver.iniciar()})
	}
	
}
