import wollok.game.*
import canion.*
import sound.*
import posDir.*

object easterEgg {
	
	var property activado = false
	const property acumulador = []
	const property position =  new Posicion(x = 15, y = 18)
	var property image = "easterEgg.png"
	
	method iniciarTeclas(){
		keyboard.e().onPressDo{self.agregar("e")}
		keyboard.a().onPressDo{self.agregar("a")}
		keyboard.s().onPressDo{self.agregar("s")}
		keyboard.t().onPressDo{self.agregar("t")}
		keyboard.r().onPressDo{self.agregar("r")
						   	   self.validarEasterEgg()}
	}
	
	method agregar(letra){
		acumulador.add(letra)
	}
	
	method validarEasterEgg(){
		if (acumulador.join("") == "easter"){
			activado = true
			canion.estado(potente)
			soundProducer.sound("easterEgg.mp3").play()
			self.animacion()
		}
		acumulador.clear()
	}
	
	method animacion(){
		game.addVisual(self)
		self.bailarHuevo()
		game.schedule(2500, {game.removeVisual(self)})
	}
	
	method bailarHuevo(){
		game.schedule(100, {self.image("easterEggIzq.png")})
		game.schedule(200, {self.image("easterEgg.png")})
		game.schedule(300, {self.image("easterEggDer.png")})
		game.schedule(400, {self.image("easterEgg.png")})
		game.schedule(500, {self.image("easterEggIzq.png")})
		game.schedule(600, {self.image("easterEgg.png")})
		game.schedule(700, {self.image("easterEggDer.png")})
		game.schedule(800, {self.image("easterEgg.png")})
		game.schedule(900, {self.image("easterEggIzq.png")})
		game.schedule(1000, {self.image("easterEgg.png")})
		game.schedule(1100, {self.image("easterEggDer.png")})
		game.schedule(1200, {self.image("easterEgg.png")})
		game.schedule(1300, {self.image("easterEggIzq.png")})
		game.schedule(1400, {self.image("easterEgg.png")})
		game.schedule(1500, {self.image("easterEggDer.png")})
		game.schedule(1600, {self.image("easterEgg.png")})
	}

}
