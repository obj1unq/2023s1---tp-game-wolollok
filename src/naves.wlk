import wollok.game.*
import canion.*
import balas.*
import direcciones.*
import score.*
import randomizer.*

const ovnis = [ nave10, nave11, nave12, nave13, nave14, nave15, nave16, nave17, nave18, nave19, 
				nave20, nave21, nave22, nave23, nave24, nave25, nave26, nave27, nave28, nave29, 
				nave30, nave31, nave32, nave33, nave34, nave35, nave36, nave37, nave38, nave39]

const ovnis2Patas = [nave30, nave31, nave32, nave33, nave34, nave35, nave36, nave37, nave38, nave39 ]
object movimiento {

	var property direccion = derecha

	method mover(ovnis) {
		game.onTick(600, "moverOvnis", {=>
			if (!ovnis.any({ nave => direccion.estaEnElBorde(nave)})) {
				ovnis.forEach{ nave => nave.mover(direccion.nuevaPosicion(nave))}
			} else if (!ovnis.isEmpty()) {
				ovnis.forEach{ nave => nave.mover(abajo.nuevaPosicion(nave))}
				direccion = direccion.siguiente()
			} else {
				game.removeTickEvent("moverOvnis")
			}
		})
	}
}

class Nave {

	var property image
	var property position
	const property puntaje

	method mover(_posicion) {
		if (self.puedeMover(_posicion)) {
			position = _posicion
		}
	}

	method puedeMover(_posicion) {
		return _posicion.x().between(0, game.width() - 1)
	}

	method serDestruido() {
		game.sound("explosion1.mp3").play()
		self.image("explosion1.png")
		game.schedule(200, {=> self.image("explosion2.png")})
		game.schedule(400, {=> self.image("explosion3.png")})
		game.schedule(600, {=> game.removeVisual(self)})
		score.scorear(puntaje)
	}

	method disparar() {
		if (not game.hasVisual(balaNave)) {
			game.sound("disparoNave.mp3").play()
			balaNave.disparar(position)
		}
	}

}


class NaveConFuego inherits Nave(image = "nave1.png", puntaje = 200) {}

class Nave3Patas inherits Nave(image = "nave2.png", puntaje = 500) {}

class Nave2Patas inherits Nave(image = "nave3.png", puntaje = 1000) {}


// NAVES CON FUEGO


object nave10 inherits NaveConFuego(position = game.at(1, 14)) {}

object nave11 inherits NaveConFuego(position = game.at(3, 14)) {}

object nave12 inherits NaveConFuego(position = game.at(5, 14)) {}

object nave13 inherits NaveConFuego(position = game.at(7, 14)) {}

object nave14 inherits NaveConFuego(position = game.at(9, 14)) {}

object nave15 inherits NaveConFuego(position = game.at(11, 14)) {}

object nave16 inherits NaveConFuego(position = game.at(13, 14)) {}

object nave17 inherits NaveConFuego(position = game.at(15, 14)) {}

object nave18 inherits NaveConFuego(position = game.at(17, 14)) {}

object nave19 inherits NaveConFuego(position = game.at(19, 14)) {}


// NAVES 3 PATAS


object nave20 inherits Nave3Patas(position = game.at(1, 16)) {}

object nave21 inherits Nave3Patas(position = game.at(3, 16)) {}

object nave22 inherits Nave3Patas(position = game.at(5, 16)) {}

object nave23 inherits Nave3Patas(position = game.at(7, 16)) {}

object nave24 inherits Nave3Patas(position = game.at(9, 16)) {}

object nave25 inherits Nave3Patas(position = game.at(11, 16)) {}

object nave26 inherits Nave3Patas(position = game.at(13, 16)) {}

object nave27 inherits Nave3Patas(position = game.at(15, 16)) {}

object nave28 inherits Nave3Patas(position = game.at(17, 16)) {}

object nave29 inherits Nave3Patas(position = game.at(19, 16)) {}


// NAVES 2 PATAS


object nave30 inherits Nave2Patas(position = game.at(1, 18)) {}

object nave31 inherits Nave2Patas(position = game.at(3, 18)) {}

object nave32 inherits Nave2Patas(position = game.at(5, 18)) {}

object nave33 inherits Nave2Patas(position = game.at(7, 18)) {}

object nave34 inherits Nave2Patas(position = game.at(9, 18)) {}

object nave35 inherits Nave2Patas(position = game.at(11, 18)) {}

object nave36 inherits Nave2Patas(position = game.at(13, 18)) {}

object nave37 inherits Nave2Patas(position = game.at(15, 18)) {}

object nave38 inherits Nave2Patas(position = game.at(17, 18)) {}

object nave39 inherits Nave2Patas(position = game.at(19, 18)) {}

object naveAleatoria inherits Nave(position = game.at(0, 18), image = "canion.png") {
	var property direccionamiento
	
	method aparecer() {
		self.generarPosicion()
		game.addVisual(self)
		self.generarAccionar()
	}
	method generarAccionar() {
		movimientoNaveAleatoria.mover(self)
		
	}
	
	method direccion() {
		direccionamiento = direcAleatorias.anyOne()
	}
	
	method generarPosicion() {
		self.direccion()
		const posicion = randomizer.position(self)
		position = posicion
	}
	
	override method serDestruido() {
		game.sound("explosion1.mp3").play()
		self.image("explosion1.png")
		game.schedule(200, {=> self.image("explosion2.png")})
		game.schedule(400, {=> self.image("explosion3.png")})
		game.schedule(600, {=> game.removeVisual(self)})
		score.scorear(self.puntaje())
	}
	override method disparar() {}
	
	override method puntaje() = 1000.randomUpTo(1500)
}

object movimientoNaveAleatoria {

	
	method mover(nave) {
	game.onTick(100, "moverNaveAleatoria", {=>
			if (not nave.direccionamiento().estaEnElBorde(nave)) {
				nave.direccionamiento().nuevaPosicion(nave)
			} else {
				game.removeTickEvent("moverNaveAleatoria")
				game.removeVisual(nave)
			} 
			
		})
}	
}
const direcAleatorias = [derecha, izquierda]

