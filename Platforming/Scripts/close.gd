extends Area3D

@onready var animationPlayer = $"../ClosingDoor/AnimationPlayer"
@onready var pillars = [$"../../NavigationRegion3D/CombatRoom/Pillars/Pillar 1/AnimationPlayer", $"../../NavigationRegion3D/CombatRoom/Pillars/Pillar 2/AnimationPlayer"]
@onready var lightchange = $"../../Lightmap/AnimationPlayer"

func _on_body_entered(body):
	animationPlayer.play("new_animation")
	lightchange.play("Lightchange")
	await get_tree().create_timer(4.0).timeout
	for i in pillars:
		i.play("EnemyOpenDoor")

