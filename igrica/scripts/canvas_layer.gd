extends CanvasLayer
@onready var player: Player = $"../player"
@onready var portal: TextureRect = $Panel/portal
@onready var slash: TextureRect = $Panel/slash
@onready var hourglass: TextureRect = $Panel/hourglass

var blink_time := 0.0

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
		
	
	if player.freeze_duration_timer.time_left > 0:
		blink_time += delta
		var alpha := 0.5 + 0.5 * sin(blink_time * 10)  # osciluje između 0 i 1
		hourglass.modulate.a = alpha
	else:
		hourglass.modulate.a = 1.0
		blink_time = 0.0

func _ready() -> void:
	process_mode=Node.PROCESS_MODE_ALWAYS
	hourglass.pivot_offset = hourglass.size / 2
