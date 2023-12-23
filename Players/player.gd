extends CharacterBody2D
class_name player

const SPEED = 120.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var state_machine = animation_tree.get("parameters/playback")

@export var starting_direction = 1

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Change between idle and walk animation
	pick_new_state()
	
	#Check if attack
	var attack = Input.get_action_strength("attack")
	if attack and state_machine.get_current_node() != "Attack":
		state_machine.travel("Attack")
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		update_animation_parameters(direction)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	move_and_slide()

func update_animation_parameters(move_input : float):
	if (move_input != 0):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Falling/blend_position", move_input)
		animation_tree.set("parameters/Rising/blend_position", move_input)
		animation_tree.set("parameters/Attack/blend_position", move_input)

func pick_new_state():
	if (velocity.y == 0):
		if (velocity.x == 0):
			state_machine.travel("Idle")
		else:
			state_machine.travel("Walk")
	else:
		if (velocity.y < 0):
			state_machine.travel("Rising")
		else:
			state_machine.travel("Falling")

