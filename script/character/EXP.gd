extends Label

func update_text(level, experience, required_experience):
	text = """Level: %s
			Experience: %s
			Next Level: %s
				""" % [level, experience, required_experience]
