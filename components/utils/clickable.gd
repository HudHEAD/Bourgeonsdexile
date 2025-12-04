extends Area2D

func _ready() -> void:
	input_event.connect(_on_area_2d_input_event)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("select_element"):
		_action_on_click()

func _action_on_click():
	print("clicked!")
