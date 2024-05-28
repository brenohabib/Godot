extends HTTPRequest

@onready var http_request = self
@onready var side_menu = $"../../../Side"

const TECH_URL = "http://127.0.0.1:8080/tech_info"
signal recommendations_received(data)

@onready var descDatabase = load("res://menu/scripts/TechDescription.gd")

@export var nameofTech : String = "Angular"

func popup(data: Dictionary):
	var aux = str(data["tech_info"][0]).replace("{", "").replace("}", "").replace("\"", "")
	aux = aux.replace("name:", "Nome :").replace("category:", "Categoria :").replace("difficulty:", "Dificuldade :")
	aux = aux.replace("popularity:", "Popularidade :")
	
	var descInfo = descDatabase.DATA[descDatabase.get(nameofTech)]
	
	side_menu.get_node("MarginContainer/HBoxContainer/VBoxContainer/Name").text = aux.get_slice(",", 2)
	side_menu.get_node("MarginContainer/HBoxContainer/VBoxContainer/Category").text = aux.get_slice(",", 0)
	side_menu.get_node("MarginContainer/HBoxContainer/VBoxContainer/Difficulty").text = aux.get_slice(",", 1)
	side_menu.get_node("MarginContainer/HBoxContainer/VBoxContainer/Popularity").text = aux.get_slice(",", 3)
	side_menu.get_node("MarginContainer/HBoxContainer/VBoxContainer/ScrollContainer/Description").text = "\n" + descInfo[0]
	
	side_menu.get_node("MarginContainer/HBoxContainer/VBoxContainer/ScrollContainer/Description").show()

func _on_python_button_down():
	send_request("python")
	nameofTech = "Python"

func _on_java_button_down():
	send_request("java")
	nameofTech = "Java"
	
func _on_elixir_button_down():
	send_request("elixir")
	nameofTech = "Elixir"

func _on_django_button_down():
	send_request("django")
	nameofTech = "Django"

func _on_flask_button_down():
	send_request("flask")
	nameofTech = "Flask"

func _on_react_button_down():
	send_request("react")
	nameofTech = "React"

func _on_angular_button_down():
	send_request("angular")
	nameofTech = "Angular"

func _on_basic_button_down():
	send_request("basic")
	nameofTech = "BASIC"

func _on_c_button_down():
	send_request("c")
	nameofTech = "C"

func _on_go_button_down():
	send_request("go")
	nameofTech = "Go"

func _on_haskell_button_down():
	send_request("haskell")
	nameofTech = "Haskell"

func _on_itk_button_down():
	send_request("itk")
	nameofTech = "Itk"

func _on_kawa_button_down():
	send_request("kawa")
	nameofTech = "Kawa"

func _on_lua_button_down():
	send_request("lua")
	nameofTech = "Lua"

func _on_matlab_button_down():
	send_request("matlab")
	nameofTech = "MATLAB"

func _on_nasm_button_down():
	send_request("nasm")
	nameofTech = "Nasm"

func _on_open_cl_button_down():
	send_request("opencl")
	nameofTech = "OpenCL"

func _on_prolog_button_down():
	send_request("prolog")
	nameofTech = "Prolog"

func _on_q_basic_button_down():
	send_request("qbasic")
	nameofTech = "QBasic"

func _on_scratch_button_down():
	send_request("scratch")
	nameofTech = "Scratch"

func _on_type_script_button_down():
	send_request("typescript")
	nameofTech = "TypeScript"

func _on_unicon_button_down():
	send_request("unicon")
	nameofTech = "Unicon"

func _on_visual_basic_button_down():
	send_request("visual_basic")
	nameofTech = "VisualBasic"

func _on_web_gl_button_down():
	send_request("webgl")
	nameofTech = "WebGL"

func _on_xojo_button_down():
	send_request("xojo")
	nameofTech = "Xojo"

func _on_yorick_button_down():
	send_request("yorick")
	nameofTech = "Yorick"

func _on_zig_button_down():
	send_request("zig")
	nameofTech = "Zig"

func send_request(language: String):
	http_request.cancel_request()
	var url = TECH_URL + "?name=" + language
	http_request.request(url)
							 
func _on_request_completed(_result, _response_code, _headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	if data == null:
		$"../ErrorDivide/Erro".show()
		$"../ErrorDivide/Erro/Timer".start()

	else:
		var side_menu = $"../../../Side"
		side_menu.show()
		popup(data)
	
	http_request.cancel_request()
	recommendations_received.emit(data)
	
