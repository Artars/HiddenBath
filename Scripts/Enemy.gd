extends Node2D

export var speed = 2
enum Behaviour {STATIONARY = 0, PATROL, LOOKAROUND}
export(int, 0, 2) var behaviour
var playerSeen = false
var frontDirection = Vector2(0,-1)
var playerNode = null
var offset
var firstRot
var direction = 1

func updateFront():
	frontDirection = Vector2(0,-1).rotated(get_rot())

func turnTo(direction):
	var angle = frontDirection.angle_to(direction)
	frontDirection = frontDirection.rotated(angle)
	set_rot(get_rot() + angle)

func _ready():
	firstRot = get_rotd()
	offset = 0 if behaviour == 3 else get_node("Path2D/PathFollow2D").get_unit_offset()
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
		if behaviour == 0:
			pass
		elif behaviour == 1:
			offset = get_node("Path2D/PathFollow2D").get_unit_offset()
			var newOffset = get_node("Path2D/PathFollow2D").get_offset() + speed * direction
			get_node("Path2D/PathFollow2D").set_offset(newOffset)
			
			if offset >= 1 or offset <= -1:
				direction = -1 * direction
				set_rotd(get_rotd() + 180)
		elif behaviour == 2:
			offset += direction
			set_rotd(firstRot + offset)
			if offset >= 90 or offset <= -90:
				direction = -1 * direction

func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player" and not playerSeen:
		GameManager.foundPlayer()

func followPlayer( player ):
	print("Chamou followPlayer")
	updateFront()
	if playerNode == null:
		playerNode = player
	playerSeen = true

func missedPlayer():
	playerSeen = false