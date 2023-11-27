extends CharacterBody3D

#Speed (obviously)
var speed = 7

var health = 3

#targeting and nav
@onready var nav: NavigationAgent3D = $Navigation/NavigationAgent3D
@export var Target: CharacterBody3D

#Melee


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass

func _process(_delta):
	pass

func _physics_process(delta):
	#Gravity
	if not is_on_floor(): velocity.y -= gravity * delta
	#This is for looking at the player and moving and avoiding other agents
	var current_location = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	nav.set_velocity(new_velocity);move_and_slide()
func update_target_location(target_location):nav.target_location = target_location
func _on_navigation_agent_3d_velocity_computed(safe_velocity):velocity = velocity.move_toward(safe_velocity, .25);move_and_slide()
