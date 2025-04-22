extends MarginContainer

signal resume
signal restart
signal return_to_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_resume_button_pressed() -> void:
	resume.emit()


func _on_restart_button_pressed() -> void:
	restart.emit()


func _on_return_button_pressed() -> void:
	return_to_menu.emit()
