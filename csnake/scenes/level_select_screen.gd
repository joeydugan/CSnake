extends Control

func _ready():
	$BFS1.visible = true
	$DFS1.visible = true

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/BFS1.tscn")

func _on_dfs_1_pressed():
	get_tree().change_scene_to_file("res://scenes/DFS1.tscn")
