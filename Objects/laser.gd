extends Area2D

@export var speed: int = 1200
var direction: Vector2 = Vector2.UP


func _ready():
	$laserLife.start()

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()



func _on_laser_life_timeout():
	queue_free()
