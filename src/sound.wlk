import wollok.game.*

object soundProducer {

	var cancion
	var provider = game
	var volumenFX = 0.1
	var volumenMusica = 0.2

	method provider(_provider) {
		provider = _provider
	}

	method sound(audioFile) {
		const audio = provider.sound(audioFile)
		audio.volume(volumenFX)
		return audio
	}

	method soundMusic(audioFile) {
		const audio = provider.sound(audioFile)
		audio.volume(volumenMusica)
		return audio
	}

	method subirVolumenFX() {
		volumenFX = (volumenFX + 0.1).min(1)
	}

	method bajarVolumenFX() {
		volumenFX = (volumenFX - 0.1).max(0)
	}

	method subirVolumenMusica() {
		volumenMusica = (volumenMusica + 0.1).min(1)
		cancion.volume(volumenMusica)
	}

	method bajarVolumenMusica() {
		volumenMusica = (volumenMusica - 0.1).max(0)
		cancion.volume(volumenMusica)
	}

	method playCancion(audioFile) {
		cancion = provider.sound(audioFile)
		cancion.volume(volumenMusica)
		cancion.play()
	}

}

object soundProviderMock {

	method sound(audioFile) = soundMock

}

object soundMock {

	method play() {
	}

}
