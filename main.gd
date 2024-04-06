extends Node2D

var hud_enabled = true
const maze = preload("res://tile_map.tscn")

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
	

