extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var rank = 1
var broken = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	add_to_group("Objects")
	pass


func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player":
		if body.moveType == 0:
			broken = true
			get_child(1).set_frame(1)

func spawn_enemies():
	if broken:
		var enemy = preload("res://Scenes/Enemy.tscn").instance()
		enemy.rotate(rand_range(0, 2*PI))
		enemy.updateFront()
