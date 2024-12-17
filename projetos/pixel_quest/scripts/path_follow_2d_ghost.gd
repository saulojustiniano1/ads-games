extends PathFollow2D

@export var SPEED: float = 50

func _ready():
	$EnemyGhost/Animated.flip_h = false
	$EnemyGhost/Animated.play("default")

func _process(delta):
	progress += SPEED * delta
	
	if progress_ratio >= 1.0 or progress_ratio <= 0.0:
		SPEED *= -1
		if progress_ratio >= 1.0:
			$EnemyGhost/Animated.flip_h = true
		else:
			$EnemyGhost/Animated.flip_h = false
		 


