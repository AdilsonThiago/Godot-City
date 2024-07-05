extends Node

var nivelProcurado = 1

var objPersonagem = null

var arrRuas

@onready var personagem = preload("res://Personagem.tscn")

func _ready():
	arrRuas = get_tree().get_nodes_in_group("rua")
	pass

func ruaMaisProxima(pos):
	var rua = null
	var maxDist = 1000.0
	for obj in arrRuas:
		if obj.position.distance_to(pos) < maxDist:
			rua = obj
			maxDist = obj.position.distance_to(pos)
	return rua
	pass

func ponteiroPerson(obj):
	objPersonagem = obj
	pass
