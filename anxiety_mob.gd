# Citation: https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html
# Mob Images by Admurin: https://admurin.itch.io/enemy-galore-1
extends RigidBody2D


var min_speed = 50
var max_speed = 250
var mob_speed = null
# Set randomness in the anxiety mob's speed for unexpected actions
func _set_random_speed():
	mob_speed = randf_range(min_speed, max_speed)
	return mob_speed


func _physics_process(delta):
	# Get the player's position from the globally acessible singleton
	var player_pos = GameSingleton.player_position
	if player_pos != Vector2():
		# Calculate the direction vector from the mob to the player
		var direction = (player_pos - global_position).normalized()
		linear_velocity = direction * _set_random_speed()
