extends CharacterBody3D

const SPEED = 3.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var sensibilidade = 0.2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Singleton.objPersonagem = self
	pass

func _input(event):
	if event is InputEventMouseMotion:
		var atualAngulo = $Grampo.rotation.x
		rotate_y(- deg_to_rad(event.relative.x) * sensibilidade)
		atualAngulo += - deg_to_rad(event.relative.y) * sensibilidade
		atualAngulo = clamp(atualAngulo, deg_to_rad(- 90), deg_to_rad(90))
		$Grampo.rotation.x = atualAngulo
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	pass

func interacao():
	var objdentroarea = $"Root Scene/Area3D".get_overlapping_bodies()
	for obj in objdentroarea:
		if obj.is_in_group("veiculo"):
			obj.ativarControle()
			Singleton.ponteiroPerson(obj)
			queue_free()
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		interacao()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if Input.is_action_pressed("b_correr"):
			velocity.x = direction.x * SPEED * 2
			velocity.z = direction.z * SPEED * 2
			$"Root Scene/AnimationPlayer".play("correndo")
		else:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			$"Root Scene/AnimationPlayer".play("andando")
		$"Root Scene".look_at(Vector3(velocity.x, 0, velocity.z) * 50)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		$"Root Scene/AnimationPlayer".play("parado")

	move_and_slide()
	pass
