extends Node2D

#preload scenes
var laser_scene: PackedScene = preload("res://Objects/laser.tscn")
var grenade_scene: PackedScene = preload("res://Objects/grenade.tscn")


func _on_gate_player_entered_gate(body):
	print('Player has entered gate')
	print(body)


func _on_player_shoot_laser(pos):
	var laser = laser_scene.instantiate()
	#update laser position
	laser.position = pos
	#add laser instance to a Node2D
	$Projectiles.add_child(laser)

func _on_player_shoot_grenade(pos):
	var grenade = grenade_scene.instantiate()
	grenade.position = pos
	$Projectiles.add_child(grenade)
