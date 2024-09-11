extends Control

var layers_audio: int = 1

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	audio.stream.set_stream_count(layers_audio)
	audio.play()


func _on_add_pressed() -> void:
	layers_audio += 1
	if layers_audio >= 18:
		layers_audio = 17
	var new_layers_audio = layers_audio
	audio.stream.set_stream_count(new_layers_audio)
	print(new_layers_audio)
	audio.play()


func _on_subtract_pressed() -> void:
	layers_audio -= 1
	if layers_audio <= 0:
		layers_audio = 0
	var new_layers_audio = layers_audio
	audio.stream.set_stream_count(new_layers_audio)
	print(new_layers_audio)
	audio.play()
