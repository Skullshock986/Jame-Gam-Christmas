extends Node2D

@onready var player : CharacterBody2D = $Player

func _process(delta):
	if player.near_return:
		$ReturnHome.visible_characters = -1
		$ReturnHome2.visible_characters = -1
	else:
		$ReturnHome.visible_characters = 0
		$ReturnHome2.visible_characters = 0
		
	if player.near_next:
		$NextLevel.visible_characters = -1
	else:
		$NextLevel.visible_characters = 0

