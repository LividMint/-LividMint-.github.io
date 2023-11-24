extends RayCast3D

@onready var closedoorcheck = $"."
@onready var closedoor = $"../AnimationPlayer"

func _physics_process(delta):
	if closedoorcheck.is_colliding():
		var target = closedoorcheck.get_collider()
		if target.is_in_group("Player"):
			closedoor.play()
