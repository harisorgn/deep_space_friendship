extends Node

export (PackedScene) var mob
var score

func _ready():
	$mob_timer.connect("timeout", self, "_on_mob_timer_timeout")
	$start_timer.connect("timeout", self, "_on_start_timer_timeout")
	$score_timer.connect("timeout", self, "_on_score_timer_timeout")
	$player.connect("hit", self, "game_over")
	$HUD.connect("start_game", self, "new_game")
	
	randomize()
	new_game()

func game_over():
	$score_timer.stop()
	$mob_timer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	$music.stop()
	$death_sound.play()
	
func new_game():
	score = 0
	
	$death_sound.stop()
	$player.start($start_position.position)
	$start_timer.start()
	$HUD.update_score(score)
	$HUD.show_message("Dodge your friends!")
	$music.play()
	
func _on_start_timer_timeout():
	$mob_timer.start()
	$score_timer.start()
	
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout():
	$mob_path/mob_spawn_location.offset = randi()
	
	var mob_instance = mob.instance()
	
	var init_position = $mob_path/mob_spawn_location.position
	
	var init_direction = $mob_path/mob_spawn_location.rotation + PI/2
	init_direction += rand_range(-PI/5, PI/5)
	
	mob_instance.init(init_position, init_direction)
	
	add_child(mob_instance)
