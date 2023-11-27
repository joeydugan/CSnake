extends Control

func _ready():
	pass


func _on_green_hat_pressed():
	pass # Replace with function body.


func _on_red_hat_pressed():
	pass


func _on_blue_hat_pressed():
	pass # Replace with function body.


func _on_pink_hat_pressed():
	pass # Replace with function body.



func _on_logout_pressed():
	get_tree().change_scene_to_file("res://scenes/level_select_screen.tscn")



func check_user_hat(username, color):
	if username == null:
		return false
	else:
		if color == "green":
			return true
		elif color == "red":
			pass
		elif color == "blue":
			pass
		elif color == "pink":
			pass
		else:
			pass
	
