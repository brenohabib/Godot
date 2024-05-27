extends  Control

func _ready():
	# Itera sobre os filhos diretos do nó pai
	for hbox in get_children():
		if hbox is HBoxContainer:
			# Itera sobre os filhos do HBoxContainer
			for checkbox in hbox.get_children():
				if checkbox is CheckBox:
					# Conecta o sinal 'toggled' ao método '_on_checkbox_toggled' com a checkbox como argumento
					checkbox.connect("toggled", Callable(self, "_on_checkbox_toggled").bind(checkbox), 0)

# Função para tratar os sinais toggled
func _on_checkbox_toggled(button_pressed: bool, caller: CheckBox):
	var hbox = caller.get_parent() as HBoxContainer
	
	if button_pressed:
		for checkbox in hbox.get_children():
			if checkbox is CheckBox and checkbox != caller:
				checkbox.button_pressed = false
