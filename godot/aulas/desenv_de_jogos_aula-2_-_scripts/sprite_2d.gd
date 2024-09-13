extends Sprite2D

var speed = 400
var angular_rotation = PI

var is_button_left_pressed = false
var is_button_right_pressed = false
var is_button_up_pressed = false
var is_button_down_pressed = false

func _init():
	print("Começando o Jogo")
	
func move_by_input(delta):
	var direction = 0
	
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	
	rotation += angular_rotation * direction * delta
	
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2.DOWN.rotated(rotation) * speed
		
	position += velocity * delta

func move_basic(delta):
	rotation += angular_rotation * delta
	position += Vector2.UP.rotated(rotation) * speed * delta

func move_by_buttons(delta):
	if is_button_left_pressed:
		position += Vector2.LEFT * speed * delta
	
	if is_button_right_pressed:
		position += Vector2.RIGHT * speed * delta
	
	if is_button_up_pressed:
		position += Vector2.UP * speed * delta
	
	if is_button_down_pressed:
		position += Vector2.DOWN * speed * delta

func _process(delta):
	move_by_buttons(delta)

func _on_button_pressed():
	set_process(not is_processing())
	
func _on_button_left_button_down():
	is_button_left_pressed = true

func _on_button_left_button_up():
	is_button_left_pressed = false


func _on_button_right_button_down():
	is_button_right_pressed = true

func _on_button_right_button_up():
	is_button_right_pressed = false


func _on_button_up_button_down():
	is_button_up_pressed = true

func _on_button_up_button_up():
	is_button_up_pressed = false


func _on_button_down_button_down():
	is_button_down_pressed = true

func _on_button_down_button_up():
	is_button_down_pressed = false
