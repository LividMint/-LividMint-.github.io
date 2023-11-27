extends Node3D

var target: CharacterBody3D

func _ready():
	target = $"../../../../../Player"

func _physics_process(delta):
	look_at(target.global_position + Vector3(0, 1.5, 0))
