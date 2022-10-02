extends Node2D

var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var SFX_bus = AudioServer.get_bus_index("SFX")

func _ready():
	go_to_title_screen()

func _on_TutorialButton_pressed():
	go_to_tutorial()

func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/game.tscn")
	
func _on_SettingsButton_pressed():
	go_to_settings()

func _on_CreditsButton_pressed():
	go_to_credits()

func _on_BackButton_pressed():
	go_to_title_screen()


func go_to_title_screen():
	$TitleScreen.visible = true
	$Settings.visible = false
	$BackButton.visible = false
	$Credits.visible = false
	$Tutorial.visible = false
	
func go_to_settings():
	$TitleScreen.visible = false
	$Settings.visible = true
	$BackButton.visible = true
	$Credits.visible = false
	$Tutorial.visible = false

func go_to_credits():
	$TitleScreen.visible = false
	$Settings.visible = false
	$BackButton.visible = true
	$Credits.visible = true
	$Tutorial.visible = false

func go_to_tutorial():
	$TitleScreen.visible = false
	$Settings.visible = false
	$BackButton.visible = true
	$Credits.visible = false
	$Tutorial.visible = true


func _on_MasterVolumeSlider_value_changed(value):
	change_volume(master_bus, value)

func _on_MusicVolumeSlider_value_changed(value):
	change_volume(music_bus, value)
	
func _on_SFXVolumeSlider_value_changed(value):
	change_volume(SFX_bus, value)

func change_volume(bus, value):
	AudioServer.set_bus_volume_db(bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(bus, true)
	else:
		AudioServer.set_bus_mute(bus, false)


func _on_ArtNames_meta_clicked(meta):
	OS.shell_open(meta)
	
func _on_AudioNames_meta_clicked(meta):
	OS.shell_open(meta)

func _on_CodeNames_meta_clicked(meta):
	OS.shell_open(meta)

func _on_GamedesignNames_meta_clicked(meta):
	OS.shell_open(meta)

func _on_WritingNames_meta_clicked(meta):
	OS.shell_open(meta)
