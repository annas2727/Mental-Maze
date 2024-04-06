extends Node


var score = 0
var level = 1
var lives = 3
var lost_lvl = false


var randex = randi_range(0, 6)
var array = [randex]


signal show_screen


func clear_screen():
	get_tree().call_group("mobs", "queue_free")
	$Player.hide()


func start_game():
	score = 0
	level = 1
	lives = 3
	lost_lvl = false
	$HUD.show_game_begin()


func new_game():
	score = 0
	level = 1
	lives = 3
	lost_lvl = false
	$HUD.update_score(score)
	next_level()


func next_level():
	$popups.hide_popup()
	lost_lvl = false
	$HUD.update_score(score)
	show_screen.emit()
	$Player._start($StartPosition.position)
	$ScoreTimer.start()
	
	await get_tree().create_timer(3.0).timeout
	exit_found()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func exit_found():
	$ScoreTimer.stop()
	clear_screen()
	level += 1
	$popups.show_popup(randex)
	while (array.find(randex) != -1):
		randex = randi_range(0, 6)
	array.push_back(randex)


func lose_life():
	$ScoreTimer.stop()
	clear_screen()
	lives -= 1
	lost_lvl = true



func check_levels():
	
	$popups.hide_popup()
	
	if lives == 0:
		$HUD.show_game_over()
		clear_screen()
	
	elif lost_lvl == true:
		$HUD.show_level_over(lives, level)
		clear_screen()
	
	elif level == 4:
		$HUD.show_game_won()
		clear_screen()
	
	else:
		$HUD.show_level_won(level)
		clear_screen()


func check_start():
	if lives == 0 or level == 4:
		new_game()
	else:
		next_level()


