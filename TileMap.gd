#code is from: https://github.com/kidscancode/godot3_procgen_demos

extends Node2D

#these #s are used because they are different places in binary
const N = 1
const E = 2
const S = 4
const W = 8

#creates mapping between 4 variables and which wall
var cell_walls  = {Vector2i(0,-1): N, Vector2i(1,0): E, 
				   Vector2i(0, 1): S, Vector2i(-1, 0): W}

var tile_size = 64
#creates size of maze
var width = 25
var height = 15

#get a ref to the map easily
@onready var Map = $/root/Maze/TileMap

func _ready():
	randomize()
	tile_size = Map.tile_size
	make_maze()
	
func check_neighbors(cell, unvisited):
	#returns array of cell's unvisited neighbors
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited:
			list.append(cell + n)
	return list
	
func make_maze():
	var unvisited = []
	var stack = [] #use array to create stack
	
	#fill the map with solid tiles
	Map.clear()
	for x in range(width):
		for y in range(height):
			unvisited.append(Vector2i(x,y))
			Map.set_cell(0, Vector2i(x, y), N|E|S|W)
	var current = Vector2i(0,0)
	unvisited.erase(current) #removes from unvisited list
	
	while unvisited: 
		var neighbors = check_neighbors(current,unvisited)
		if neighbors.size() > 0: #checks that all the neighbors are unvisited. 
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			#remove walls from both cells
			var dir = next - current
			var current_walls = Map.get_cell_source_id(0, current, false) - cell_walls[dir]
			var next_walls = Map.get_cell_source_id(0, next, false) - cell_walls[-dir]
			Map.set_cell(0, current, current_walls)
			Map.set_cell(0, next, next_walls)
			current = next
		elif stack: #if we have no more neighbors, backtracks
			current = stack.pop_back() 

	
