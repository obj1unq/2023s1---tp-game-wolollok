import wollok.game.*
import naves.*
import balas.*
import canion.*

object abajo {

	method nuevaPosicion(objeto) {
		const x = objeto.position().x()
		const y = objeto.position().y() - 1
		return game.at(x, y)
	}
	
	method estaEnElBorde(objeto) {
		return objeto.position().y() == 0
	}
}

object arriba {

	method nuevaPosicion(objeto) {
		const x = objeto.position().x()
		const y = objeto.position().y() + 1
		return game.at(x, y)
	}
	
	method estaEnElBorde(objeto) {
		return objeto.position().y() == game.height()
	}
}

object izquierda {

	method x() = game.width() - 1
	method siguiente() {
		return derecha
	}

	method estaEnElBorde(objeto) {
		return objeto.position().x() == 0
	}

	method nuevaPosicion(objeto) {
		const x = objeto.position().x() - 1
		const y = objeto.position().y()
		return game.at(x, y)
	}
}

object derecha {
	
	method x() = 0
	
	method siguiente() {
		return izquierda
	}

	method estaEnElBorde(objeto) {
		return objeto.position().x() == game.width() - 1
	}

	method nuevaPosicion(objeto) {
		const x = objeto.position().x() + 1
		const y = objeto.position().y()
		return game.at(x, y)
	}
}

const direcAleatorias = [ derecha, izquierda ]

