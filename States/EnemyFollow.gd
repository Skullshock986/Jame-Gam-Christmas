extends State
class_name EnemyFollow

@export var enemy : CharacterBody2D
@export var move_speed := 90
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta : float):
	var distance = player.global_position.x - enemy.global_position.x
	
	if abs(distance) > 10:
		var direction = -1 if distance < 0 else 1
		enemy.velocity.x = direction * move_speed
	else:
		enemy.velocity.x = 0
	
	if abs(distance) > 120:
		Transitioned.emit(self, "idle")

