class_name Hurtbox

extends Area2D

@export var health: int

func take_damage():
	health -= 1
