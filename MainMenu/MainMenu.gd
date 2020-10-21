extends CanvasLayer

func _ready()->void:
	get_tree().get_nodes_in_group("MainMenu")[0].grab_focus()					
	#Godot doesn't have buttons auto grab_focus when noone has focus

func on_options(value:bool)->void:
	if !value && !MenuEvent.Paused:
		get_tree().get_nodes_in_group("MainMenu")[0].grab_focus()

# Touch controls

func _on_ButtonB_pressed():
	var a1 = InputEventAction.new()
	a1.action = "ui_accept"
	a1.pressed = true
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "Primary"
	a2.pressed = true
	Input.parse_input_event(a2)

func _on_ButtonB_released():
	var a1 = InputEventAction.new()
	a1.action = "ui_accept"
	a1.pressed = false
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "Primary"
	a2.pressed = false
	Input.parse_input_event(a2)

func _on_ButtonA_pressed():
	var a1 = InputEventAction.new()
	a1.action = "Secondary"
	a1.pressed = true
	Input.parse_input_event(a1)

func _on_ButtonA_released():
	var a1 = InputEventAction.new()
	a1.action = "Secondary"
	a1.pressed = false
	Input.parse_input_event(a1)

func _on_ButtonDown_pressed():
	var a1 = InputEventAction.new()
	a1.action = "Down"
	a1.pressed = true
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "ui_down"
	a2.pressed = true
	Input.parse_input_event(a2)

func _on_ButtonDown_released():
	var a1 = InputEventAction.new()
	a1.action = "Down"
	a1.pressed = false
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "ui_down"
	a2.pressed = false
	Input.parse_input_event(a2)
	Input.action_release("Down")
	Input.action_release("ui_down")


func _on_ButtonUp_pressed():
	var a1 = InputEventAction.new()
	a1.action = "Up"
	a1.pressed = true
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "ui_up"
	a2.pressed = true
	Input.parse_input_event(a2)

func _on_ButtonUp_released():
	var a1 = InputEventAction.new()
	a1.action = "Up"
	a1.pressed = false
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "ui_up"
	a2.pressed = false
	Input.parse_input_event(a2)

func _on_ButtonLeft_pressed():
	var a1 = InputEventAction.new()
	a1.action = "Left"
	a1.pressed = true
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "ui_left"
	a2.pressed = true
	Input.parse_input_event(a2)

func _on_ButtonLeft_released():
	var a1 = InputEventAction.new()
	a1.action = "Left"
	a1.pressed = false
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "ui_left"
	a2.pressed = false
	Input.parse_input_event(a2)

func _on_ButtonRight_pressed():
	var a1 = InputEventAction.new()
	a1.action = "Right"
	a1.pressed = true
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "ui_right"
	a2.pressed = true
	Input.parse_input_event(a2)

func _on_ButtonRight_released():
	var a1 = InputEventAction.new()
	a1.action = "Right"
	a1.pressed = false
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "ui_right"
	a2.pressed = false
	Input.parse_input_event(a2)

func _on_ButtonStart_pressed():
	var a1 = InputEventAction.new()
	a1.action = "Pause"
	a1.pressed = true
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "ui_cancel"
	a2.pressed = true
	Input.parse_input_event(a2)
	Input.action_press("Pause")
	Input.action_press("ui_cancel")


func _on_ButtonStart_released():
	var a1 = InputEventAction.new()
	a1.action = "Pause"
	a1.pressed = false
	Input.parse_input_event(a1)
	var a2 = InputEventAction.new()
	a2.action = "ui_cancel"
	a2.pressed = false
	Input.parse_input_event(a2)
	Input.action_release("Pause")
	Input.action_release("ui_cancel")
