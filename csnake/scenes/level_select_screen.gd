extends Control

@export var bfs1 : PackedScene
@export var bfs2 : PackedScene

@export var dfs1 : PackedScene
@export var dfs2 : PackedScene

func _ready():
	$BFS1.visible = true
	$DFS1.visible = true

func _on_bfs1_pressed():
	get_tree().change_scene_to_packed(bfs1)

func _on_dfs_1_pressed():
	get_tree().change_scene_to_packed(dfs1)


func _on_bfs2_pressed():
	get_tree().change_scene_to_packed(bfs2)

func _on_dfs2_pressed():
	get_tree().change_scene_to_packed(dfs2)



func _on_logout_pressed():
	get_tree().change_scene_to_file("res://scenes/loginregisterselect.tscn")


func _on_cosmetics_pressed():
	get_tree().change_scene_to_file("res://scenes/cosmetics.tscn")
