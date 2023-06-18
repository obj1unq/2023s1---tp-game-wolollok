import wollok.game.*
import canion.*
import pantallas.*
import posDir.*

object nombre {
	
	var property nombre = []
	
	method position(){
		return new Posicion (x = canion.position().x(), y = 0)
	}
	
	method text() = nombre.join("")

	method textColor() = "ffffffff"
	
	method agregar(letra){
	 	nombre.add(letra)
	}
	
	method borrarUltima(){
			nombre = nombre.take(nombre.size()-1)
	}
	
	method serDaniado(objeto){}
	
		
	method iniciarTeclas(){
	
	
	//ALFANUMERICOS
	
	keyboard.a().onPressDo{self.agregar("A")}
	keyboard.b().onPressDo{self.agregar("B")}
	keyboard.c().onPressDo{self.agregar("C")}
	keyboard.d().onPressDo{self.agregar("D")}
	keyboard.e().onPressDo{self.agregar("E")}
	keyboard.f().onPressDo{self.agregar("F")}
	keyboard.g().onPressDo{self.agregar("G")}
	keyboard.h().onPressDo{self.agregar("H")}
	keyboard.i().onPressDo{self.agregar("I")}
	keyboard.j().onPressDo{self.agregar("J")}
	keyboard.k().onPressDo{self.agregar("K")}
	keyboard.l().onPressDo{self.agregar("L")}
	keyboard.m().onPressDo{self.agregar("M")}
	keyboard.n().onPressDo{self.agregar("N")}
	keyboard.o().onPressDo{self.agregar("O")}
	keyboard.p().onPressDo{self.agregar("P")}
	keyboard.q().onPressDo{self.agregar("Q")}
	keyboard.r().onPressDo{self.agregar("R")}
	keyboard.s().onPressDo{self.agregar("S")}
	keyboard.t().onPressDo{self.agregar("T")}
	keyboard.u().onPressDo{self.agregar("U")}
	keyboard.v().onPressDo{self.agregar("V")}
	keyboard.w().onPressDo{self.agregar("W")}
	keyboard.x().onPressDo{self.agregar("X")}
	keyboard.y().onPressDo{self.agregar("Y")}
	keyboard.z().onPressDo{self.agregar("Z")}
	keyboard.space().onPressDo{self.agregar(" ")}
	keyboard.num0().onPressDo{self.agregar(0)}
	keyboard.num1().onPressDo{self.agregar(1)}
	keyboard.num2().onPressDo{self.agregar(2)}
	keyboard.num3().onPressDo{self.agregar(3)}
	keyboard.num4().onPressDo{self.agregar(4)}
	keyboard.num5().onPressDo{self.agregar(5)}
	keyboard.num6().onPressDo{self.agregar(6)}
	keyboard.num7().onPressDo{self.agregar(7)}
	keyboard.num8().onPressDo{self.agregar(8)}
	keyboard.num9().onPressDo{self.agregar(9)}
	
	
	//CONTROL
	
	keyboard.backspace().onPressDo{self.borrarUltima()}
	}
}
