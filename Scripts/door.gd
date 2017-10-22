extends Node2D

func _ready():
	add_to_group("door")
	set_process(true)
	pass

func interact():
	print("open door")
	pass

func _on_Area2D_body_enter( body ):
	if body.is_in_group("player"):
		print("ABRE DISRAÇAAAA!!!")
	pass # replace with function body