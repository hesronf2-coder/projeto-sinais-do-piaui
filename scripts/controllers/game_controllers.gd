extends CanvasLayer
#declarando variáveis

@export var quiz: QuizTheme
@export var color_green: Color
@export var color_red: Color

var buttons: Array[Button]
var index: int
var correct: int

var current_quiz: QuizQuestion:
	get: return quiz.theme[index]

#conectando nós ao código
@onready var question_image: TextureRect = $Control/ImageHolder/QuestionImage
@onready var question_video: VideoStreamPlayer = $Control/ImageHolder/QuestionVideo
@onready var question_audio: AudioStreamPlayer2D = $Control/ImageHolder/QuestionAudio
@onready var info_text: Label = $Control/QuestionInfo/InfoText



func _ready() -> void:
#iniciando variavel correct com zero
	correct = 0

#fazendo uma lista com os nós dos botões
	for button in $Control/QuestionOpitions.get_children():
		buttons.append(button)
		
	load_quiz()

#função carregar o jogo
func load_quiz() -> void:
#o texto da variável recebe o text das questoes.
	info_text.text = current_quiz.question_info  

#quando o index alcançar tamanho da lista de perguntas vai para tela de progresso
	if index >= quiz.theme.size() - 1:
		_game_progress()
		return
#carregando lista de botões com opçoes do banco de dados	
	var options = current_quiz.options
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))

#tipos das questõe, no MVP, só é usado otipo imagens, sem vídeo por enquanto
		match current_quiz.type:
		
			Enum.QuestionType.IMAGE:
				$Control/ImageHolder.show()
				question_image.texture = current_quiz.question_image
			
			Enum.QuestionType.VIDEO:
				$Control/Fundoimagem.show()
				question_video.stream = current_quiz.question_video
				question_video.play()

#botões da interface onde o jogador clica para responder a uma pergunta
func _buttons_answer(button) -> void:
#modulando a cor de certo ou errado		
	if current_quiz.correct == button.text:
		button.modulate = color_green
		
		correct += 1
		$AudioCorrect.play()
		_question_info()		
		
	else:
		button.modulate = color_red
		$AudioIncorrect.play()
		await get_tree().create_timer(1.5).timeout #tempo para seguir em caso de erro
		_next_question()
		#$Control/ButtonGoQuestion.show()

#função para avançar questão
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

#função para mostrar a tela de progresso/acerto
func _game_progress() -> void:
	$Control/GameProgress.show()
	$Control/GameProgress/ScoreText.text = str(correct, " de ", quiz.theme.size() - 1)
		
#função da tela de informação quando há acerto
func _question_info() -> void:
	$Control/QuestionInfo.show()
	$Control/QuestionOpitions.hide()
	$Control/ButtonHome.hide()

#funçoes do botão continuar quando há acerto
func _on_button_continue_pressed() -> void:
	$AudioGoQuestion.play()
	$Control/QuestionInfo.hide()
	$Control/QuestionOpitions.show()	
	$Control/ButtonHome.show()

#quando o index alcançar tamanho da lista de perguntas vai para tela de progresso
	if index >= quiz.theme.size() -1:
		_game_progress()
	else:
		_next_question()
	
#conexão e funções de botões
func _on_button_go_question_pressed() -> void:
	$AudioGoQuestion.play()
	_next_question()


func _on_button_exit_pressed() -> void:
	$AudioGoQuestion.play()
	get_tree().change_scene_to_file("res://scenes/tela_home.tscn")


func _on_button_home_pressed() -> void:
	$AudioGoQuestion.play()
	get_tree().change_scene_to_file("res://scenes/tela_home.tscn")
