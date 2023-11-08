extends Control

func _ready():
	
	SilentWolf.configure({
		"api_key": "vb2RC8kTq34dabCpkmsH3oXZRMxl1rokSVxeSd00",
		"game_id": "CSnake",
		"log_level": 1
	})
	
	$Register.visible = true
	$Login.visible = true

func _on_button_pressed():
	get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Register.tscn")

func _on_dfs_1_pressed():
	get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Login.tscn")
