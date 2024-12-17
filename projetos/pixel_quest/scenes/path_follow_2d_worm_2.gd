extends PathFollow2D

@export var SPEED: float = 50

func _ready():
	$EnemyWorm2/Animated.flip_h = false
	$EnemyWorm2/Animated.play("default")

func _process(delta):
	progress += SPEED * delta
	
	if progress_ratio >= 1.0 or progress_ratio <= 0.0:
		SPEED *= -1
		if progress_ratio >= 1.0:
			$EnemyWorm2/Animated.flip_h = true
		else:
			$EnemyWorm2/Animated.flip_h = false
