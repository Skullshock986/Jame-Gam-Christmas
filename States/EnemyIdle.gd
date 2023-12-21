extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var move_speed := 20
var player : CharacterBody2D

var move_direction : float
var wander_time : float
var idle_time : float

func randomise_wander():
	move_direction = (randi() % 2) * 2 - 1
	wander_time = randf_range(1, 3)
	idle_time = randf_range(3, 5)
	
func Enter():
	player = get_tree().get_first_node_in_group("Player")
	randomise_wander()

func Update(delta : float):
	if wander_time > 0:
		wander_time -= delta
	else:
		if idle_time > 0:
			idle_time -= delta
		else:
			randomise_wander()
			

func Physics_Update(delta : float):
	if enemy and wander_time > 0:
		enemy.velocity.x = move_direction * move_speed
		
	var distance = player.global_position.x - enemy.global_position.x
	
	if abs(distance) < 70:
		Transitioned.emit(self, "follow")
