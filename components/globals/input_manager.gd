extends Node

##How sensitive is mouse movement
var mouse_sensitivity = 5.0

##Accumulator for tracking mouse movement
var mouse_acc : Vector2 = Vector2.ZERO

func _unhandled_input(event) -> void:
	_handle_mouse_movement(event)
	
## Update mouse accumulator, with smoothing
func _handle_mouse_movement(event):
	if event is InputEventMouseMotion :
		var viewport_transform: Transform2D = get_tree().root.get_final_transform()
		var xformed_event = event.xformed_by(viewport_transform).relative
		mouse_acc = mouse_acc.lerp(xformed_event, 0.1)

## Return mouse displacement
func get_mouse_movement() -> Vector2:
	var result = mouse_acc * mouse_sensitivity
	clear_mouse_movement()
	return result

func clear_mouse_movement():
	mouse_acc = Vector2.ZERO
