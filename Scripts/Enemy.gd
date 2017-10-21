extends Node2D

export var speed = 10
export var playerSeen = false
export var frontDirection = Vector2(0,-1)
var playerNode = null

func updateFront():
	frontDirection = Vector2(0,-1).rotated(get_rot())

func turnTo(direction):
	var angle = frontDirection.angle_to(direction)
	frontDirection = frontDirection.rotated(angle)
	set_rot(get_rot() + angle)

func _ready():
	updateFront()
	add_to_group("Enemies")
	playerSeen = false
	set_process(true)

func _process(delta):
	if playerSeen:
		var direction = playerNode.get_pos() - get_pos()
		direction = direction.normalized()
		turnTo(direction)
		set_pos(get_pos() + (direction * speed))
	else:
		pass

func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player" and not playerSeen:
		GameManager.foundPlayer()

func followPlayer( player ):
	print("Chamou followPlayer")
	if playerNode == null:
		playerNode = player
	playerSeen = true

func missedPlayer():
	playerSeen = false