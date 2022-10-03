extends KinematicBody

export var max_speed = 15
export var gravity = 70

onready var pivot = $Pivot

var velocity = Vector3.ZERO

var selected_interactable
var nearby_interactables = []




func _ready():
	GlobalVariables.player = self
	GlobalVariables.camera_focus = self

func _process(delta):
	if GlobalVariables.camera_focus == self:
		var input_vector = get_input_vector()
		apply_movement(input_vector, delta)
		
		velocity = move_and_slide(velocity)
		
		if Input.is_action_just_pressed("interact"):
			interact()
	
	
func get_input_vector():
	var input_vector = Vector3.ZERO
	
	input_vector.x = Input.get_action_raw_strength("move_right") - Input.get_action_raw_strength("move_left")
	input_vector.z = Input.get_action_raw_strength("move_backwards") - Input.get_action_raw_strength("move_forward")
	
	return input_vector.normalized()
	

func apply_movement(vector, delta):
	velocity.x = vector.x * max_speed
	velocity.z = vector.z * max_speed
	
	cancel_interaction()
	
#	couldn't make it smooth without messing up the mesh's position
	if vector:
		pivot.look_at(translation + vector, Vector3.UP)
		pass

func cancel_interaction():
	if velocity and selected_interactable in nearby_interactables:
		if get_node(selected_interactable).has_method("cancel_interaction"):
			get_node(selected_interactable).cancel_interaction()


func interact():
	if nearby_interactables:
		var distance_to_interactable = 1000
		
		for interactable in nearby_interactables:
			if get_node(interactable).global_transform.origin.distance_to(self.global_transform.origin) < distance_to_interactable:
				selected_interactable = interactable
		
		if get_node(selected_interactable).has_method("on_interaction"):
			get_node(selected_interactable).on_interaction()
