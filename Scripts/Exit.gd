extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Exit_body_enter( body ):
	if body.get_name() == "Player":
		if not body.inital_run:
			get_tree().change_scene("res://Scenes/Victory.tscn")