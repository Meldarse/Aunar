extends Control

#Ruta de la carpeta con la música
var path_ost: String = "res://Assets/OST/"


func _ready() -> void:
	dir_contents(path_ost)

	#audio.stream.set_stream_count(5)
	#print(audio.stream.get_stream_count())



func dir_contents(path: String) -> void:
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			create_audio_node(file_name.substr(0, 1), file_name.substr(2))
			#print("Nombre del archivo/subdirectorio: ", file_name)
			#print("Es un directorio: ", dir.current_is_dir())
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Error al abrir el directorio")

func create_audio_node(type: String, name_node: String) -> void:
	var node_playlist = AudioStreamPlayer.new()
	var stream
	var scene = PackedScene.new()
	var save_path = "res://Aunar_template/" + name_node + ".tscn"
	match type:
		"P":
			stream = AudioStreamPlaylist.new()
		"I":
			stream = AudioStreamInteractive.new()
		"S":
			stream = AudioStreamSynchronized.new()
	node_playlist.set_name(name_node)
	node_playlist.set_stream(stream)
	scene.pack(node_playlist)
	ResourceSaver.save(scene, save_path)
