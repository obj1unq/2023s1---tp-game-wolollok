import wollok.game.*
import canion.*
import balas.*
import posDir.*
import score.*
import randomizer.*

const factories = [naveConFuegoFactory, nave3PatasFactory, nave2PatasFactory]
const ovnis = []

object movimiento {

	var property direccion = derecha

	method mover(ovnis) {
		game.onTick(500, "moverOvnis", {=>
			if (not self.hayAlgunOvniAlBorde()) {
				self.moverOvnisDePosicion(direccion)
			} else {
			direccion = direccion.siguiente()
			self.moverOvnisDePosicion(abajo)
		}})
	}

	method hayAlgunOvniAlBorde() {
		return ovnis.any({ nave => direccion.estaEnElBorde(nave) })
	}

	method moverOvnisDePosicion(dir) {
		ovnis.forEach{ nave => nave.mover(dir)}
	}

}

class Nave {

	var property image
	var property position

	method mover(direccion) {
		if (self.puedeMover(direccion)) {
			direccion.nuevaPosicion(position)
		}
	}

	method puedeMover(direccion) {
		return not (direccion.estaEnElBorde(self))
	}

	method serDestruido() {
		game.sound("explosion1.mp3").play()
		self.image("explosion1.png")
		game.schedule(200, {=> self.image("explosion2.png")})
		game.schedule(400, {=> self.image("explosion3.png")})
		game.schedule(600, {=> game.removeVisual(self)})
		score.scorear(self.puntaje())
	}

	method disparar() {
		if (not game.hasVisual(balaNave)) {
			game.sound("disparoNave.mp3").play()
			balaNave.disparar(self)
		}
	}
	
	method puntaje()
	method serDaniado(objeto) {
	
	}
}

class NaveConFuego inherits Nave(image = "nave1.png") {
	override method puntaje() {
		return 200
	}
}

class Nave3Patas inherits Nave(image = "nave2.png") {
	override method puntaje() {
		return 500
	}
}

class Nave2Patas inherits Nave(image = "nave3.png") {
	override method puntaje() {
		return 1000
	}
}

class Factory {
	method construirNaves(){
		const columnas = new Range(start = 0, end=20, step=2)
		columnas.forEach{posicionX => ovnis.add(self.construir(posicionX))}
	}
	method construir(parametroDeX)
}
object naveConFuegoFactory inherits Factory{
	
	override method construir(posX){
		return new NaveConFuego(position = new Posicion(x = posX, y = 14) )
	}
}

object nave3PatasFactory inherits Factory{
	
	override method construir(posX){
		return new Nave3Patas(position = new Posicion(x = posX, y = 16) )
	}
}

object nave2PatasFactory inherits Factory{
	
	override method construir(posX){
		return new Nave2Patas(position = new Posicion(x = posX, y = 18) )
	}
}

object naveAleatoria inherits Nave(position = new Posicion(x = 0, y = 0), image = "navecita.png") {

	var property direccionamiento = null
	
	method aparecer() {
		self.generarPosicion()
		game.addVisual(self)
		self.generarAccionar()
	}

	method generarAccionar() {
		movimientoNaveAleatoria.mover(self)
	}

	method generarPosicion() {
		direccionamiento = direcAleatorias.anyOne()
		randomizer.position(direccionamiento, position)
	}

	override method disparar() {
	}

	override method puntaje() = 1000.randomUpTo(1500)

}

object movimientoNaveAleatoria {

	method mover(nave) {
		game.onTick(500, "moverNaveAleatoria", {=>
			if (not nave.direccionamiento().estaEnElBorde(nave)) {
				nave.mover(nave.direccionamiento())
			} else {
				game.removeTickEvent("moverNaveAleatoria")
				game.removeVisual(nave)
			}
	 	})
	}

	method nuevaPosicion(nave) {
		return nave.direccionamiento().nuevaPosicion(nave)
	}
}