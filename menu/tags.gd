extends Control

var matches = []
@onready var tags = get_children()

func _on_searchbar_text_changed(new_text):
	matches.clear()
	if new_text == "":
		for i in tags:
			i.hide()
		return

	var lower_new_text = new_text.to_lower()

	for i in tags:
		if i.text.to_lower().begins_with(lower_new_text):
			matches.append(i)
	
	for i in tags:
		if i in matches:
			i.show()
		else:
			i.hide()
			

