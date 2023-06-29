import wollok.game.*
import naves.*
import balas.*
import posDir.*
import pantallas.*
import pantallaPerder.*
import sound.*
import easterEgg.*

object canion {

	var property position = new Posicion(x = game.center().x(), y = 1)
	var property estado = normal

	method image() = estado.image()

	method mover(direccion) {
		if (self.puedeMover(direccion)) {
			direccion.nuevaPosicion(position)
		}
	}

	method puedeMover(direccion) {
		return not direccion.estaEnElBorde(self)
	}

	method disparar() {
		estado.disparar(self)
	}

	method serDaniado(objeto) {
		objeto.serDestruido()
		estado.serDaniado()
	}

	method ganarBeneficio() {
		gestorDeBeneficios.asignar(self)
	}

	method volverANormalidad() {
		estado = normal
	}

}

object gestorDeVidas {

	var property vidas = [ uno, dos, tres ]

	method perderVida() {
		self.ultimaVida().eliminarse()
		vidas.remove(self.ultimaVida())
	}

	method inicializarVidas() {
		vidas.forEach{ vida => game.addVisual(vida)}
	}

	method ultimaVida() {
		return vidas.last()
	}

}

class Vida {

	const property position

	method image() {
		return "vida.png"
	}

	method eliminarse() {
		soundProducer.sound("dos-vida.mp3").play()
		game.removeVisual(self)
	}

	method serDaniado(objeto) {
	}

}

object uno inherits Vida(position = new Posicion(x = 0, y = 0)) {

	override method eliminarse() {
		super()
		fondoPerder.formaDePerder(corazonPerder)
		fondoPerder.iniciar()
	}

}

object dos inherits Vida(position = new Posicion(x = 1, y = 0)) {}

object tres inherits Vida(position = new Posicion(x = 2, y = 0)) {}

class Estado {

	const tipoDeBala
	var property image = self.toString() + "Canion.png" 

	method disparar(canion) {
		if (not game.hasVisual(tipoDeBala)) {
			soundProducer.sound("disparoCanion.mp3").play()
			tipoDeBala.disparar(canion)
		}
	}

	method serDaniado() {
		gestorDeVidas.perderVida()
	}
	
	method volverANormalidad() {
		if (easterEgg.activado()){
			canion.estado(wolollokJugar)
		} else {
			canion.estado(normal)
		
		}
	}
}

object normal inherits Estado(tipoDeBala = balaCanion) {}

object inmune inherits Estado(tipoDeBala = balaCanion) {

	override method serDaniado() {}

}

object potente inherits Estado(tipoDeBala = balaPotente) {} /*Este estado mata un radio de naves */

object veloz inherits Estado(tipoDeBala = balaVeloz) {}

object laser inherits Estado(tipoDeBala = balaLaser) {}
object wolollokJugar inherits Estado(tipoDeBala = balaPotente, image = "wolollokJugar.png") {}

object gestorDeBeneficios {

	const beneficios = [ inmune, potente, veloz, laser ]

	method asignar(objeto) {
		const beneficioAzar = beneficios.anyOne()
		objeto.estado(beneficioAzar)
		game.schedule(10000, { beneficioAzar.volverANormalidad()})
	}
}

