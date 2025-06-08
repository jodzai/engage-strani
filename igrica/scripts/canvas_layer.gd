extends CanvasLayer
@onready var player: Player = $"../player"
@onready var slash: TextureRect = $slash
@onready var hourglass: TextureRect = $hourglass
@onready var portal: TextureRect = $portal

func _process(delta: float) -> void:
	if player.stamina<50:
		slash.self_modulate="ffffff31"
	if player.stamina<30:
		portal.self_modulate="ffffff31"
	
	if player.stamina>=50:
		slash.self_modulate="ffffffff"
	if player.stamina>=30:
		portal.self_modulate="ffffffff"
	if player.freeze_cooldown.time_left>0:
		hourglass.self_modulate="ffffff31"
	else:
		hourglass.self_modulate="ffffffff"
