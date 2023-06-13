import wollok.game.*
import naves.*
import balas.*
import posDir.*
import pantallas.*

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
		game.sound("dos-vida.mp3").play()
		game.removeVisual(self)
	}

	method serDaniado(objeto) {}
}

object uno inherits Vida(position = new Posicion(x = 0, y = 0)) {
	override method eliminarse() {
		super()
		fondoPerder1.iniciar()
	}
 }
object dos inherits Vida(position = new Posicion(x = 1, y = 0)) {}

object tres inherits Vida(position = new Posicion(x = 2, y = 0)) {}

class Estado {
	const tipoDeBala
	method disparar(canion) {
		if (not game.hasVisual(tipoDeBala)) {
			game.sound("disparoCanion.mp3").play()
			tipoDeBala.disparar(canion)
		}
	}
	method serDaniado() {
		gestorDeVidas.perderVida()
	}
}

object normal inherits Estado(tipoDeBala = balaCanion) {
	method image() = "canion.png"
}

object inmune inherits Estado(tipoDeBala = balaCanion) {
	method image() = "canionInmune.png" //Falta imagen de un canion inmune
	
	override method serDaniado() {}
}

object disparoPotente inherits Estado(tipoDeBala = balaPotente) { /*Este estado mata una columna de naves */
	method image() = "canionPotente.png" 
}

object disparoRapido inherits Estado(tipoDeBala = balaVeloz) {
	method image() = "canionVeloz.png"
} 

 object gestorDeBeneficios {
 	const beneficios = [inmune, disparoPotente, disparoRapido]
 	
 	method asignar(objeto) {
 		objeto.estado(beneficios.anyOne())
 		game.schedule(10000, objeto.asignar(normal))
 	}
 }