extends Node

var score = 0
var level = 1
var lives = 3
var lost_lvl = false
var randex = randi_range(0, 6)
var array = [randex]

signal show_screen

var hud_enabled = true
var maze = load("res://tile_map.tscn")


func clear_screen():
	get_tree().call_group("mobs", "queue_free")
	$Player.hide()
	$TileMap.clear()


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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#func on_fringe_changed():


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		var new_maze = maze.instantiate()
		var existing_maze = get_children().filter(func(x):
			return "TileMap" in x.name)[0]
		existing_maze.queue_free()
		add_child(new_maze)
	


func next_level():
	$popups.hide_popup()
	lost_lvl = false
	$HUD.update_score(score)
	maze = load("res://tile_map.tscn")
	show_screen.emit()
	$Player._start($StartPosition.position)
	$ScoreTimer.start()
	$MobSpawner/SpawnTimer.set_paused(false)
	
	#await get_tree().create_timer(15.0).timeout
	#exit_found()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
	if Globals.was_hit == true:
		lose_life()


func exit_found():
	$MobSpawner/SpawnTimer.set_paused(true)
	$ScoreTimer.stop()
	clear_screen()
	level += 1
	$popups.show_popup(randex)
	while (array.find(randex) != -1):
		randex = randi_range(0, 6)
	array.push_back(randex)
	


func lose_life():
	$MobSpawner/SpawnTimer.set_paused(true)
	$ScoreTimer.stop()
	Globals.was_hit = false
	clear_screen()
	lives -= 1
	lost_lvl = true
	$popups.show_popup(randex)
	while (array.find(randex) != -1):
		randex = randi_range(0, 6)
	array.push_back(randex)


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
