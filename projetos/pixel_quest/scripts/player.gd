extends CharacterBody2D

const SPEED = 180
const JUMP_VELOCITY = -450
const GRAVITY = 1800

@onready var animated = $Animated

func _ready():
	GameManager.player = self
	GameManager.player_start_position = position

func _process(delta):
	update_animation()
	
func _physics_process(delta):
	# Gravidade do jogo
	if is_on_floor() == false:
		velocity.y += GRAVITY * delta
	
	# Pulo do player
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY 
	
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
	
