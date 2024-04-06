extends Node


var _score = 0
var _level = 1
var _lives = 3
var _lost_lvl = false


signal show_screen


func _clear_screen():
	get_tree().call_group("mobs", "queue_free")
	$Player.hide()


func _start_game():
	$popups.hide_popup()
	_score = 0
	_level = 1
	_lives = 3
	_lost_lvl = false
	$HUD.show_game_begin()


func _new_game():
	$popups.hide_popup()
	_score = 0
	_level = 1
	_lives = 3
	_lost_lvl = false
	$HUD.update_score(_score)
	_next_level()


func _next_level():
	$popups.hide_popup()
	_lost_lvl = false
	$HUD.update_score(_score)
	show_screen.emit()
	$Player._start($StartPosition.position)
	$ScoreTimer.start()
	
	await get_tree().create_timer(3.0).timeout
	_exit_found()


func _on_score_timer_timeout():
	_score += 1
	$HUD.update_score(_score)


func _exit_found():
	$ScoreTimer.stop()
	_clear_screen()
	_level += 1
	$popups.show_popup(_level + _lives - 1)


func _lose_life():
	$ScoreTimer.stop()
	_clear_screen()
	_lives -= 1
	_lost_lvl = true



func _check_levels():
	
	$popups.hide_popup()
	
	if _lives == 0:
		$HUD.show_game_over()
		_clear_screen()
	
	elif _lost_lvl == true:
		$HUD.show_level_over(_lives, _level)
		_clear_screen()
	
	elif _level == 4:
		$HUD.show_game_won()
		_clear_screen()
	
	else:
		$HUD.show_level_won(_level)
		_clear_screen()


func _check_start():
	if _lives == 0 or _level == 4:
		_new_game()
	else:
		_next_level()

