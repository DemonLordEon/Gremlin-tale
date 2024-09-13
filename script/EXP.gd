extends Label

@onready var game = get_node("/root/game")

func update_text(level, experience, required_exp):
	self.text = """Level: %s
Experience: %s
Next level: %s""" % [level, experience, required_exp]

