extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO

var boolSpawnFirstTime = false

@onready var cam = $Camera3D

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	cam.current = is_multiplayer_authority()

func _physics_process(delta):
	if is_multiplayer_authority():
		if boolSpawnFirstTime == false:
			global_position = Vector3(5,5,5)
			boolSpawnFirstTime = true
		
		var direction = Vector3.ZERO

		if Input.is_action_pressed("ui_right"):
			direction.x += 1
		if Input.is_action_pressed("ui_left"):
			direction.x -= 1
		if Input.is_action_pressed("ui_down"):
			direction.z += 1
		if Input.is_action_pressed("ui_up"):
			direction.z -= 1

		if direction != Vector3.ZERO:
			direction = direction.normalized()
			# Setting the basis property will affect the rotation of the node.
			# $Pivot.basis = Basis.looking_at(direction)

		# Ground Velocity
		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed

		# Vertical Velocity
		if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
			target_velocity.y = target_velocity.y - (fall_acceleration * delta)

		# Moving the Character
		velocity = target_velocity
		move_and_slide()
