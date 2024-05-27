extends HTTPRequest

# URLs for requests
const RECOMMEND_URL = "http://127.0.0.1:8080/recommend"

@onready var side_menu = $"../../../Side"
var active_categories = []

signal recommendations_received(data)

func _on_programming_language_toggled(toggled_on):
	if toggled_on:
		active_categories.append("category=programming_language")
	else:
		var index = active_categories.find("category=programming_language")
		active_categories.remove_at(index)

func _on_framework_toggled(toggled_on):
	if toggled_on:
		active_categories.append("category=framework")
	else:
		var index = active_categories.find("category=framework")
		active_categories.remove_at(index)

func _on_frontend_toggled(toggled_on):
	if toggled_on:
		active_categories.append("category=frontend")
	else:
		var index = active_categories.find("category=frontend")
		active_categories.remove_at(index)

func _on_toolkit_toggled(toggled_on):
	if toggled_on:
		active_categories.append("category=toolkit")
	else:
		var index = active_categories.find("category=toolkit")
		active_categories.remove_at(index)


func _on_popularity_high_toggled(toggled_on):
	if toggled_on:
		active_categories.append("popularity=alta")
	else:
		var index = active_categories.find("popularity=alta")
		active_categories.remove_at(index)

func _on_popularity_medium_toggled(toggled_on):
	if toggled_on:
		active_categories.append("popularity=media")
	else:
		var index = active_categories.find("popularity=media")
		active_categories.remove_at(index)

func _on_popularity_low_toggled(toggled_on):
	if toggled_on:
		active_categories.append("popularity=baixa")
	else:
		var index = active_categories.find("popularity=baixa")
		active_categories.remove_at(index)


func _on_dificulty_high_toggled(toggled_on):
	if toggled_on:
		active_categories.append("difficulty=alta")
	else:
		var index = active_categories.find("difficulty=alta")
		active_categories.remove_at(index)

func _on_dificulty_medium_toggled(toggled_on):
	if toggled_on:
		active_categories.append("difficulty=media")
	else:
		var index = active_categories.find("difficulty=media")
		active_categories.remove_at(index)

func _on_dificulty_low_toggled(toggled_on):
	if toggled_on:
		active_categories.append("difficulty=baixa")
	else:
		var index = active_categories.find("difficulty=baixa")
		active_categories.remove_at(index)

func send_request():
	cancel_request()
	var url = RECOMMEND_URL + "?"
	# Build the query string based on active categories
	for category in active_categories:
		url += category + "&"
	
	request(url)

func _on_search_button_pressed():
	send_request()

func _on_request_completed(_result, response_code, _headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	var buttons = $"../Tab/Tags/Tech/Buttons"
	if data == null:
		show_error()
	elif response_code == 500:
		show_error()
	else:
		var recommendations = data["recommendations"]
		for button in buttons.get_children():
			if button is Button:  # Verificando se o filho é um botão
				var button_text = button.text.to_lower()  # Convertendo o texto do botão para minúsculas para comparação

				var found = false
				for linguagem in recommendations:
					if button_text == linguagem:
						found = true
						break  # Se encontramos a linguagem, não precisamos continuar verificando

				if found:
					button.show()
				else:
					button.hide()
	
	cancel_request()
	recommendations_received.emit(data)

func show_error():
	$"../ErrorDivide/Erro".show()
	$"../ErrorDivide/Erro/Timer".start()

