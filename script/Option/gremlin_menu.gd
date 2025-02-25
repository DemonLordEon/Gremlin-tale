extends Control


func _on_death_pressed():
	get_tree().change_scene_to_file("res://scence/game/game.tscn")
	global.current_player = "death"

func _on_kapish_pressed():
	get_tree().change_scene_to_file("res://scence/game/game.tscn")
	global.current_player = "kapish"

func _on_koda_pressed():
	get_tree().change_scene_to_file("res://scence/game/game.tscn")
	global.current_player = "koda"




func _on_eon_pressed():
	get_tree().change_scene_to_file("res://scence/game/game.tscn")

func _ready():
	var eon_button = $MarginContainer/VBoxContainer/Eon
	eon_button.visible = false
	
