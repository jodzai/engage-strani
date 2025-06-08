extends State

@onready var animated_sprite = $"../../AnimatedSprite2D"

@export var follow_state: State

var parent: Boss
var player: CharacterBody2D

var wake_up_anim_ended = false

const BOSS_WAKING = preload("res://assets/Music/Boss Waking.wav")
@onready var audio_stream_player_6: AudioStreamPlayer = $"../../AudioStreamPlayer6"

const BOSS_FIRST_FAZE = preload("res://assets/Music/Boss First Faze.wav")
@onready var audio_stream_player_2: AudioStreamPlayer = $"../../AudioStreamPlayer2"

func _ready() -> void:
	audio_stream_player_6.stream = BOSS_WAKING
	audio_stream_player_2.stream = BOSS_FIRST_FAZE
	audio_stream_player_2.process_mode = Node.PROCESS_MODE_ALWAYS
	

func enter() -> void:
	$"../../Label".text = "Waking_up"
	animated_sprite.play("wake_up")
	wake_up_anim_ended = false

func process_frame(_delta: float) -> State:
	if wake_up_anim_ended:
		audio_stream_player_2.play()
		return follow_state
	return null


func _on_animated_sprite_2d_animation_finished():
	wake_up_anim_ended = true
