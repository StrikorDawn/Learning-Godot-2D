extends CanvasLayer

func _process(delta):
	$Coins.text = "Collectables: " + str(Global.total_collected)
	$Lives.text = "Lives: " + str(Global.lives)
	
