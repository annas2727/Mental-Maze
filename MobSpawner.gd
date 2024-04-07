# Citation: https://docs.godotengine.org/en/stable/tutorials/scripting/nodes_and_scene_instances.html
extends Node2D

	
func _on_spawn_timer_timeout():
	# Instantiate the mob scene for spawning 
	var mob_scene = load('res://mob.tscn')
	
	var mob_instantiate = mob_scene.instantiate()
	mob_instantiate.set_contact_monitor(true)
	mob_instantiate.set_max_contacts_reported(10)
	self.add_child(mob_instantiate)

	# Select one of the various mob spawn positions randomly to spawn the mob
	var spawn_points = get_tree().get_nodes_in_group('spawn')
	if spawn_points.size() > 0:
		var random_index = randi() % spawn_points.size()
		var spawn_position = spawn_points[random_index].global_position
		mob_instantiate.global_position = spawn_position
	$SpawnTimer.start()
	

		
# A mob spawns every 7 seconds
func _ready():
	pass
