extends Spatial

var picked:= false
var is_being_picked: = false
var rng = RandomNumberGenerator.new()
export(Array, int) var days_to_spawn_in
export(float) var time_to_interact = 0.5

onready var collider = $Area/CollisionShape
onready var interaction_timer = $InteractionTimer

func _ready():
	interaction_timer.wait_time = time_to_interact
	on_new_day()
	rng.randomize()


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		GlobalVariables.player.nearby_interactables.append(get_path())
		tween_bush()
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
	#$MeshInstance.mesh.material.albedo_color = Color.red
	
func change_enabled(boolean:= true):
	visible = boolean
	collider.disabled = !boolean
	

func on_new_day():
	if GlobalVariables.current_day in days_to_spawn_in:
		change_enabled(true)
		picked = false
#		switch to model with berries
		#$MeshInstance.mesh.material.albedo_color = Color.green
	else:
		change_enabled(false)

func tween_bush():
	print("tween_bush starting")
	
	var current_pos = Vector3()
	var final_pos = Vector3(2,2,2)
	var shake_speed =0.1
	var bushNode = $RaspberryBush
	
	current_pos = bushNode.scale
	
	var tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	
	
	AddTween(tween,bushNode,final_pos,shake_speed)
	AddTween(tween,bushNode,current_pos,shake_speed)
	AddTween(tween,bushNode,final_pos,shake_speed)
	AddTween(tween,bushNode,current_pos,shake_speed)

	


func AddTween(tween,node,final_pos,shake_speed):
	tween.tween_property(node,"scale",final_pos,shake_speed)

		

