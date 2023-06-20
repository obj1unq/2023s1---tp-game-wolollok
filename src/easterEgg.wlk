import wollok.game.*
import canionNormal.*

object easterEgg {
	
	const acumulador = []
	
	method iniciarTeclas(){
		keyboard.e().onPressDo{self.agregar("e")}
		keyboard.a().onPressDo{self.agregar("a")}
		keyboard.s().onPressDo{self.agregar("s")}
		keyboard.t().onPressDo{self.agregar("t")}
		keyboard.r().onPressDo{self.agregar("r")
						   	   self.validarEasterEgg()}
	}
	
	method agregar(letra){
		acumulador.add(letra)
	}
	
	method validarEasterEgg(){
		if (acumulador.join("") == "easter"){
			//pantallaOkupas.iniciar()
		}
		acumulador.clear()
	}
	
}
