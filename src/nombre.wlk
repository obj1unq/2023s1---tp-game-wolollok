import wollok.game.*
import canion.*

object nombre {
	
	const property nombre = []
	
	method position(){
		return game.at(canion.position().x(), canion.position().y()-1)
	}
	
	method agregar(letra){
	 	nombre.add(letra)
	}
	
	method borrarUltima(){
		if (nombre.size() > 0){
			nombre.remove(nombre.last())
		}
	}
	
	method text(){
		return nombre.join("")
	}
	
	method inciarTeclas(){
	
	
	//ALFANUMERICOS
	
	keyboard.a().onPressDo{nombre.agregar("A")}
	keyboard.b().onPressDo{nombre.agregar("B")}
	keyboard.c().onPressDo{nombre.agregar("C")}
	keyboard.d().onPressDo{nombre.agregar("D")}
	keyboard.e().onPressDo{nombre.agregar("E")}
	keyboard.f().onPressDo{nombre.agregar("F")}
	keyboard.g().onPressDo{nombre.agregar("G")}
	keyboard.h().onPressDo{nombre.agregar("H")}
	keyboard.i().onPressDo{nombre.agregar("I")}
	keyboard.j().onPressDo{nombre.agregar("J")}
	keyboard.k().onPressDo{nombre.agregar("K")}
	keyboard.l().onPressDo{nombre.agregar("L")}
	keyboard.m().onPressDo{nombre.agregar("M")}
	keyboard.n().onPressDo{nombre.agregar("N")}
	keyboard.o().onPressDo{nombre.agregar("O")}
	keyboard.p().onPressDo{nombre.agregar("P")}
	keyboard.q().onPressDo{nombre.agregar("Q")}
	keyboard.r().onPressDo{nombre.agregar("R")}
	keyboard.s().onPressDo{nombre.agregar("S")}
	keyboard.t().onPressDo{nombre.agregar("T")}
	keyboard.u().onPressDo{nombre.agregar("U")}
	keyboard.v().onPressDo{nombre.agregar("V")}
	keyboard.w().onPressDo{nombre.agregar("W")}
	keyboard.x().onPressDo{nombre.agregar("X")}
	keyboard.y().onPressDo{nombre.agregar("Y")}
	keyboard.z().onPressDo{nombre.agregar("Z")}
	keyboard.space().onPressDo{nombre.agregar(" ")}
	keyboard.num0().onPressDo{nombre.agregar(0)}
	keyboard.num1().onPressDo{nombre.agregar(1)}
	keyboard.num2().onPressDo{nombre.agregar(2)}
	keyboard.num3().onPressDo{nombre.agregar(3)}
	keyboard.num4().onPressDo{nombre.agregar(4)}
	keyboard.num5().onPressDo{nombre.agregar(5)}
	keyboard.num6().onPressDo{nombre.agregar(6)}
	keyboard.num7().onPressDo{nombre.agregar(7)}
	keyboard.num8().onPressDo{nombre.agregar(8)}
	keyboard.num9().onPressDo{nombre.agregar(9)}
	
	
	//CONTROL
	
	keyboard.backspace().onPressDo{nombre.borrarUltima()}

	}
}
