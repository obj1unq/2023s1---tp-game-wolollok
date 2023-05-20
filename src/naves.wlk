import wollok.game.*
import canion.*
import balas.*
import direcciones.*
import score.*
import randomizer.*

const factories = [naveConFuegoFactory, nave3PatasFactory, nave2PatasFactory]
const ovnis = []

const ovnis2Patas = []

object movimiento {

	var property direccion = derecha

	method mover(ovnis) {
		game.onTick(2000, "moverOvnis", {=>
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
		ovnis.forEach{ nave => nave.mover(dir.nuevaPosicion(nave))}
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
			balaNave.disparar(self)
		}
	}

}

class NaveConFuego inherits Nave(image = "nave1.png", puntaje = 200) {

}

class Nave3Patas inherits Nave(image = "nave2.png", puntaje = 500) {

}

class Nave2Patas inherits Nave(image = "nave3.png", puntaje = 1000) {

}

object naveConFuegoFactory{
	
	method construir(x){
		return new NaveConFuego(position = game.at(x,14) )
	}

	method construirNaves(){
		const columnas = new Range(start = 0, end=20, step=2)
		columnas.forEach{posicionX => ovnis.add(self.construir(posicionX))}
	}
}

object nave3PatasFactory{
	
	method construir(x){
		return new Nave3Patas(position = game.at(x,16) )
	}

	method construirNaves(){
		const columnas = new Range(start = 0, end=20, step=2)
		columnas.forEach{posicionX => ovnis.add(self.construir(posicionX))}
	}
}

object nave2PatasFactory{
	
	method construir(x){
		return new Nave3Patas(position = game.at(x,18) )
	}

	method construirNaves(){
		const columnas = new Range(start = 0, end=20, step=2)
		columnas.forEach{posicionX => ovnis.add(self.construir(posicionX))}
	}
}




object naveAleatoria inherits Nave(position = game.at(0, 18), image = "navecita.png") {

	var property direccionamiento = null
	
	method aparecer() {
		self.image("navecita.png")
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

	override method disparar() {
	}

	override method puntaje() = 1000.randomUpTo(1500)

}

object movimientoNaveAleatoria {

	method mover(nave) {
		game.onTick(500, "moverNaveAleatoria", {=>
			if (not nave.direccionamiento().estaEnElBorde(nave)) {
				nave.mover(self.nuevaPosicion(nave))
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

const direcAleatorias = [ derecha, izquierda ]

