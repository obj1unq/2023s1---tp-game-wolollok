import wollok.game.*

object soundProducer {
	
	var provider = game
	var volumenFX = 0.2
	var volumenMusica = 0.2
	
	method provider(_provider){
		provider = _provider
	}
	
	method sound(audioFile){
		const audio = provider.sound(audioFile)
		audio.volume(volumenFX)
	 	return audio
	}
	
	method soundMusic(audioFile){
		const audio = provider.sound(audioFile)
		audio.volume(volumenMusica)
	 	return audio
	}
	
	method subirVolumenFX(){
		volumenFX = (volumenFX + 0.2).min(1)
	}
	
	method bajarVolumenFX(){
		volumenFX = (volumenFX - 0.2).max(0)
	}
	
	method subirVolumenMusica(){
		volumenMusica = (volumenMusica + 0.2).min(1)
	}
	
	method bajarVolumenMusica(){
		volumenMusica = (volumenMusica - 0.2).max(0)
	}
	
}

object soundProviderMock {
	
	method sound(audioFile) = soundMock
}

object soundMock {
	method play() {}
}
