extends CharacterBody2D


const SPEED = 200
const JUMP_VELOCITY = -300.0
@onready var sprite: AnimatedSprite2D = $sprite
@onready var stamina_bar: ProgressBar = $"../CanvasLayer/stamina_bar"
@onready var time_manager: Node = $"../TimeManager"


var vulnerable=true
var is_dashing=false
var dash_time = 0.5
var dash_speed = 300
var stamina_refresh=0.5
@onready var sekundara: Timer = $sekundara
@onready var dash_timer: Timer = $dash_timer
var animation_lock : bool = false
var stamina : int = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta
	
	if is_dashing:
		if not sprite.flip_h:
			velocity.x=dash_speed
		elif sprite.flip_h:
			velocity.x=-dash_speed
	
			
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_dashing:
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("dash"):
		dash()
	
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
		
	if Input.is_action_just_pressed("freeze"):
		get_tree().paused=!get_tree().paused
		
	
	move_and_slide()
	
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
