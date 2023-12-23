extends Node2D

@onready var player : CharacterBody2D = $Player

func _process(delta):
	if player.near_door:
		$Label.visible_characters = -1
	else:
		$Label.visible_characters = 0
