extends CanvasLayer

var coins_collected : int = 0

func update_coin_counter():
	coins_collected += 1
	$Label.text = ":" + str(coins_collected)

