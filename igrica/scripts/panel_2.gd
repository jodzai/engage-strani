extends Panel
@onready var player: Player = $"../../player"
@onready var texture_rect: TextureRect = $TextureRect
@onready var texture_rect_2: TextureRect = $TextureRect2
@onready var texture_rect_3: TextureRect = $TextureRect3
@onready var texture_rect_4: TextureRect = $TextureRect4
@onready var texture_rect_5: TextureRect = $TextureRect5

func _process(delta: float) -> void:
	if player.health == 4:
		texture_rect_5.visible=false
	if player.health == 3:
		texture_rect_4.visible=false
	if player.health == 2:
		texture_rect_3.visible=false
	if player.health == 1:
		texture_rect_2.visible=false
	if player.health == 0:
		texture_rect.visible=false
	
		
