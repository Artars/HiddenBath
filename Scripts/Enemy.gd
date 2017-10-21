extends Node2D

export var speed = 10
export var playerSeen = false
var playerNode

func _ready():
	add_to_group("Enemies")
	playerSeen = false
	set_process(true)

func _process(delta):
	if playerSeen:
		var direction = playerNode.get_pos() - get_pos()
		direction = direction.normalized()
		set_pos(get_pos() + (direction * speed))
	else:
		pass

func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player" and not playerSeen:
		GameManager.foundPlayer()

func followPlayer( player ):
	print("Chamou followPlayer")
	playerNode = player
	playerSeen = true