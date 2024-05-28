extends VehicleBody3D

func _ready():
	set_process_input(false)
	pass

func ativarControle():
	set_process_input(true)
	$Clipe/SpringArm3D/Camera3D.current = true
	pass

func _input(event):
	if event.is_action_pressed("ui_up"):
		engine_force = 130
	elif event.is_action_released("ui_up"):
		engine_force = 0
	if event.is_action_pressed("ui_down"):
		brake = 3
		engine_force = -360
	elif event.is_action_released("ui_down"):
		brake = 0
		engine_force = 0
	
	if event.is_action_pressed("ui_right"):
		steering = -deg_to_rad(25)
	if event.is_action_pressed("ui_left"):
		steering = deg_to_rad(25)
	elif  event.is_action_released("ui_right") or event.is_action_released("ui_left"):
		steering = 0
	
	if event.is_action_pressed("ui_accept"):
		var obj = Singleton.personagem.instantiate()
		get_parent().add_child(obj)
		obj.position = position + Vector3(0, 1, 0)
		set_process_input(false)
		$Clipe/SpringArm3D/Camera3D.current = true

	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	pass
