extends Spatial

signal new_day

func _ready():
	for child in get_children():
		if child.has_method("on_new_day"):
			connect("new_day", child, "on_new_day")


func _process(delta):
	if Input.is_action_just_pressed("debug_key"):
		advance_day()
	pass

func advance_day():
	GlobalVariables.current_day += 1
	emit_signal("new_day")
	
