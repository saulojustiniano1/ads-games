extends PathFollow2D

@export var SPEED: float = 50

func _ready():
	$EnemyPhantom/Animated.flip_h = false
	$EnemyPhantom/Animated.play("default")

func _process(delta):
	progress += SPEED * delta
	
	if progress_ratio >= 1.0 or progress_ratio <= 0.0:
		SPEED *= -1
		if progress_ratio >= 1.0:
			$EnemyPhantom/Animated.flip_h = true
		else:
			$EnemyPhantom/Animated.flip_h = false

