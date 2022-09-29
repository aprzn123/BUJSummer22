extends Spatial

var picked:= false
export(Array, int) var days_to_spawn_in

onready var collider = $Area/CollisionShape

func _ready():
	on_new_day()


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		body.connect("interacted", self, "on_interaction")
#		highlight bush?


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		body.disconnect("interacted", self, "on_interaction")
#		remove highlight

func on_interaction():
	if !picked:
		GlobalVariables.berries_picked += 1
		picked = true
#		switch to model without berries
		$MeshInstance.mesh.material.albedo_color = Color.red
	
	
func change_enabled(boolean:= true):
	visible = boolean
	collider.disabled = !boolean
	

func on_new_day():
	if GlobalVariables.current_day in days_to_spawn_in:
		change_enabled(true)
		picked = false
#		switch to model with berries
		$MeshInstance.mesh.material.albedo_color = Color.green
	else:
		change_enabled(false)
