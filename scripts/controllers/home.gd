extends Node



func _ready() -> void:
	pass



func _on_button_aprender_pressed() -> void:
	$Control/AudioButton.play()
	get_tree().change_scene_to_file("res://scenes/tela_aprender.tscn")
	
func _on_button_desafio_pressed() -> void:
	$Control/AudioButton.play()
	get_tree().change_scene_to_file("res://scenes/tela_desafio.tscn")
	
func _on_button_quit_pressed() -> void:
	$Control/AudioButton.play()
	get_tree().quit()
