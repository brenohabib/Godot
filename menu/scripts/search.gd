extends Control

@onready var vbox = $Tech/Buttons
var original_button_order = []

func _ready():
	# Armazena a ordem original dos botões
	for i in range(vbox.get_child_count()):
		original_button_order.append(vbox.get_child(i))

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

	# Reordena os botões com base nos resultados da pesquisa
	for i in range(matches.size()):
		vbox.move_child(matches[i], i)

	# Exibe/Oculta botões de acordo com o texto da pesquisa e estado original
	for button in vbox.get_children():
		if button in matches:
			button.show()
		elif text == "":
			# Se a pesquisa estiver vazia, restaura a ordem original
			var original_index = original_button_order.find(button)
			if original_index != -1:
				vbox.move_child(button, original_index)
			button.show()  # Exibe todos os botões quando a pesquisa estiver vazia
		else:
			button.hide()
