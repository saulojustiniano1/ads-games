extends RigidBody2D

@export var speed = 0.0


func _ready():
	var mob_types = $Animated.sprite_frames.get_animation_names()
	var random_animation_index = randi() % mob_types.size()
	var random_animation =  mob_types[random_animation_index]
	
	if random_animation == "fly":
		speed = 180.0
	elif random_animation == "swin":
		speed = 120.0
	elif random_animation == "walk":
		speed = 60.0

	$Animated.play(random_animation)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
