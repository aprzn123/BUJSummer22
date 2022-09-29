extends KinematicBody

export var max_speed = 15
export var gravity = 70

onready var pivot = $Pivot

var velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector, delta)
	
	velocity = move_and_slide(velocity)
	
	
func get_input_vector():
	var input_vector = Vector3.ZERO
	
	input_vector.x = Input.get_action_raw_strength("move_right") - Input.get_action_raw_strength("move_left")
	input_vector.z = Input.get_action_raw_strength("move_back") - Input.get_action_raw_strength("move_forward")
	
	return input_vector.normalized()
	
	
func apply_movement(vector, delta):
	velocity.x = vector.x * max_speed
	velocity.z = vector.z * max_speed
	
	if vector:
		var target_position = translation + vector
		var new_transform = transform.looking_at(target_position, Vector3.UP)
		pivot.transform  = pivot.transform.interpolate_with(new_transform, max_speed * delta)
	
