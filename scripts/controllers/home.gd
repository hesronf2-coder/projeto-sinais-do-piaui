extends Node



func _ready() -> void:
	pass


#botão ir para o modo aprender
func _on_button_aprender_pressed() -> void:
	$Control/AudioButton.play()
	get_tree().change_scene_to_file("res://scenes/tela_aprender.tscn")

#botão ir para a o modo desafio	
func _on_button_desafio_pressed() -> void:
	$Control/AudioButton.play()
	get_tree().change_scene_to_file("res://scenes/tela_desafio.tscn")

#botão sair do app
func _on_button_quit_pressed() -> void:
	$Control/AudioButton.play()
	get_tree().quit()
