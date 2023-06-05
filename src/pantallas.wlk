import wollok.game.*
import canion.*
import naves.*
import balas.*
import posDir.*
import score.*
import nombre.*
import pantallaInicial.*

object actual {

	var property pantalla = null

}


object pantallaInicial {
	 const property image = "fondoPantallaInicial.jpg"
	 const property position = new Posicion(x = 0, y = 0)
	
	method iniciar() {
		game.addVisual(self)
		game.addVisual(spaceInvaders)
		game.addVisual(iniciarJuego)
		game.addVisual(comoJugar)
		game.addVisual(wolollok)
		game.addVisual(puntero)
	
		keyboard.up().onPressDo({puntero.subir()})
		keyboard.down().onPressDo({puntero.bajar()})
		keyboard.right().onPressDo({puntero.iniciarPantalla(game.uniqueCollider(puntero))})
	}
	
	method siguientePantalla() {
		game.clear()
		pantallaNombre.iniciar()
	}	
}

object pantallaNombre {

	const property image = "fondoNombre.png"
	const property position = new Posicion(x = 0, y = 0)

	method iniciar() {
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

	method iniciar() {
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

}

object nivel2 {

	const property image = "fondo2.png"
	const property position = new Posicion(x = 0, y = 0)
	const property siguienteNivel = nivel3

	method iniciar() {
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

}

object nivel3 {

	const property image = "fondo3.png"
	const property position = new Posicion(x = 0, y = 0)
	const property siguienteNivel = pantallaGanaste

	method iniciar() {
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

}

object pantallaGanaste {

}

object gameOver {

	const property image = "gameOver.jpg"

	const property position = new Posicion ( x = 0, y = 0)
	method iniciar(){
		
		balaCanion.eliminarse()
		balaNave.eliminarse()
		game.removeTickEvent("moverOvnis")
		game.removeTickEvent("Agregar nave aleatoria")
		game.clear()
		ovnis.clear()
		game.addVisual(self)
		scoreCompleto.forEach{ puntaje => puntaje.puntajeFinal()}
		keyboard.r().onPressDo{ nivel1.reiniciarJuego()}
		keyboard.e().onPressDo{ game.stop()}
	}

}

