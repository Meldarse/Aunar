extends Control

var path_ost: String = "res://Assets/OST/APZX_CyberMower/"


@onready var audio: AudioStreamPlayer = $AudioStreamPlayer



func _ready() -> void:
	audio.stream.set_stream_count(5)
	print(audio.stream.get_stream_count())
	dir_contents(path_ost)


func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			elif file_name.ends_with(".wav"):
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
