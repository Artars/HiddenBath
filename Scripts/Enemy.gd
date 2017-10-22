extends Node2D

export var speed = 2
enum {STATIONARY = 0, PATROL, LOOKAROUND}
export(int, 0, 2) var behaviour
export var hasAnimation = true
var playerSeen = false
var frontDirection = Vector2(0,-1)
var playerNode = null
var offset
var firstRot
var spawnPos
var direction = 1
var animator

func updateFront():
	frontDirection = Vector2(0,-1).rotated(get_rot())

func turnTo(direction):
	var angle = frontDirection.angle_to(direction)
	frontDirection = frontDirection.rotated(angle)
	set_rot(get_rot() + angle)

func _ready():
	firstRot = get_rotd()
	spawnPos = get_pos()
	offset = 0 if behaviour == LOOKAROUND else 0.5
	if behaviour == PATROL:
		get_node("Path2D/PathFollow2D").set_unit_offset(offset)
	updateFront()
	add_to_group("Enemies")
	playerSeen = false
	
	#take animation referecnce
	if(hasAnimation):
		animator = get_node("AnimatedSprite")
		animator.play("Idle")
	set_process(true)

func _process(delta):
	if playerSeen:
		if(hasAnimation):
			animator.play("Running")
		var direction = playerNode.get_pos() - get_pos()
		direction = direction.normalized()
		turnTo(direction)
		set_pos(get_pos() + (direction * speed))
	else:
		if behaviour == STATIONARY:
			pass
		elif behaviour == PATROL:
			if(hasAnimation):
				animator.play("Running")
			var oldOffset = get_node("Path2D/PathFollow2D").get_offset()
			var newOffset = oldOffset + speed * direction
			get_node("Path2D/PathFollow2D").set_offset(newOffset)
			
			offset = get_node("Path2D/PathFollow2D").get_unit_offset()
			if offset >= 1 or offset <= 0:
				offset = 1 if offset >= 1 else 0
				get_node("Path2D/PathFollow2D").set_unit_offset(offset)
				direction = -1 * direction
				set_rotd(get_rotd() + 180)
			
			var deltaPos = newOffset - oldOffset
			set_pos(get_pos() + deltaPos * frontDirection)
		elif behaviour == LOOKAROUND:
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
	firstRot = get_rotd()
	spawnPos = get_pos()
	offset = 0 if behaviour == LOOKAROUND else 0.5
	if behaviour == PATROL:
		get_node("Path2D/PathFollow2D").set_unit_offset(offset)
	updateFront()
	playerSeen = false

func _on_Area2D_2_body_enter( body ):
	if body.get_name() == "Player" and playerSeen:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
