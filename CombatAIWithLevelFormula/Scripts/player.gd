extends CharacterBody3D

#movement
var SPEED = 20
const JUMP_VELOCITY = 0
var mouse_sens = 0.2
var lerp_speed = 5.0
var direction = Vector3.ZERO

@onready var head_bob = $Head/Camera3D/CameraBob

func _ready():
	#Mouse Capture
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 

func _input(event):
	#Mouse Movement and Clamp
	if event is InputEventMouseMotion: rotate_y(-deg_to_rad(event.relative.x * mouse_sens));$Head.rotate_x(-deg_to_rad(event.relative.y * mouse_sens));var camera_rotation = $Head.rotation;camera_rotation.x = clampf(camera_rotation.x, -1.4, 1.4);$Head.rotation = camera_rotation

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor(): velocity.y -= gravity * delta
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():velocity.y = JUMP_VELOCITY 
	#Movement
	var input_dir = Input.get_vector("left", "right", "forward", "backward");direction = lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta*lerp_speed);if direction:velocity.x = direction.x * SPEED;velocity.z = direction.z * SPEED
	else:velocity.x = move_toward(velocity.x, 0, SPEED);velocity.z = move_toward(velocity.z, 0, SPEED)
	if  input_dir == Vector2(0, 0):head_bob.speed_scale = 0.0
	else:head_bob.speed_scale = 0.2
	move_and_slide()
