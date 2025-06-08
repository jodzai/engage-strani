class_name SnapshotAbility

var entity: RewindableCharacter

var start_state: RewindState
var end_state: RewindState

func _init(entity: CharacterBody2D):
	self.entity = entity
	start_state = null
	end_state = null

func begin_snapshot() -> void:
	start_state = RewindState.new(entity)
	entity.begin_snapshot()

func pre_rewind() -> void:
	entity.pre_rewind()
	end_state = RewindState.new(entity)
	entity.can_move = false
	entity.velocity.x = 0
	entity.velocity.y = 0

func is_done() -> bool:
	return start_state.position.is_at(entity)

func rewind(rewind_duration: float) -> void:
	var distance = Distance.new(start_state.position, end_state.position)
	
	entity.global_position.x = move_toward(
		entity.global_position.x,
		start_state.position.x,
		distance.delta_x / rewind_duration
	)
	
	entity.global_position.y = move_toward(
		entity.global_position.y,
		start_state.position.y,
		distance.delta_y / rewind_duration
	)

func end() -> void:
	entity.can_move = true
	entity.velocity.x = start_state.velocity_x
	entity.velocity.y = start_state.velocity_y
	entity.end_rewind()
	start_state = null
	end_state = null


class RewindState:
	var position: Position
	var velocity_x: int
	var velocity_y: int
	
	func _init(entity: CharacterBody2D):
		self.position = Position.new(
			entity.global_position.x,
			entity.global_position.y,
		)
		velocity_x = entity.velocity.x
		velocity_y = entity.velocity.y

class Distance:
	var delta_x: int
	var delta_y: int
	
	func _init(p1: Position, p2: Position):
		delta_x = abs(p2.x - p1.x)
		delta_y = abs(p2.y - p1.y)

class Position:
	var x: int
	var y: int
	
	func _init(x, y):
		self.x = x
		self.y = y
