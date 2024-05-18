extends Button

@onready var http_request = $HTTPRequest
const URL = "http://127.0.0.1:8080/hello"
const BASE_URL = "http://127.0.0.1:8080/recommend"

signal recommendations_received(data)

func _on_request_button_down():
	http_request.cancel_request()
	var category = "programming_language"  # Exemplo: Obtido de um campo de entrada
	var popularity = "high"  # Exemplo: Obtido de um campo de entrada
	var url = BASE_URL + "?category=" + category + "&popularity=" + popularity
	http_request.request(url)

func _on_http_request_request_completed(_result, _response_code, _headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	print(data)
	http_request.cancel_request()
	recommendations_received.emit(data)

