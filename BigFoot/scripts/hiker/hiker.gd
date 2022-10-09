extends KinematicBody

var suspicion = 0 setget set_suspicion;
onready var target = $States/Base

var loc_targets = []

func setup(dir):
	for i in get_tree().get_nodes_in_group("hiker_points_list")[0].get_children():
		if dir == 1:
			loc_targets.push_back(i.global_position)
		else:
			loc_targets.push_front(i.global_position)
	global_position = loc_targets.pop_front()

func set_suspicion(n):
	suspicion = n
	if suspicion < 20: 
		target.stop()
		target = $States/Base
		target.start()
	elif suspicion < 50:
		target.stop()
		target = $States/Alert
		target.start()
	elif suspicion < 80:
		target.stop()
		target = $States/Investigate
		target.start()
	else:
		target.stop()
		target = $States/FindCameraMan
		target.start()
	
func _process(delta):
	target.process(self, delta)
