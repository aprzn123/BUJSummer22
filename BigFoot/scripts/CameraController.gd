extends Spatial

export var follow_speed = 10
export var max_fov: float = 100
export var min_fov: float = 30


func _ready():
	pass


func _process(delta):
	global_translation = lerp(global_translation, GlobalVariables.camera_focus.global_translation, follow_speed * delta)
	if Input.is_action_just_released("zoom_in"):
		change_camera_fov(-5)
	if Input.is_action_just_released("zoom_out"):
		change_camera_fov(5)


func change_camera_fov(amount):
	$Camera.fov += amount
	$Camera.fov = clamp($Camera.fov, min_fov, max_fov)
