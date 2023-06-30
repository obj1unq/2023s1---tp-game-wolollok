import wollok.game.*
import canion.*
import naves.*
import posDir.*
import score.*
import pantallas.*
import pantallaInicial.*
import sound.*

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

object naveEnLaTierra {
	var property image 
	const property position = new Position( x = 0, y = 0)
	
	method animacion() {
		game.schedule(400, {soundProducer.sound("perderPorY.mp3").play()
							self.image("pantallaPerder1.png")
							game.addVisual(self)})
		game.schedule(550, {self.image("pantallaPerder2.png")})
		game.schedule(700, {self.image("pantallaPerder3.png")})
		game.schedule(850, {self.image("pantallaPerder4.png")})
		game.schedule(1000, {self.image("pantallaPerder5.png")})
		game.schedule(1150, {self.image("pantallaPerder6.png")})
		game.schedule(1300, {self.image("pantallaPerder7.png")})
		game.schedule(1450, {self.image("pantallaPerder8.png")})
		game.schedule(1600, {gameOver.iniciar()})
	}
}
