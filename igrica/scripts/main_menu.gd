extends Control

@onready var start_button: Button = $Panel/VBoxContainer/start_button
@onready var exit_button: Button = $Panel/VBoxContainer/exit_button
@onready var help_button: Button = $Panel/VBoxContainer/help_button
@onready var help_panel: Panel = $help_panel
@onready var help_exit: Button = $help_panel/help_exit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_help_button_pressed() -> void:
	help_panel.show()


func _on_help_exit_pressed() -> void:
	help_panel.hide()
