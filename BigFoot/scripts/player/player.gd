extends KinematicBody

export var max_speed = 15
export var gravity = 70

onready var pivot = $Pivot

var velocity = Vector3.ZERO

signal interacted

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.player = self


func _process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector, delta)
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("interact"):
		emit_signal("interacted")
	
	
func get_input_vector():
	var input_vector = Vector3.ZERO
	
	input_vector.x = Input.get_action_raw_strength("move_right") - Input.get_action_raw_strength("move_left")
	input_vector.z = Input.get_action_raw_strength("move_back") - Input.get_action_raw_strength("move_forward")
	
	return input_vector.normalized()
	
	
func apply_movement(vector, delta):
	velocity.x = vector.x * max_speed
	velocity.z = vector.z * max_speed
	
#	couldn't make it smooth without messing up the mesh's position
	if vector:
		pivot.look_at(translation + vector, Vector3.UP)
		pass

	
