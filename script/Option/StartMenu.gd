extends Control

func _on_play_pressed():
	print("start")
	get_tree().change_scene_to_file("res://scence/game/game.tscn")
	
func _on_option_pressed():
	pass
	
func _on_quit_pressed():
	get_tree().quit()
