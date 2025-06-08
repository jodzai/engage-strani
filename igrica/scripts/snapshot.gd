class_name Snapshot 

extends Node

@onready var player: Player = $"../player"
@onready var boss: Boss = $"../Boss"

@onready var rewind_time: Timer = $rewind_time

var rewind_duration: float = 25

const TIME_REVERSE_SFX = preload("res://assets/Music/Time Reverse SFX.wav")
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# flags
var is_rewinding: bool = false


func _ready() -> void:
	audio_stream_player.stream = TIME_REVERSE_SFX

func _process(delta: float) -> void:
	if !is_rewinding:
		return
	
	player.snapshot_ability.rewind(rewind_duration)
	boss.snapshot_ability.rewind(rewind_duration)
	
	if rewind_time.is_stopped():
		end()

func begin_snapshot() -> void:
	player.snapshot_ability.begin_snapshot()
	boss.snapshot_ability.begin_snapshot()

func pre_rewind() -> void:
	is_rewinding = true
	
	player.disable_vulnerability()
	player.disable_input()
	
	player.snapshot_ability.pre_rewind()
	boss.snapshot_ability.pre_rewind()
	
	audio_stream_player.play()
	
	rewind_time.start()

func cancel() -> void:
	end()

func end() -> void:
	player.snapshot_ability.end()
	boss.snapshot_ability.end()
	
	is_rewinding = false
	
	player.enable_vulnerability()
	player.enable_input()
