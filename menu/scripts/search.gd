extends Control

@onready var vbox = $Scroll/Tags

func _on_searchbar_text_changed(text):
	var lower_text = text.to_lower()

	var begins_with_matches = []
	var contains_matches = []

	for button in vbox.get_children():
		var lower_button_text = button.text.to_lower()
		if lower_text in lower_button_text:
			if lower_button_text.begins_with(lower_text):
				begins_with_matches.append(button)
			else:
				contains_matches.append(button)

	var matches = begins_with_matches + contains_matches

	for i in range(matches.size()):
		vbox.move_child(matches[i], i)

	for button in vbox.get_children():
		if button in matches:
			button.show()
		elif text == "":
			button.show()
		else:
			button.hide()

func _on_exit_pressed():
	get_tree().quit()
