class_name Boss
extends RewindableCharacter

@onready var state_machine = $State_machine
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var player: CharacterBody2D
@export var speed = 2
@export var attack_change_len = 80
@export var health: int = 3

var old_state: State = null
var old_animation = null
var old_frame = null

var attack_timer_min: float = 2.0
var attack_timer_max: float = 4.0

var second_faze: bool = false
var big_attack_able: bool = false

const BOSS_DYING = preload("res://assets/Music/Boss Dying.wav")
const BOSS_FIRST_FAZE = preload("res://assets/Music/Boss First Faze.wav")
const BOSS_HIT_SFX = preload("res://assets/Music/Boss Hit SFX.wav")
const BOSS_SECOND_FAZE_SFX = preload("res://assets/Music/Boss Second Faze SFX.wav")
const BOSS_SECOND_FAZE = preload("res://assets/Music/Boss Second Faze.wav")
const BOSS_WAKING = preload("res://assets/Music/Boss Waking.wav")
const LASER_BIG_SFX = preload("res://assets/Music/Laser Big SFX.wav")
const LASER_SMALL_SFX = preload("res://assets/Music/Laser Small SFX.wav")
const VERTICAL_LASER_SFX = preload("res://assets/Music/Vertical Laser SFX.wav")

@onready var dying_sfx: AudioStreamPlayer = $AudioStreamPlayer
@onready var first_faze_sfx: AudioStreamPlayer = $AudioStreamPlayer2
@onready var hit_sfx: AudioStreamPlayer = $AudioStreamPlayer3
@onready var second_faze_sfx: AudioStreamPlayer = $AudioStreamPlayer4
@onready var second_faze_sfx_sfx: AudioStreamPlayer = $AudioStreamPlayer5
@onready var waking_sfx: AudioStreamPlayer = $AudioStreamPlayer6
@onready var laser_big_sfx: AudioStreamPlayer = $AudioStreamPlayer7
@onready var laser_small_sfx: AudioStreamPlayer = $AudioStreamPlayer8
@onready var vertical_laser_sfx: AudioStreamPlayer = $AudioStreamPlayer9


func _ready():
	state_machine.init(self, player)
	dying_sfx.stream = BOSS_DYING
	first_faze_sfx.stream = BOSS_FIRST_FAZE
	hit_sfx.stream = BOSS_HIT_SFX
	second_faze_sfx.stream = BOSS_SECOND_FAZE
	second_faze_sfx_sfx.stream = BOSS_SECOND_FAZE_SFX
	waking_sfx.stream = BOSS_WAKING
	laser_big_sfx.stream = LASER_BIG_SFX
	laser_small_sfx.stream = LASER_SMALL_SFX
	vertical_laser_sfx.stream = VERTICAL_LASER_SFX

func _process(delta):
	if Input.is_action_just_pressed("hurt_boss"):
		health -= 1
		print(health)
	if health == 0:
		first_faze_sfx.stop()
		second_faze = true
		second_faze_sfx.play()
		health = 3
	if $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.position.x = 346
	else:
		$AnimatedSprite2D.position.x = 0
	state_machine.process_frame(delta)

func _physics_process(delta):
	state_machine.process_physics(delta)
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func power_up():
	big_attack_able = true
	speed = speed*2
	%idle_state.idle_time = %idle_state.idle_time / 2
	attack_timer_min = attack_timer_min / 2
	attack_timer_max = attack_timer_max / 2

func begin_snapshot():
	old_state = state_machine.current_state
	old_frame = animated_sprite_2d.frame
	pass

func pre_rewind():
	animated_sprite_2d.pause()
	pass

func end_rewind():
	state_machine.change_state(old_state)
	animated_sprite_2d.frame = old_frame
	animated_sprite_2d.play()
	pass
