extends Control

#Ruta de la carpeta con la música
var path_ost: String = "res://Assets/OST/"


func _ready() -> void:
	dir_contents()
	get_tree().quit()


func dir_contents() -> void:
	var dir = DirAccess.open(path_ost)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			create_audio_node(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Error al abrir el directorio")


func create_audio_node(file_name: String) -> void:
	var node_playlist = AudioStreamPlayer.new()
	var stream
	var scene = PackedScene.new()
	var save_path = "res://Aunar_template/" + file_name.substr(2) + ".tscn"
	var sound_path = path_ost + file_name

	match file_name.substr(0,1):
		"P":
			stream = AudioStreamPlaylist.new()
		"I":
			stream = AudioStreamInteractive.new()
		"S":
			stream = AudioStreamSynchronized.new()

	node_playlist.set_name(file_name.substr(2))
	node_playlist.set_stream(stream)

	var dir = DirAccess.open(sound_path)
	if dir:
		dir.list_dir_begin()
		var sound_name = dir.get_next()
		var number_channels: int = 0
		while sound_name != "":
			if sound_name.ends_with(".wav") or file_name.ends_with(".mp3") or file_name.ends_with(".ogg"):
					number_channels += 1
					match file_name.substr(0,1):
						"P":
							node_playlist.stream.set_stream_count(number_channels)
							node_playlist.stream.set_list_stream(number_channels - 1, load(sound_path +"/"+ sound_name))
						"I":
							node_playlist.stream.set_clip_count(number_channels)
							node_playlist.stream.set_clip_stream(number_channels - 1, load(sound_path +"/"+ sound_name))
							node_playlist.stream.set_clip_name(number_channels - 1, sound_name.get_basename())
						"S":
							node_playlist.stream.set_stream_count(number_channels)
							node_playlist.stream.set_sync_stream(number_channels - 1, load(sound_path +"/"+ sound_name))
			sound_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Error al abrir archivo de audio")

	scene.pack(node_playlist)
	ResourceSaver.save(scene, save_path)
