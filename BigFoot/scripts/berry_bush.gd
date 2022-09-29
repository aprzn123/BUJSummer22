extends Spatial

var picked:= false
var is_being_picked: = false

export(Array, int) var days_to_spawn_in
export(float) var time_to_interact = 0.5

onready var collider = $Area/CollisionShape
onready var interaction_timer = $InteractionTimer

func _ready():
	interaction_timer.wait_time = time_to_interact
	on_new_day()


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		GlobalVariables.player.nearby_interactables.append(get_path())
#		highlight bush?


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		GlobalVariables.player.nearby_interactables.erase(get_path())
#		remove highlight

func on_interaction():
	if !picked and !is_being_picked:
		is_being_picked = true
		interaction_timer.start()
		print(str(self) + "is being interacted with!")
#		show interaction bar filling up or smth

func cancel_interaction():
	if !picked:
		is_being_picked = false
		interaction_timer.stop()
	
func _on_InteractionTimer_timeout():
	GlobalVariables.berries_picked += 1
	picked = true
#	switch to model without berries
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






