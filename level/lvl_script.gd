extends Node

@export var bgm: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _start_level() -> void:
	get_tree().paused = false
	$PauseUI.hide()
	$PauseButton.show()
	$Player.play("idle")
	bgm.play()

func _on_pause_ui_restart() -> void:
	_start_level()


func _on_pause_ui_resume() -> void:
	get_tree().paused = false
	$PauseButton.show()
	$PauseUI.hide()


func _on_pause_ui_return_to_menu() -> void:
	get_tree().change_scene_to_file("res://level/title.tscn")


func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	$PauseButton.hide()
	$PauseUI.show()
