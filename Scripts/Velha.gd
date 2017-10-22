extends Node2D

export var speed = 2
export(int, 0, 2) var behaviour
var playerSeen = false
var frontDirection = Vector2(0,-1)
var bulletSpeed = 2000
var playerNode = null
var offset = 0
var firstRot
var spawnPos
var preBullet = preload("res://Scenes/Bullet.tscn")
export var delay = 2
export var charge = 0.3
var direction = Vector2(0,0)
var time = 0
var canShot = true

func updateFront():
	frontDirection = Vector2(0,-1).rotated(get_rot())

func turnTo(direction):
	var angle = frontDirection.angle_to(direction)
	frontDirection = frontDirection.rotated(angle)
	set_rot(get_rot() + angle)

func _ready():
	firstRot = get_rotd()
	spawnPos = get_pos()
	offset = 0.5
	updateFront()
	add_to_group("Enemies")
	playerSeen = false
	set_process(true)

func _process(delta):
	if playerSeen:
		if time < delay:
			direction = playerNode.get_pos() - get_pos() + Vector2(0, offset)
			direction = direction.normalized()
			turnTo(direction)
		else:
			#change animation
			if time >= delay + charge && canShot:
				var bullet = preBullet.instance()
				bullet.set_pos(get_pos())
				get_owner().add_child(bullet)
				bullet.LockAndFire(direction, bulletSpeed)
				canShot = false
			elif time >= delay + 1.7 * charge:
				time = 0
				canShot = true
		time += delta
	pass
		
func _on_Area2D_body_enter( body ):
	if body.get_name() == "player" and not playerSeen:
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
	offset =  0.5
	updateFront()
	playerSeen = false