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

###TAGS
##Category
@onready var progammingLanguageTag : Button = $"../Tags/Category/programmingLanguage"
@onready var frameworkTag : Button = $"../Tags/Category/framework"
@onready var frontendTag : Button = $"../Tags/Category/frontend"
@onready var toolkitTag : Button = $"../Tags/Category/toolkit"

## Popularity
@onready var HighTagP : Button = $"../Tags/Popularity/High"
@onready var MediumTagP : Button = $"../Tags/Popularity/Medium"
@onready var LowTagP : Button = $"../Tags/Popularity/Low"

##Difficulty

@onready var HighTagD : Button = $"../Tags/Difficulty/High"
@onready var MediumTagD : Button = $"../Tags/Difficulty/Medium"
@onready var LowTagD : Button = $"../Tags/Difficulty/Low"

###BOOL
##Category
var progammingLanguageBool : bool = false
var frameworkBool : bool = false
var frontendBool : bool = false
var toolkitBool : bool = false

## Popularity
var HighBoolP : bool = false
var MediumBoolP : bool = false
var LowBoolP : bool = false

##Difficulty

var HighBoolD : bool = false
var MediumBoolD : bool = false
var LowBoolD : bool = false

##PRELOAD

@onready var techDatabase = load("res://menu/TechList.gd") 

func _on_programming_language_toggled(toggled_on):
	if toggled_on == true:
		frameworkTag.button_pressed = false
		frontendTag.button_pressed = false
		toolkitTag.button_pressed = false
		progammingLanguageBool = true
	else:
		progammingLanguageBool = false
		
func _on_framework_toggled(toggled_on):
	if toggled_on == true:
		progammingLanguageTag.button_pressed = false
		frontendTag.button_pressed = false
		toolkitTag.button_pressed = false
		frameworkBool = true
	else:
		frameworkBool = false
func _on_frontend_toggled(toggled_on):
	if toggled_on == true:
		progammingLanguageTag.button_pressed = false
		frameworkTag.button_pressed = false
		toolkitTag.button_pressed = false
		frontendBool = true
	else:
		frontendBool = false
func _on_toolkit_toggled(toggled_on):
	if toggled_on == true:
		progammingLanguageTag.button_pressed = false
		frameworkTag.button_pressed = false
		frontendTag.button_pressed = false
		toolkitBool = true
	else:
		toolkitBool = false
func _on_high_toggled(toggled_on):
	if toggled_on == true:
		MediumTagP.button_pressed = false
		LowTagP.button_pressed = false
		HighBoolP = true
		
	else:
		HighBoolP = false
		
func _on_medium_toggled(toggled_on):
	if toggled_on == true:
		HighTagP.button_pressed = false
		LowTagP.button_pressed = false
		MediumBoolP = true
		
	else:
		MediumBoolP = false
		
func _on_low_toggled(toggled_on):
	if toggled_on == true:
		HighTagP.button_pressed = false
		MediumTagP.button_pressed = false
		LowBoolP = true
	else:
		LowBoolP = false
func _on_high_difficulty_toggled(toggled_on):
	if toggled_on == true:
		MediumTagD.button_pressed = false
		LowTagD.button_pressed = false
		HighBoolD = true
		
	else:
		HighBoolD = false
func _on_medium_difficulty_toggled(toggled_on):
	if toggled_on == true:
		HighTagD.button_pressed = false
		LowTagD.button_pressed = false
		MediumBoolD = true
		
	else:
		MediumBoolD = false
func _on_low_difficulty_toggled(toggled_on):
	if toggled_on == true:
		HighTagD.button_pressed = false
		MediumTagD.button_pressed = false
		LowBoolD = true
	else:
		LowBoolD = false
		
@onready var tags : VBoxContainer = $"../Tags/Tech/Tags"
func _on_search_button_down():
	
	disable()
	
	for child in tags.get_children():
		var techInfo = techDatabase.DATA[techDatabase.get(child.text)]
		if progammingLanguageBool == true and techInfo[0] != "programming_language":
			child.hide()
		elif frameworkBool == true and techInfo[0] != "framework":
			child.hide()
		elif frontendBool == true and techInfo[0] != "frontend":
			child.hide()
		elif toolkitBool == true and techInfo[0] != "toolkit":
			child.hide()
		
		elif HighBoolP == true and techInfo[1] != "high":
			child.hide()
		elif MediumBoolP == true and techInfo[1] != "medium":
			child.hide()
		elif LowBoolP == true and techInfo[1] != "low":
			child.hide()
		
		elif HighBoolD == true and techInfo[2] != "high":
			child.hide()
		elif MediumBoolD == true and techInfo[2] != "medium":
			child.hide()
		elif LowBoolD == true and techInfo[2] != "low":
			child.hide()


func _on_reset_focus_entered():
	enable()
	for child in tags.get_children():
		child.show()


@onready var categoryTags : HBoxContainer = $"../Tags/Category"
@onready var popularityTags : HBoxContainer = $"../Tags/Popularity"
@onready var difficultyTags : HBoxContainer = $"../Tags/Difficulty"

func disable():
	for child in categoryTags.get_children():
		if child.get_class() != "Label":
			child.disabled = true
	for child in popularityTags.get_children():
		if child.get_class() != "Label":
			child.disabled = true
	for child in difficultyTags.get_children():
		if child.get_class() != "Label":
			child.disabled = true
	
func enable():
	for child in categoryTags.get_children():
		if child.get_class() != "Label":
			child.disabled = false
	for child in popularityTags.get_children():
		if child.get_class() != "Label":
			child.disabled = false
	for child in difficultyTags.get_children():
		if child.get_class() != "Label":
			child.disabled = false
	
