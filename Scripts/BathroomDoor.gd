extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_BathroomDoor_body_enter( body ):
	print("Passou pela porta: ", body.get_name())
	if body.get_name() == "Player":
		GameManager.changeGameMode()
	pass # replace with function body
