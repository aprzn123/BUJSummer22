extends Spatial

var picked:= false
var is_being_picked: = false

export(Array, int) var days_to_spawn_in
export(float) var time_to_interact = 0.5

onready var collider = $Area/CollisionShape
onready var interaction_timer = $InteractionTimer

func _ready():
	$InteractionProgressBar.texture = $InteractionProgressBar/Viewport.get_texture()
	interaction_timer.wait_time = time_to_interact
	$InteractionProgressBar/Viewport/TextureProgress.min_value = -time_to_interact
	$InteractionProgressBar/Viewport/TextureProgress.max_value = 0
	on_new_day()

func _process(delta):
	if interaction_timer.is_stopped():
		$InteractionProgressBar.modulate = Color(1, 1, 1, 0)
	else: 
		$InteractionProgressBar.modulate = Color(1, 1, 1, 1)
		
	$InteractionProgressBar/Viewport/TextureProgress.value = -interaction_timer.time_left

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
		$InteractionProgressBar/Viewport/TextureProgress.value = -time_to_interact
		interaction_timer.stop()
	
func _on_InteractionTimer_timeout():
	GlobalVariables.berries_picked += 1
	picked = true
	$Bush/Berries.visible = false
	
func change_enabled(boolean:= true):
	visible = boolean
	collider.disabled = !boolean
	

func on_new_day():
	if GlobalVariables.current_day in days_to_spawn_in:
		change_enabled(true)
		picked = false
		is_being_picked = false
		$Bush/Berries.visible = true
	else:
		change_enabled(false)






