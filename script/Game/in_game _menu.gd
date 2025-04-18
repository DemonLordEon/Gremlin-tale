
extends Control

@onready var _character = get_node("/root/game/Player")
@onready var _en = get_node("/root/game/enemy")
@onready var save_button = $SaveButton  # Replace with actual node path

# Function to handle save button press
func _on_save_pressed():
	var file_name = "save_slot_1.json"  # Change this if using multiple slots
	save_game(file_name)
	print("Game progress updated in", file_name)

# Save the game to a file
func save_game(file_name: String):
	if _character:
		var save_dict = {
			"filename": get_tree().current_scene.scene_file_path,  # Save scene path
			"pos_x": _character.position.x,  # Player position
			"pos_y": _character.position.y,
			"attack": _character.attack,  # Player stats
			"hp": _character.health,
			"magick": _character.magick,
			"experience": _character.experience,
			"experience_required": _character.experience_required,
			"experience_total": _character.experience_total,
			"level": _character.level
		}
		var file = FileAccess.open("user://" + file_name, FileAccess.WRITE)
		file.store_string(JSON.stringify(save_dict, "\t"))  # Pretty-print JSON
		file.close()
		print("Game saved successfully!")

# Toggle menu visibility with ESC
func _process(_delta):
	if Input.is_action_just_pressed("ESC"):
		visible = !visible
