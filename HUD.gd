extends CanvasLayer

signal start_game

func _ready():
	$message_timer.connect("timeout", self, "_on_message_timer_timeout")
	$start_button.connect("pressed", self, "_on_start_button_pressed")
	$start_button.hide()
	$credits.hide()
	
func show_message(text):
	$message.text = text
	$message.show()
	$message_timer.start()
	
func show_game_over():
	show_message("Game Over")

	yield($message_timer, "timeout")

	#$message.text = "music by themistoklik \n avatars by D_mitri"
	#$message.show()
	$credits.show()
	
	$start_button.show()
	
func update_score(score):
	$score_label.text = str(score)
	
func _on_message_timer_timeout():
	$message.hide()
			
func _on_start_button_pressed():
	$start_button.hide()
	$credits.hide()
	emit_signal("start_game")
