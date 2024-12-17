extends PathFollow2D

@export var SPEED: float = 50

func _ready():
	$EnemyGhost2/Animated.flip_h = false
	$EnemyGhost2/Animated.play("default")

func _process(delta):
	progress += SPEED * delta
	
	if progress_ratio >= 1.0 or progress_ratio <= 0.0:
		SPEED *= -1
		if progress_ratio >= 1.0:
			$EnemyGhost2/Animated.flip_h = true
		else:
			$EnemyGhost2/Animated.flip_h = false
		 



