extends CanvasLayer

@export var quiz: QuizTheme
@export var color_green: Color
@export var color_red: Color

var buttons: Array[Button]
var index: int
var correct: int

var current_quiz: QuizQuestion:
	get: return quiz.theme[index]

@onready var question_image: TextureRect = $Control/ImageHolder/QuestionImage
@onready var question_video: VideoStreamPlayer = $Control/ImageHolder/QuestionVideo
@onready var question_audio: AudioStreamPlayer2D = $Control/ImageHolder/QuestionAudio
@onready var info_text: Label = $Control/QuestionInfo/InfoText



func _ready() -> void:
	correct = 0
	for button in $Control/QuestionOpitions.get_children():
		buttons.append(button)
		
	load_quiz()

func load_quiz() -> void:
	info_text.text = current_quiz.question_info
	
	if index >= quiz.theme.size() - 1:
		_game_progress()
		return
		
	var options = current_quiz.options
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))
		
		match current_quiz.type:
		
			Enum.QuestionType.IMAGE:
				$Control/ImageHolder.show()
				question_image.texture = current_quiz.question_image
			
			Enum.QuestionType.VIDEO:
				$Control/Fundoimagem.show()
				question_video.stream = current_quiz.question_video
				question_video.play()
func _buttons_answer(button) -> void:
		
	if current_quiz.correct == button.text:
		button.modulate = color_green
		
		correct += 1
		$AudioCorrect.play()
		_question_info()		
		
	else:
		button.modulate = color_red
		$AudioIncorrect.play()
		await get_tree().create_timer(1.5).timeout
		_next_question()
		#$Control/ButtonGoQuestion.show()

func _next_question() -> void:
	for bt in buttons:
		bt.pressed.disconnect(_buttons_answer)
		
	
	
	for bt in buttons:
		bt.modulate = Color.WHITE
		
	question_audio.stop()
	question_video.stop()
	question_audio.stream = null
	question_video.stream = null
		
	$Control/ButtonGoQuestion.hide()
	index += 1
	load_quiz()
