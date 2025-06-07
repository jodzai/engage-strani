extends Node

@onready var enemy: CharacterBody2D = $enemy

var is_time_frozen = false  # Da li je vreme zamrznuto
var freeze_duration = 3.0  # Trajanje efekta zamrzavanja
var freeze_timer = 0.0  # Timer za trajanje efekta

func _process(delta: float) -> void:
	if is_time_frozen:
		freeze_timer += delta
		if freeze_timer >= freeze_duration:
			unfreeze_time()
			
			
			
func freeze_time():
	is_time_frozen=true
	enemy.set_physics_process(false)
	print("Time Frozen!")

# Funkcija koja ukida time freeze efekat
func unfreeze_time():
	is_time_frozen = false

	print("Time Unfrozen!")
