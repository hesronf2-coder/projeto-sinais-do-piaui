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
