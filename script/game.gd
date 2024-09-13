extends Node2D

var player_current_attack = false 

#trying to create exp this code dosent work entiwrly yet
@onready var _character = get_node("/root/game/Death")
@onready var _label = get_node("/root/game/Death/EXP")
@onready var _bar : TextureProgressBar = get_node("/root/game/Death/Interface/ExperienceBar")
@onready var _en = get_node("/root/game/enemy")


#when rwady it goes thrue character exp and requierd amount of exp to see if we reached a level up
func _ready():
	
	_bar.max_value = _character.experience_required
	_label.update_text(_character.level, _character.experience, _character.experience_required)

func _input(event):
	if _en != null:
		if _en.health <= 0:
			return
		_character.gain_experience(_en.gained_experience)
		_label.update_text(_character.level, _character.experience, _character.experience_required)
