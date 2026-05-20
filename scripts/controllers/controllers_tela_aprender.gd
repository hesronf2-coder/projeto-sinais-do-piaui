extends CanvasLayer

@export var quiz: QuizTheme

var index: int

var current_quiz: QuizQuestion:
	get: return quiz.theme[index]

@onready var question_text: Label = $Control/QuestionText
@onready var question_image: TextureRect = $Control/ImageHolder/QuestionImage
@onready var question_image_2: TextureRect = $Control/ImageHolder/QuestionImage2
@onready var question_video: VideoStreamPlayer = $Control/ImageHolder/QuestionVideo
@onready var question_audio: AudioStreamPlayer = $Control/QuestionAudio

func _ready() -> void:
	
	load_quiz()
	
func load_quiz() -> void:
	question_text.text = current_quiz.question_info
	
	match current_quiz.type:
		
			Enum.QuestionType.IMAGE:
				$Control/ImageHolder.show()
				question_image.texture = current_quiz.question_image
				question_image_2.texture = current_quiz.question_image2
				question_audio.stream = current_quiz.question_audio
			
			Enum.QuestionType.VIDEO:
				$Control/ImageHolder.show()
				question_video.stream = current_quiz.question_video
				question_audio.stream = current_quiz.question_audio
				question_video.play()
	if index == 0:
		$Control/ButtonPrevious.hide()
	else:
		$Control/ButtonPrevious.show()
				
	if index == quiz.theme.size() -1:
		$Control/ButtonNext.hide()
	else:
		$Control/ButtonNext.show()
func _next_question() -> void:
	index += 1
	
func _previous_question() -> void:
	index -= 1


func _on_button_previous_pressed() -> void:
	$Control/AudioButtonPress.play()
	_previous_question()
	load_quiz()
	print(index)	


func _on_button_next_pressed() -> void:
	
	_next_question()
	load_quiz()
	$Control/ImageHolder/QuestionImage2.hide()
	$Control/ImageHolder/QuestionImage.show()
	$Control/AudioButtonPress.play()
	$Control/ButtonInfo.show()
	$Control/ButtonInfoExit.hide()
	print(index)
	

func _on_button_play_audio_pressed() -> void:
	$Control/AudioButtonPress.play()
	question_audio.play()
	$Control/ButtonPlayAudio.hide()
	$Control/ButtonStopAudio.show()
func _on_button_stop_audio_pressed() -> void:
	$Control/AudioButtonPress.play()
	question_audio.stop()
	$Control/ButtonStopAudio.hide()
	$Control/ButtonPlayAudio.show()

func _on_button_info_pressed() -> void:
	$Control/AudioButtonPress.play()
	$Control/ImageHolder/QuestionImage.hide()
	$Control/ImageHolder/QuestionImage2.show()
	$Control/ButtonInfo.hide()
	$Control/ButtonInfoExit.show()

func _on_button_info_exit_pressed() -> void:
	$Control/AudioButtonPress.play()
	$Control/ImageHolder/QuestionImage2.hide()
	$Control/ImageHolder/QuestionImage.show()
	$Control/ButtonInfo.show()
	$Control/ButtonInfoExit.hide()

func _on_button_home_pressed() -> void:
	$Control/AudioButtonPress.play()
	get_tree().change_scene_to_file("res://scenes/tela_home.tscn")
