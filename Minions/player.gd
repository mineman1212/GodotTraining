extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal shootLaser(pos, direction)
signal shootGrenade(pos, direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()
	
	#rotate player
	look_at(get_global_mouse_position())
	
	#laser shooting input
	if Input.is_action_pressed("primary fire") and can_laser:
		#randomly select marker2d for laser start position
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		var Playerdirection = (get_global_mouse_position() - position).normalized()
		can_laser = false
		$laserTimer.start()
		#emit position that was selected
		shootLaser.emit(selected_laser.global_position, Playerdirection)
		$GPUParticles2D.emitting = true
		
	
	if Input.is_action_pressed("secondary action") and can_grenade:
		var pos = $LaserStartPositions.get_children()[0].global_position
		can_grenade = false
		$grenadeTimer.start()
		var Playerdirection = (get_global_mouse_position() - position).normalized()
		shootGrenade.emit(pos, Playerdirection)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
