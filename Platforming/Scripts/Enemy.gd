extends CharacterBody3D

#Speed (obviously)
var speed = 5

var health = 3

#targeting and nav
@onready var nav: NavigationAgent3D = $Navigation/NavigationAgent3D
@export var Target: CharacterBody3D

#shooting
@onready var Shoot = $Head/Shoot
@onready var Bulletspawn = $Head/ShootPlayerCheck/BulletSpawn
@onready var bulletscene = preload("res://Scenes/bullet.tscn")
@onready var aimcheck = $Head/ShootPlayerCheck
@onready var playercheck = $Head/PlayerCheck

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Shoot.start()

func _process(_delta):
	#THIS IS FOR STOPPING THE ENEMY WHEN IT MAKES SIGHT WITH PLAYER (WITHIN RAYCRAST DISTANCE)
	if playercheck.is_colliding():
		var target = playercheck.get_collider()
		if target.is_in_group("Player"):
			speed = 0
		else:speed = 5

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

#shooting
func _on_shoot_timeout():
	if aimcheck.is_colliding():
		var target = aimcheck.get_collider()
		if target.is_in_group("Player"):
			spawn_bullet()

func spawn_bullet():
	var projectile = bulletscene.instantiate()
	projectile.rotation_degrees = Bulletspawn.global_transform.basis.get_euler()
	Bulletspawn.add_child(projectile)
