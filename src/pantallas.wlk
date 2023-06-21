import wollok.game.*
import canion.*
import naves.*
import balas.*
import posDir.*
import score.*
import nombre.*
import pantallaInicial.*
import pantallaEleccion.*

object actual {

	var property pantalla = null
	var property nivel = nivel1
	
	method nivelActual() {
		return nivel.numero()
	}
	
	method indicador() {
		return pantalla.indicador()
	}

}


object pantallaInicial {
	 const property image = "fondoPantallaInicial.jpg"
	 const property position = new Posicion(x = 0, y = 0)
	 const property indicador = puntero
	
	method iniciar() {
		game.clear()
		actual.pantalla(self)
		game.addVisual(self)
		game.addVisual(spaceInvaders)
		game.addVisual(iniciarJuego)
		game.addVisual(comoJugar)
		game.addVisual(wolollok)
		game.addVisual(puntero)
	
		keyboard.up().onPressDo({puntero.subir()})
		keyboard.down().onPressDo({puntero.bajar()})
		keyboard.enter().onPressDo({actual.indicador().iniciar(game.uniqueCollider(actual.indicador()))})
	}
	
	method siguientePantalla() {
		game.clear()
		pantallaEleccion.iniciar()
	}	
}

object pantallaEleccion {
	const property image = "fondoEleccion.png"
	const property position = new Posicion(x = 0, y = 0)
	const property indicador = puntero2
	method iniciar() {
		actual.pantalla(self)
		game.addVisual(self)
		game.addVisual(puntero2)
		game.addVisual(canionNormal)
		game.addVisual(canionRosa)
		game.addVisual(canionDorado)
		game.addVisual(canionVerde)
		game.addVisual(canionNaranja)
		game.addVisual(canionAzul)
		
		keyboard.left().onPressDo({ puntero2.moverIzquierda() })
		keyboard.right().onPressDo({ puntero2.moverDerecha() })
		
	}
}
object pantallaNombre {

	const property image = "fondoNombre.png"
	const property position = new Posicion(x = 0, y = 0)
	const property indicador = punteroNombre

	method iniciar() {
		game.addVisual(punteroNombre)
		actual.pantalla(self)
		game.addVisual(self)
		game.addVisualIn(nombre, new Posicion(x = 14, y = 13))
		nombre.iniciarTeclas()
	}

	method siguientePantalla() {
		game.clear()
		nivel1.iniciar()
	}

}

object nivel1 {

	const property image = "fondo1.jpg"
	const property position = new Posicion(x = 0, y = 0)
	const property siguienteNivel = nivel2
	const property numero = 1

	method iniciar() {
		game.clear()
		actual.nivel(self)
		actual.pantalla(self)
		game.addVisual(self)
		factories.forEach{ factory => factory.construirNaves()}
		gestorDeVidas.inicializarVidas()
		game.schedule(1000, { balaNave.nuevoDisparo()})
		movimiento.mover(ovnis)
			// VISUALES
		game.addVisual(canion)
		game.addVisual(nombre)
		ovnis.forEach{ ovni => game.addVisual(ovni)}
		scoreCompleto.forEach{ puntaje => game.addVisual(puntaje)}
			// HECHOS CASUALES
		game.schedule(30000, { naveAleatoria.aparecer()})
			// CONTROLES
		keyboard.left().onPressDo{ canion.mover(izquierda)}
		keyboard.right().onPressDo{ canion.mover(derecha)}
		keyboard.space().onPressDo{ canion.disparar()}
		
	
	}

	method siguientePantalla() {
		game.clear()
		siguienteNivel.iniciar()
	}
	
	method reiniciarJuego() {
		game.clear()
		gestorDeVidas.vidas([uno, dos, tres])
		score.puntaje(100000)
		self.iniciar()
	}

	method serDaniado(objeto) {}
}

object nivel2 {

	const property image = "fondo2.png"
	const property position = new Posicion(x = 0, y = 0)
	const property siguienteNivel = nivel3
	const property numero = 2

	method iniciar() {
		actual.nivel(self)
		actual.pantalla(self)
		game.addVisual(self)
		factories.forEach{ factory => factory.construirNaves()}
		gestorDeVidas.inicializarVidas()
		game.schedule(1000, { balaNave.nuevoDisparo()})
		movimiento.mover(ovnis)
			// VISUALES
		game.addVisual(canion)
		game.addVisual(nombre)
		ovnis.forEach{ ovni => game.addVisual(ovni)}
		scoreCompleto.forEach{ puntaje => game.addVisual(puntaje)}
			// HECHOS CASUALES
		game.schedule(10000, { naveAleatoria.aparecer()})
			// CONTROLES
		keyboard.left().onPressDo{ canion.mover(izquierda)}
		keyboard.right().onPressDo{ canion.mover(derecha)}
		keyboard.space().onPressDo{ canion.disparar()}
	}

	method siguientePantalla() {
		game.clear()
		siguienteNivel.iniciar()
	}
	
	method serDaniado(objeto) {}
}

object nivel3 {

	const property image = "fondo3.png"
	const property position = new Posicion(x = 0, y = 0)
	const property siguienteNivel = pantallaGanaste
	const property numero = 3

	method iniciar() {
		actual.nivel(self)
		actual.pantalla(self)
		game.addVisual(self)
		factories.forEach{ factory => factory.construirNaves()}
		gestorDeVidas.inicializarVidas()
		game.schedule(1000, { balaNave.nuevoDisparo()})
		movimiento.mover(ovnis)
			// VISUALES
		game.addVisual(canion)
		game.addVisual(nombre)
		ovnis.forEach{ ovni => game.addVisual(ovni)}
		scoreCompleto.forEach{ puntaje => game.addVisual(puntaje)}
			// HECHOS CASUALES
		game.onTick(10000, "Agregar nave aleatoria", { naveAleatoria.aparecer()})
			// CONTROLES
		keyboard.left().onPressDo{ canion.mover(izquierda)}
		keyboard.right().onPressDo{ canion.mover(derecha)}
		keyboard.space().onPressDo{ canion.disparar()}
	}

	method siguientePantalla() {
		game.clear()
		siguienteNivel.iniciar()
	}
	
	method serDaniado(objeto) {}
}

object pantallaGanaste {
	
}
object fondoPerder1 {
	var property image = "fondoPantallaInicial.jpg"
	const property position = new Position(x = 0, y = 0)
	method iniciar() {
		ovnis.clear()
		balaCanion.eliminarse()
		balaNave.eliminarse()
		game.removeTickEvent("moverOvnis")
		game.clear()
		game.addVisual(self)	
		self.iniciarAnimacion()
	}
	
	method iniciarAnimacion() {
		game.schedule(400, {=> self.image("fondoPerder1.jpg")
							game.sound("perder.mp3").play()
		})
		game.schedule(700, {=> self.image("fondoPerder2.jpg")})
		game.schedule(1000, {=> self.image("fondoPerder3.jpg")})
		game.schedule(1300, {=> gameOver.iniciar()})
	}
}
	

object gameOver {

	const property image = "gameOver.jpg"

	const property position = new Posicion ( x = 0, y = 0)
	method iniciar(){
		game.clear()
		ovnis.clear()
		game.addVisual(self)
		scoreCompleto.forEach{ puntaje => puntaje.puntajeFinal()}
		keyboard.r().onPressDo{ actual.nivel().reiniciarJuego()}
		keyboard.e().onPressDo{ game.stop()}
	}

}

