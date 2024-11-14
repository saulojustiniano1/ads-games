extends Area2D

@export var speed = 400
var screen_size

signal hit


func _ready():
	screen_size = get_viewport_rect().size
	hide()


func start(pos):
	position = pos
	show()
	$Collision.disabled = false


func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	position += velocity * speed * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	var flipHorizontal = velocity.x < 0
	var flipVertical = velocity.y > 0
	
	if velocity.x != 0:
		$Animated.animation = "walk"
		$Animated.flip_v = false
		$Animated.flip_h = flipHorizontal
	else:
		$Animated.animation = "up"
		$Animated.flip_v = flipVertical
	
	if velocity.length() != 0:
		$Animated.play()
	else:
		$Animated.stop()

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		hide()
		$Collision.set_deferred("disabled", true)
		hit.emit()
	elif body.is_in_group("bomb"):
		body.queue_free()
		get_tree().call_group('enemy', 'queue_free')
		$BombAudio.play()
	
