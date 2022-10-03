extends Spatial

signal new_day

func _ready():
	for child in get_children():
		if child.has_method("on_new_day"):
			connect("new_day", child, "on_new_day")


func _process(delta):
	if Input.is_action_just_pressed("debug_key"):
		if GlobalVariables.camera_focus != $PineTree:
			GlobalVariables.change_camera_focus($PineTree, 1)
		advance_day()
	
	$CanvasLayer/Label.text = "day: %s" %GlobalVariables.current_day + "\n" + "Berries: %s" %GlobalVariables.berries_picked 
	pass

func advance_day():
	GlobalVariables.current_day += 1
	emit_signal("new_day")
	
