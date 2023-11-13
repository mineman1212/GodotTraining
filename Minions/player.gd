extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal shootLaser(pos)
signal shootGrenade(pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()
	
	#laser shooting input
	if Input.is_action_pressed("primary fire") and can_laser:
		#randomly select marker2d for laser start position
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$laserTimer.start()
		#emit position that was selected
		shootLaser.emit(selected_laser.global_position)
	
	if Input.is_action_pressed("secondary action") and can_grenade:
		var pos = $LaserStartPositions.get_children()[0].global_position
		can_grenade = false
		$grenadeTimer.start()
		shootGrenade.emit(pos)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
