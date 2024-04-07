# Citation: https://docs.godotengine.org/en/stable/getting_started/first_2d_game/02.player_scene.html
# Character Images by Antifarea: https://opengameart.org/content/twelve-more-16x18-rpg-character-sprites

extends CharacterBody2D
signal hit
signal move


# Establish how fast the player will move (pixels/sec)
@export var speed = 300  
var screen_size

# Call when the node enters the scene tree for the first time
func _ready():
	pass

func show_character():
	# hide()
	screen_size = get_viewport_rect().size
	_start(screen_size / 2)
	# Use the singleton to assign player for others to access
	GameSingleton.player = self


# Move the player by detecting associated keyboard presses with up, down, etc.
func _process(delta):
	var velocity = Vector2.ZERO
	# Use the singleton to assign player position for others to access
	GameSingleton.player_position = global_position

	var collision = move_and_collide(velocity * delta)
	if collision:
		#print("I collided with ", collision.get_collider().name)
		pass
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1	
	position += velocity * delta * speed
	
	# Animate the player based on direction of movement
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "walk_right"
	elif velocity.x < 0:
		$AnimatedSprite2D.animation = "walk_left"
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down"
	if abs(velocity.x) > 1 or abs(velocity.y) > 1: 
		velocity = 0
		
func _on_body_entered(body):
	# Make the player disappear after being hit by a mob then a signal is emitted
	# hide() 
	hit.emit()
	# Disable the player's collision so that the hit signal is not hit more than once
	$CollisionShape2D.set_deferred("disabled", true)

# Call to reset the player when starting a new game
func _start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	move.emit()	
