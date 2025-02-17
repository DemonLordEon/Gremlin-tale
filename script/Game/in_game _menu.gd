extends Control

@onready var _character = get_node("/root/game/Player")

func _on_save_pressed():
	if _character:
		var save_dict = {
			"filename": get_scene_file_path(),
			"pos_x": _character.position.x,
			"pos_y": _character.position.y,
			"attack": _character.attack,
			"hp": _character.health,
			"magick": _character.magick,
			"experience": _character.experience,
			"experience_required": _character.experience_required,
			"experience_total": _character.experience_total,
			"level": _character.level
		}
		
		var json_data = JSON.stringify(save_dict)
		save_data("save_slot_1.json", json_data)  # Save to "save_slot_1.json"
		print("Game saved to slot 1")

# Save Data to File
func save_data(file_name, data):
	var save_file = FileAccess.open("user://" + file_name, FileAccess.WRITE)
	if save_file:
		save_file.store_pascal_string(data)
		print("Data saved to:", file_name)
	else:
		print("Failed to save file.")
		
		
		
