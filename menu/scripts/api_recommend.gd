extends HTTPRequest

@onready var http_request = self
const RECOMMEND_URL = "http://127.0.0.1:8080/recommend"
signal recommendations_received(data)

func _on_request_completed(_result, _response_code, _headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	if data == null:
		$"../Label".show()
		$"../Label/Timer".start()
	else:
		print(data)
	http_request.cancel_request()
	recommendations_received.emit(data)
