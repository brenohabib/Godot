extends Node2D

@onready var http_request = $Request/HTTPRequest
const URL = "http://localhost:8080/hello"

signal info(data)

func _on_request_button_down():
	http_request.cancel_request()
	http_request.request(URL)


func _on_http_request_request_completed(_result, _response_code, _headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	print(data)
	http_request.cancel_request()
	info.emit(data)
