extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuMargin.hide()
	$LevelSelectionMargin.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _show_menu() -> void:
	$TitleMargin/VBoxContainer/StartButton.hide()
	$LevelSelectionMargin.hide()
	$MenuMargin.show()

func _show_level_selection() -> void:
	$TitleMargin/VBoxContainer/StartButton.hide()
	$LevelSelectionMargin.show()
	$MenuMargin.hide()

func _on_start_button_pressed() -> void:
	_show_menu()

func _on_play_button_pressed() -> void:
	_show_level_selection()

func _on_back_button_pressed() -> void:
	_show_menu()


func _on_level_selection_button_1_pressed() -> void:
	get_tree().change_scene_to_file("res://level/lvl_01.tscn")
