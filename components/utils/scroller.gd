## This script makes it possible to scroll on a 2D element by click and dragging anywhere on the screen.

extends Node2D

@export_category("Scrolling parameters")
@export var lock_x : bool = false
@export var lock_y : bool = false

#TODO put in InputManager
var mouse_sensitivity = 5.0

#Current state
var dragging : bool = false
#Accumulator for mouse offset
var mouse_acc : Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	if dragging:
		var offset = _get_offset()
		self.position += offset

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select_element"):
		_start_dragging()
	elif event.is_action_released("select_element"):
		_stop_dragging()

## Triggers scrolling behavior
func _start_dragging():
	#Clear accumulated value to prevent jitter
	mouse_acc = Vector2.ZERO
	dragging = true

## Triggers scrolling behavior
func _stop_dragging():
	dragging = false

## Returns offset to apply, taking into account locked axis
func _get_offset() -> Vector2:
	var offset = _mouse_look()
	if lock_x:
		offset.x = 0.0
	if lock_y:
		offset.y = 0.0
	
	return offset

#TODO put in InputManager

func _unhandled_input(event) -> void:
	_handle_mouse_movement(event)
	
## Update mouse accumulator, with smoothing
func _handle_mouse_movement(event):
	if event is InputEventMouseMotion :
		var viewport_transform: Transform2D = get_tree().root.get_final_transform()
		var xformed_event = event.xformed_by(viewport_transform).relative
		mouse_acc = mouse_acc.lerp(xformed_event, 0.1)

## Return mouse look vector
func _mouse_look() -> Vector2:
	var result = mouse_acc * mouse_sensitivity
	mouse_acc = Vector2.ZERO
	return result
