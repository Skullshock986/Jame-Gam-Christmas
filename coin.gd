extends Area2D

signal coin_collected

var collect_time : float = 0.3
var collected : bool = false

func _ready():
	$AnimationPlayer.play("idle")

func _process(delta):
	if collected:
		if collect_time > 0:
			collect_time -= delta
		else:
			queue_free()

func _on_body_entered(body):
	if body is player:
		emit_signal("coin_collected")
		$AnimationPlayer.play("collected")
		collected = true
