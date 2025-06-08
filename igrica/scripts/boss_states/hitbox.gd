class_name Hitbox

extends Area2D

func _process(_delta):
	var targets = get_overlapping_bodies()
	for target in targets:
		if target.has_method("take_damage"):
			target.take_damage()
