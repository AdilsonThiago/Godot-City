extends Node

var nivelProcurado = 1

var objPersonagem = null

@onready var personagem = preload("res://Personagem.tscn")

func ponteiroPerson(obj):
	objPersonagem = obj
	pass
