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
		
	
	if player.freeze_duration_timer.time_left>0:
		hourglass.rotation+= deg_to_rad(180-float(player.sprite.sprite_frames.get_frame_count(player.sprite.animation)) /
		player.sprite.sprite_frames.get_animation_speed(player.sprite.animation)+0.176) * delta

func _ready() -> void:
	process_mode=Node.PROCESS_MODE_ALWAYS
	hourglass.pivot_offset = hourglass.size / 2
