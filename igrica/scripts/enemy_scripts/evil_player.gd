extends CharacterBody2D


@onready var hitbox: CollisionShape2D = $hitbox_container/hitbox
@onready var hitbox_container: Area2D = $hitbox_container


func _ready()->void:
	hitbox_container.collision_layer=3
	hitbox_container.collision_mask=4
	pass
