extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
const UP_DIRECTION = Vector2.UP
onready var _animated_sprite = get_node("CollisionShape2D/AnimatedSprite")
const SPEED = 300.0
const JUMP_VELOCITY = -100.0
var velocity = Vector2.ZERO
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		_animated_sprite.play("jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction == -1:
		get_node("CollisionShape2D/AnimatedSprite").flip_h = true
	elif direction == 1:
		get_node("CollisionShape2D/AnimatedSprite").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			_animated_sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			_animated_sprite.play("idle")
	if velocity.y > 0:
		_animated_sprite.play("fall")
	
	velocity = move_and_slide(velocity, UP_DIRECTION)
			
	
	
