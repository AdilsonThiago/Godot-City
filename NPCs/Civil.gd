extends CharacterBody3D

const SPEED = 3.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var precisoCorrer = false
var atualizar = 0.0
var direction = Vector3(0, 0, 0)

func _ready():
	pass

func interacao():
	var objdentroarea = $"Root Scene/Area3D".get_overlapping_bodies()
	for obj in objdentroarea:
		if obj.is_in_group("veiculo"):
			obj.ativarControle()
			queue_free()
	pass

func estaNoMeioRua():
	var rua = Singleton.ruaMaisProxima(position)
	return position.distance_to(rua.position) < 7.0
	pass

func _physics_process(delta):
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if estaNoMeioRua():
		var rua = Singleton.ruaMaisProxima(position)
		direction = -position.direction_to(rua.position)
	if atualizar > 0:
		atualizar -= delta
	else:
		visible = position.distance_to(Singleton.objPersonagem.position) < 40
		if randf_range(0, 1) < 0.4:
			direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
		else:
			direction = Vector3.ZERO
		direction.y = 0
		atualizar = 1
	
	if direction:
		if precisoCorrer:
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

