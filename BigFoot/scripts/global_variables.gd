extends Node


var SFX_volume = 1
var music_volume = 1

var player
var camera_focus

var berries_picked: int = 0
var current_day: int = 1

func change_camera_focus(new_focus, seconds):
	camera_focus = new_focus
	yield(get_tree().create_timer(seconds), "timeout")
	camera_focus = player
