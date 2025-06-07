class_name RewindableCharacter

extends CharacterBody2D

var can_move: bool = true

var snapshot_ability: SnapshotAbility = SnapshotAbility.new(self)

func begin_snapshot() -> void:
	pass

func pre_rewind() -> void:
	pass

func end_rewind() -> void:
	pass
