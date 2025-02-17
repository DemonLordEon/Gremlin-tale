extends Control

@onready var _character = get_node("/root/game/Player")
@onready var _en = get_node("/root/game/enemy")

# Function to handle save slot button presses
func _on_save_slot_pressed(slot_index: int):
	var file_name = "save_slot_%d.json" % slot_index
	
	# Check if the save file exists
	if file_exists(file_name):
		load_game(file_name)
	else:
		print("Save file not found for slot %d. Creating a new save." % slot_index)
		save_game(file_name)  # Create a new save if it doesn't exist


# Check if the save file exists
func file_exists(file_name: String) -> bool:
	var file = FileAccess.open("user://" + file_name, FileAccess.READ)
	if file:
		file.close()
		return true
	return false

# Save the game to a file
func save_game(file_name: String):
	if _character:
		var save_dict = {
			"filename": get_tree().current_scene.scene_file_path,  # Save scene path
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
		var file = FileAccess.open("user://" + file_name, FileAccess.WRITE)
		file.store_string(JSON.stringify(save_dict))
		file.close()
		print("Game saved to", file_name)

# Load the game from a save file
func load_game(file_name: String):
	var file = FileAccess.open("user://" + file_name, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var json = JSON.new()
		var error = json.parse(content)
		file.close()
	


# Signal connections for buttons
func _on_save_1_pressed():
	_on_save_slot_pressed(1) 
	hide()
	_character.show()
	_en.show()
	
func _on_save_2_pressed():
	_on_save_slot_pressed(2)

func _on_save_3_pressed():
	_on_save_slot_pressed(3)


# C:\Users\ella0502\AppData\Roaming\Godot\app_userdata\gremlintale find the save file 
