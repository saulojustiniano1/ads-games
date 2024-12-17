extends CharacterBody2D

signal dano

const SPEED = 180
const JUMP_VELOCITY = -450
const GRAVITY = 1800

@onready var life_label = $"../HUB/LifeLabel"
@onready var score_label = $"../HUB/ScoreLabel"

@onready var animated = $Animated
@onready var audio_pular = $"../AudioPular"
@onready var audio_pegar_moeda = $"../AudioPegarMoeda"

func _ready():
	GameManager.player = self
	GameManager.player_start_position = position


func _process(delta):
	update_animation()
	
func _physics_process(delta):
	if life_label.dano > 0:
		# Gravidade do jogo
		if is_on_floor() == false:
			velocity.y += GRAVITY * delta
		
		# Pulo do player
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y += JUMP_VELOCITY 
			audio_pular.play()
		
		# Mova player horizontalmente
		var direction = Input.get_axis("left", "right")
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = 0
		
		move_and_slide()

func update_animation():
	if velocity.x != 0:
		animated.flip_h = velocity.x < 0
	
	if is_on_floor():
		if abs(velocity.x) > 0:
			animated.play("run")
		else:
			animated.play("idle")
	else:
		animated.play("jump")


func _on_enemy_worm_body_entered(body):
	position = GameManager.player_start_position
	emit_signal("dano")

func _on_enemy_ghost_body_entered(body):
	position = GameManager.player_start_position
	emit_signal("dano")

func _on_enemy_phantom_body_entered(body):
	position = GameManager.player_start_position
	emit_signal("dano")
