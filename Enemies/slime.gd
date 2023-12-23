extends CharacterBody2D
class_name Slime

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if not $RayCast2D.is_colliding() or not $RayCast2D2.is_colliding():
		$"State Machine/Idle".flip_direction()
	
	if abs(velocity.x) > 50:
		$AnimationPlayer.play("run")
	elif abs(velocity.x) > 0:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
		
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	
	if not $Direction/FloorCheck.is_colliding():
		$"State Machine/Idle".Flip_Direction()
		$Direction.scale.x = -$Direction.scale.x
		
	move_and_slide()

