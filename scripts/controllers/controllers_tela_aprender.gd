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
