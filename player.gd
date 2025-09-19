extends CharacterBody3D

@onready var voxel_terrain = get_node("/root/world/VoxelTerrain")

@onready
var voxel_tool : VoxelTool = voxel_terrain.get_voxel_tool()

const SPEED = 5.0
const JUMP_VELOCITY = 7


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("dig"):
		voxel_tool.mode = VoxelTool.MODE_REMOVE
		
		voxel_tool.do_sphere($Camera3D/DigMarker.global_position, 5.0)
	if Input.is_action_just_pressed("make"):
		voxel_tool.mode = VoxelTool.MODE_ADD
		
		voxel_tool.do_sphere($Camera3D/DigMarker.global_position, 5.0)
