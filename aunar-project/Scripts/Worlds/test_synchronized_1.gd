extends Control

var pause_position: float = 0.0
var bus_index: int

@onready var layers = [%layer_0, %layer_1, %layer_2, %layer_3, %layer_4, %layer_5,
					   %layer_6, %layer_7, %layer_8, %layer_9, %layer_10,
					   %layer_11, %layer_12, %layer_13, %layer_14, %layer_15,
					   %layer_16, %layer_17]
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	for i in range(0, audio.stream.get_stream_count()):
		audio.stream.set_sync_stream_volume(i, -60.0)
		set_red_modulation(layers[i])

	bus_index = AudioServer.get_bus_index("Master")
	_on_v_slider_value_changed(0.4)

	print(audio.stream.get_stream_count())
	print(audio.stream.get_sync_stream_volume(0))


func _on_v_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func set_red_modulation(node):
	node.modulate = Color.RED


func set_green_modulation(node):
	node.modulate = Color.GREEN


func set_layer_volume(layer_index: int) -> void:
	if audio.stream.get_sync_stream_volume(layer_index) == 0:
		audio.stream.set_sync_stream_volume(layer_index, -60.0)
		set_red_modulation(layers[layer_index])
	elif audio.stream.get_sync_stream_volume(layer_index) < 0:
		audio.stream.set_sync_stream_volume(layer_index, 0.0)
		set_green_modulation(layers[layer_index])


func _on_layer_0_button_down() -> void:
	set_layer_volume(0)


func _on_layer_1_button_down() -> void:
	set_layer_volume(1)


func _on_layer_2_button_down() -> void:
	set_layer_volume(2)


func _on_layer_3_button_down() -> void:
	set_layer_volume(3)


func _on_layer_4_button_down() -> void:
	set_layer_volume(4)


func _on_layer_5_button_down() -> void:
	set_layer_volume(5)


func _on_layer_6_button_down() -> void:
	set_layer_volume(6)


func _on_layer_7_button_down() -> void:
	set_layer_volume(7)


func _on_layer_8_button_down() -> void:
	set_layer_volume(8)


func _on_layer_9_button_down() -> void:
	set_layer_volume(9)


func _on_layer_10_button_down() -> void:
	set_layer_volume(10)


func _on_layer_11_button_down() -> void:
	set_layer_volume(11)


func _on_layer_12_button_down() -> void:
	set_layer_volume(12)


func _on_layer_13_button_down() -> void:
	set_layer_volume(13)


func _on_layer_14_button_down() -> void:
	set_layer_volume(14)


func _on_layer_15_button_down() -> void:
	set_layer_volume(15)


func _on_layer_16_button_down() -> void:
	set_layer_volume(16)


func _on_layer_17_button_down() -> void:
	set_layer_volume(17)


func _on_play_button_down() -> void:
	if pause_position == 0.0:
		audio.play()
	elif pause_position != 0.0:
		audio.play(pause_position)
		pause_position = 0.0


func _on_pause_button_down() -> void:
	pause_position = audio.get_playback_position()
	audio.stop()


func _on_stop_button_down() -> void:
	audio.stop()


func _on_close_pressed() -> void:
	get_tree().quit()


func _on_next_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/Worlds/test_synchronized_2.tscn")
