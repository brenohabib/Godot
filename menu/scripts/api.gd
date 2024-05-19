extends HTTPRequest

@onready var http_request = self
const BASE_URL = "http://127.0.0.1:8080/tech_info"
signal recommendations_received(data)

func _on_python_button_down():
	send_request("python")

func _on_java_button_down():
	send_request("java")

func _on_elixir_button_down():
	send_request("elixir")

func _on_django_button_down():
	send_request("django")

func _on_flask_button_down():
	send_request("flask")

func _on_react_button_down():
	send_request("react")

func _on_angular_button_down():
	send_request("angular")

func _on_basic_button_down():
	send_request("basic")

func _on_c_button_down():
	send_request("c")

func _on_go_button_down():
	send_request("go")

func _on_haskell_button_down():
	send_request("haskell")

func _on_itk_button_down():
	send_request("irk")

func _on_kawa_button_down():
	send_request("kawa")

func _on_lua_button_down():
	send_request("lua")

func _on_matlab_button_down():
	send_request("matlab")

func _on_nasm_button_down():
	send_request("nasm")

func _on_open_cl_button_down():
	send_request("opencl")

func _on_prolog_button_down():
	send_request("prolog")

func _on_q_basic_button_down():
	send_request("qbasic")

func _on_scratch_button_down():
	send_request("scratch")

func _on_type_script_button_down():
	send_request("typescript")

func _on_unicon_button_down():
	send_request("unicon")

func _on_visual_basic_button_down():
	send_request("visual_basic")

func _on_web_gl_button_down():
	send_request("webgl")

func _on_xojo_button_down():
	send_request("xojo")

func _on_yorick_button_down():
	send_request("yorick")

func _on_zig_button_down():
	send_request("zig")

func send_request(language: String):
	http_request.cancel_request()
	var url = BASE_URL + "?name=" + language
	http_request.request(url)
							 
func _on_request_completed(_result, _response_code, _headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	if data == null:
		$"../Label".show()
		$"../Label/Timer".start()
	else:
		print(data)
	http_request.cancel_request()
	recommendations_received.emit(data)




