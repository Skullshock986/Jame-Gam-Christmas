extends CharacterBody2D
class_name Slime

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	take_damage()
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
	
	#if not $Direction/FloorCheck.is_colliding():
	#	$"State Machine/Idle".Flip_Direction()
	#	$Direction.scale.x = -$Direction.scale.x      #this breaks game please fix
	
		
	move_and_slide()
	
	
	#combat stuff
var health = 100
var in_attack_zone
var can_take_damage = true



func 	 enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		in_attack_zone = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		in_attack_zone = false
		
func take_damage():
	if in_attack_zone and global.player_attacking and can_take_damage:
		health -= global.player_damage
		$take_damage_cooldown.start()
		print("slime: ",health)
		can_take_damage = false
		if health <= 0:
			self.queue_free()

func _on_take_damage_cooldown_timeout():
	$take_damage_cooldown.stop()
	can_take_damage = true



