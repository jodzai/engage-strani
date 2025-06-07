class_name Player 
extends RewindableCharacter

const SPEED = 200
const JUMP_VELOCITY = -400.0

@onready var sprite: AnimatedSprite2D = $sprite
@onready var stamina_bar: ProgressBar = $"../CanvasLayer/stamina_bar"
@onready var time_manager: Node = $"../TimeManager"
@onready var freeze_timer: Timer = $freeze_timer
@onready var freeze_cd_label: Label = $"../CanvasLayer/freeze_cd_label"

var input_enabled := true
var vulnerable=true
var is_dashing=false
var dash_time = 0.5
var dash_speed = 300
var stamina_refresh=0.5
@onready var sekundara: Timer = $sekundara
@onready var dash_timer: Timer = $dash_timer
var animation_lock : bool = false
var stamina : int = 100
@onready var freeze_duration_timer: Timer = $freeze_duration_timer
@onready var freeze_cooldown: Timer = $freeze_cooldown
var freeze_ready=true

@onready var game: GameMain = $".."

@onready var aura: Area2D = $aura
@onready var collision: CollisionShape2D = $collision

func _physics_process(delta: float) -> void:
	
	var bodies: Array[Node2D] = aura.get_overlapping_bodies()
	if !bodies.is_empty(): hit(bodies)
	
	if not input_enabled:
		return
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta
	
	if is_dashing:
		if not sprite.flip_h:
			velocity.x=dash_speed
		elif sprite.flip_h:
			velocity.x=-dash_speed
	freeze_cd_label.text = "%.1f" % freeze_cooldown.time_left
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_dashing:
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("dash"):
		dash()
		
	if Input.is_action_just_pressed("test"):
		game.snapshot.begin_snapshot()
	if Input.is_action_just_pressed("test 2"):
		game.snapshot.pre_rewind()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
		
	if direction and not is_dashing:
		sprite.play('run')
		velocity.x = direction * SPEED
	elif not animation_lock:
		sprite.play('idle')
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
		
	if Input.is_action_just_pressed("freeze") and not is_dashing:
		start_freeze_sequence()
	
	move_and_slide()

func disable_input() -> void:
	input_enabled = false

func enable_input() -> void:
	input_enabled = true

func disable_vulnerability() -> void:
	vulnerable = false

func enable_vulnerability() -> void:
	vulnerable = true

func dash():
	if not is_dashing and stamina>=30:
		animation_lock = true
		sprite.play("dash")
		sekundara.stop()
		stamina-=30
		if stamina<0:
			stamina=0
		velocity.y=0
		vulnerable=false
		is_dashing=true
		dash_timer.start(dash_time)

func start_freeze_sequence():
	if freeze_ready:
		freeze_ready=false
		freeze_cooldown.start(12)
		freeze_cd_label.visible=true
		freeze_cd_label.text="12"
		input_enabled = false
		animation_lock = true
		sprite.play("freeze_anim")
		freeze_timer.start(float(sprite.sprite_frames.get_frame_count(sprite.animation)) /
		sprite.sprite_frames.get_animation_speed(sprite.animation))

		
func _on_dash_timer_timeout() -> void:
	vulnerable=true
	is_dashing = false
	animation_lock = false
	sekundara.start(stamina_refresh)

func _process(delta: float) -> void:
	stamina_bar.value=stamina
	

func _ready() -> void:
	sekundara.start(stamina_refresh)
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _on_sekundara_timeout() -> void:
	if(stamina<100):
		stamina+=5 

func _on_freeze_timer_timeout() -> void:
	input_enabled = true
	get_tree().paused = true  
	freeze_duration_timer.start(2)
	animation_lock = false

func _on_freeze_duration_timer_timeout() -> void:
	get_tree().paused=false

func _on_freeze_cooldown_timeout() -> void:
	freeze_ready=true
	freeze_cd_label.visible=false

func pre_rewind() -> void:
	collision.disabled = true

func end_rewind() -> void:
	collision.disabled = false 

func hit(nodes: Array[Node2D]) -> void:
	for node in nodes:
		print("hit " + node.name)
