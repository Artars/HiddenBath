extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var spriteNode
var playerRef
var timer = 0

func _ready():
	spriteNode = get_node("Sprite")
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player":
		body.set_process(false)
		body.hide()
		get_node("Sprite").set_frame(1)
		GameManager.respawnEnemies()
		get_owner().get_node("Camera2D").rotate(1)
		playerRef = body
		timer = 1
		set_process(true)
	pass # replace with function body

func _process(delta):
	timer -= delta
	if(timer <= 0):
		set_process(false)
		make_player_movable()

func make_player_movable():
	playerRef.show()
	get_node("Sprite").set_frame(0)
	playerRef.set_process(true)