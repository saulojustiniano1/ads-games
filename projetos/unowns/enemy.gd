extends RigidBody2D

func _ready():
	var mob_types = $Animated.sprite_frames.get_animation_names()
	var random_animation_index = randi() % mob_types.size()
	var random_animation =  mob_types[random_animation_index]
	$Animated.play(random_animation)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
