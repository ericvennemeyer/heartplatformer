extends CenterContainer

@onready var menu_button = %MenuButton


func _ready():
	menu_button.grab_focus()
	LevelTransition.fade_from_black()


func _on_menu_button_pressed():
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://start_menu.tscn")
