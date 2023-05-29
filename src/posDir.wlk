import wollok.game.*
import naves.*
import balas.*
import canion.*

class Posicion{
	
	var property x
	var property y
	
	method up(){
		y += 1
	}
	
	method down(){
		y -= 1
	}
	
	method right(){
		x += 1
	}
	
	method left(){
		x -= 1
	}
	
	method clonar(objeto){
		x = objeto.position().x()
		y = objeto.position().y()
	}
}

object abajo {

	method nuevaPosicion(posicion) {
		posicion.down()
	}
	
	method estaEnElBorde(objeto) {
		return objeto.position().y() == 0
	}
}

object arriba {

	method nuevaPosicion(posicion) {
		posicion.up()
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

	method nuevaPosicion(posicion) {
		posicion.left()
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

	method nuevaPosicion(posicion) {
		posicion.right()
	}
}

const direcAleatorias = [ derecha, izquierda ]

