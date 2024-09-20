extends Control

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	audio.set_stream(load("res://Assets/OST/S_APZX_CyberMower/01_Kick.wav"))
	audio.play()
